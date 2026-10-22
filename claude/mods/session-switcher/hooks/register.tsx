import { atom, read, update } from 'claude-code'
import type { EngineInterface as Engine, Register, RenderElement, RenderNode } from 'claude-code'

import type { LiveSession } from '../types'

const PANE = 'sessions'
const BAND = 'mod-band'
const BAND_ROW = 'mod-band-row'
const BAND_ITEM = 'mod-band:sessions'
const BAND_ORDER = ['mod-band:context-bars', 'mod-band:model-effort', 'mod-band:sessions']
const SESSIONS_DIR = '~/.claude/sessions'
const sessions = atom({ plugin: 'session-switcher', key: 'sessions' } as const, [])

const keyOf = (node: RenderNode): unknown =>
  typeof node === 'string' ? undefined : (node as { props?: { key?: unknown } }).props?.key

const childrenOf = (node: RenderNode): RenderNode[] =>
  typeof node === 'string' ? [] : ((node as { children?: RenderNode[] }).children ?? [])

const isEmptyBox = (node: RenderNode) =>
  typeof node !== 'string' && node.type === 'Box' && keyOf(node) === undefined && childrenOf(node).length === 0

const rankOf = (node: RenderNode) => {
  const rank = BAND_ORDER.indexOf(keyOf(node) as string)

  return rank === -1 ? BAND_ORDER.length : rank
}

const bandParts = (band: RenderElement | null | undefined) => {
  if (band == null || isEmptyBox(band)) return { above: [], items: [] }
  if (keyOf(band) !== BAND) return { above: [], items: [band] }
  const children = childrenOf(band)
  const row = children.find(child => keyOf(child) === BAND_ROW)

  return { above: children.filter(child => child !== row), items: row === undefined ? [] : childrenOf(row) }
}

type SessionFile = {
  pid: number
  sessionId: string
  cwd: string
  name?: string
  status?: string
  kind?: string
}

const homeOf = async ($: Engine) =>
  (await $.process.run(['sh', '-c', 'printf %s "$HOME"'])).stdout

const ttysByPid = async ($: Engine, pids: number[]) => {
  const ran = await $.process.run(['ps', '-o', 'pid=,tty=', '-p', pids.join(',')])
  const ttys = new Map<number, string>()
  for (const line of ran.stdout.split('\n')) {
    const [pid, tty] = line.trim().split(/\s+/)
    if (pid && tty) ttys.set(Number(pid), `/dev/${tty}`)
  }

  return ttys
}

const shortPath = (path: string, home: string) =>
  path.startsWith(home) ? `~${path.slice(home.length)}` : path

const PROJECTS_DIR = '~/.claude/projects'

const transcriptPath = (home: string, file: SessionFile) =>
  `${PROJECTS_DIR.replace('~', home)}/${file.cwd.replace(/[^a-zA-Z0-9]/g, '-')}/${file.sessionId}.jsonl`

const titleOf = async ($: Engine, home: string, file: SessionFile) => {
  const ran = await $.process.run(['grep', '-hE', '^\\{"type":"(custom|ai)-title"', transcriptPath(home, file)])
  const records = ran.stdout
    .split('\n')
    .filter(line => line !== '')
    .map(line => JSON.parse(line) as { customTitle?: string; aiTitle?: string })
  const custom = records.findLast(record => record.customTitle !== undefined)?.customTitle

  return custom ?? records.findLast(record => record.aiTitle !== undefined)?.aiTitle ?? null
}

type TmuxPane = { tty: string; session: string; windowId: string; paneId: string }
type TmuxClient = { tty: string; session: string }

const tmuxRows = async ($: Engine, argv: string[]) => {
  const ran = await $.process.run(['tmux', ...argv]).catch(() => undefined)
  if (ran === undefined || ran.exitCode !== 0) return []

  return ran.stdout.split('\n').filter(line => line !== '').map(line => line.split('\t'))
}

const tmuxPanes = async ($: Engine): Promise<TmuxPane[]> =>
  (await tmuxRows($, ['list-panes', '-a', '-F', '#{pane_tty}\t#{session_name}\t#{window_id}\t#{pane_id}'])).map(
    ([tty, session, windowId, paneId]) => ({ tty, session, windowId, paneId }) as TmuxPane,
  )

const tmuxClients = async ($: Engine): Promise<TmuxClient[]> =>
  (await tmuxRows($, ['list-clients', '-F', '#{client_tty}\t#{session_name}'])).map(
    ([tty, session]) => ({ tty, session }) as TmuxClient,
  )

const loadSessions = async ($: Engine): Promise<LiveSession[]> => {
  const home = await homeOf($)
  const dir = SESSIONS_DIR.replace('~', home)
  const currentId = await $.session.id()
  const entries = await $.fs.list(dir)
  const files: SessionFile[] = []
  for (const entry of entries) {
    if (!entry.name.endsWith('.json')) continue
    const parsed = await $.fs.read(`${dir}/${entry.name}`).then(
      (text: string | { base64: string }) => JSON.parse(text as string) as SessionFile,
      () => undefined,
    )
    if (parsed && parsed.kind !== 'bg') files.push(parsed)
  }
  if (files.length === 0) return []
  const ttys = await ttysByPid($, files.map(file => file.pid))
  const paneTtys = new Set((await tmuxPanes($)).map(pane => pane.tty))

  const live = files.filter(file => paneTtys.has(ttys.get(file.pid) as string))
  const titles = await Promise.all(live.map(file => titleOf($, home, file)))

  return live
    .map((file, index) => ({
      pid: file.pid,
      name: file.name ?? file.sessionId.slice(0, 8),
      title: titles[index] ?? null,
      cwd: shortPath(file.cwd, home),
      status: file.status ?? 'unknown',
      tty: ttys.get(file.pid) as string,
      isCurrent: file.sessionId === currentId,
    }))
    .sort((left, right) => left.cwd.localeCompare(right.cwd) || left.name.localeCompare(right.name))
}

const openSwitcher = async ($: Engine) => {
  const found = await loadSessions($)
  await update($, sessions, () => found)
  await $.ui.open({
    id: PANE,
    title: 'Claude sessions',
    focus: true,
    closeOnEscape: true,
    holdToasts: true,
    rows: Math.max(3, found.length + 2),
  })
}

const toggleSwitcher = async ($: Engine) => {
  const isOpen = (await $.ui.panes()).some(pane => pane.id === PANE)
  if (isOpen) return $.ui.close({ id: PANE })

  return openSwitcher($)
}

const switchTo = async ($: Engine, session: LiveSession, current: LiveSession | undefined) => {
  await $.ui.close({ id: PANE })
  const panes = await tmuxPanes($)
  const target = panes.find(pane => pane.tty === session.tty)
  if (target === undefined) {
    $.ui.toast(`${session.name} is no longer in a tmux pane`)

    return
  }
  const ownPane = panes.find(pane => pane.tty === current?.tty)
  if (ownPane === undefined) {
    $.ui.toast(`This session is not in tmux. Open ${session.name} with: tmux attach -t ${target.session}`)

    return
  }
  const client = (await tmuxClients($)).find(candidate => candidate.session === ownPane.session)
  if (client === undefined) {
    $.ui.toast(`No tmux client shows session "${ownPane.session}"`)

    return
  }
  await $.process.run([
    'tmux', 'switch-client', '-c', client.tty, '-t', target.session,
    ';', 'select-window', '-t', target.windowId,
    ';', 'select-pane', '-t', target.paneId,
  ])
}

export const register: Register = on => {
  on('session.start', async ($, e, next) => {
    await $.command.register({
      name: 'sessions',
      description: 'Pick a Claude session running in tmux and switch to its pane',
    })

    return next(e)
  })

  on('command.run', { command: 'sessions' }, async $ => {
    await openSwitcher($)

    return { text: 'Session switcher opened.' }
  })

  on('ui.render', { component: 'AbovePrompt' }, async ($, e, next) => {
    if (e.props.hasSurvey) return next(e)
    const { Box, Button } = $.ui.resolve(e)
    const { above, items } = bandParts(await next(e))
    const own = (
      <Box key={BAND_ITEM}>
        <Button key="toggle-sessions" label="Sessions" dimColor onPress={() => toggleSwitcher($)} />
      </Box>
    )
    const sorted = [...items, own].sort((first, second) => rankOf(first) - rankOf(second))

    return (
      <Box key={BAND} flexDirection="column">
        {above}
        <Box key={BAND_ROW} flexDirection="row" gap={1}>
          {sorted}
        </Box>
      </Box>
    )
  })

  on('ui.render', { component: 'Pane', requestId: PANE }, async ($, e) => {
    const { Box, Text, Button } = $.ui.resolve(e)
    const list = await read($, sessions)
    const current = list.find(session => session.isCurrent)

    return (
      <Box flexDirection="column">
        {list.length === 0 && <Text dimColor>No Claude sessions running in tmux.</Text>}
        {list.map((session, index) => (
          <Box
            key={`row:${session.pid}`}
            flexDirection="row"
            gap={1}
            backgroundColor={session.isCurrent ? 'diffAdded' : undefined}
          >
            <Button
              key={`session:${session.pid}`}
              plain
              hotkey={index < 9 ? String(index + 1) : undefined}
              autoFocus={index === 0 ? true : undefined}
              dimColor={session.isCurrent}
              onPress={() => switchTo($, session, current)}
            >
              {session.name}
            </Button>
            {session.title !== null && <Text>{session.title}</Text>}
            <Text dimColor>{session.cwd}</Text>
            <Text color={session.status === 'busy' ? 'yellow' : 'green'}>{session.status}</Text>
            {session.isCurrent && <Text dimColor>(this session)</Text>}
          </Box>
        ))}
        <Text dimColor>number or Enter to switch · Esc to close</Text>
      </Box>
    )
  })
}
