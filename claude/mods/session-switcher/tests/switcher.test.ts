import type { ProcessRunResult } from 'claude-code'
import { expect, test } from 'claude-code/testing'
import type { TestBody } from 'claude-code/testing'

const HOME = '/Users/someone'
const SESSIONS_DIR = `${HOME}/.claude/sessions`

const sessionFiles: Record<string, object> = {
  '100.json': { pid: 100, sessionId: 'aaaa1111', cwd: `${HOME}/code/api`, name: 'api-1', status: 'busy', kind: 'interactive' },
  '200.json': { pid: 200, sessionId: 'bbbb2222', cwd: `${HOME}/code/web`, name: 'web-1', status: 'idle', kind: 'interactive' },
  '300.json': { pid: 300, sessionId: 'cccc3333', cwd: `${HOME}/code/web`, name: 'gone', status: 'idle', kind: 'interactive' },
  '400.json': { pid: 400, sessionId: 'dddd4444', cwd: `${HOME}/code/api`, name: 'spare', status: 'idle', kind: 'bg' },
}

const TITLE_RECORDS = [
  '{"type":"ai-title","aiTitle":"Old guess","sessionId":"aaaa1111"}',
  '{"type":"custom-title","customTitle":"Fix the fee calculator","sessionId":"aaaa1111"}',
  '{"type":"ai-title","aiTitle":"Newer guess","sessionId":"aaaa1111"}',
].join('\n')

type TmuxWorld = { ps: string; panes: string; clients: string }

const MAC_TMUX: TmuxWorld = {
  ps: '  100 ttys013\n  200 ttys014\n  300 ttys020\n',
  panes: '/dev/ttys013\twork\t@0\t%0\n/dev/ttys014\tside\t@3\t%5\n',
  clients: '/dev/ttys010\twork\n',
}

const LINUX_TMUX: TmuxWorld = {
  ps: '  100 pts/1\n  200 pts/2\n  300 ?\n',
  panes: '/dev/pts/1\twork\t@0\t%0\n/dev/pts/2\tside\t@3\t%5\n',
  clients: '/dev/pts/0\twork\n',
}

const ran = (exitCode: number, stdout: string): { value: ProcessRunResult } => ({
  value: { exitCode, stdout, stderr: '', isStdoutTruncated: false, isStderrTruncated: false },
})

const ok = (stdout: string) => ran(0, stdout)

const stubSessions = (on: Parameters<TestBody>[1], world: TmuxWorld, tmuxCommands: string[][]) => {
  on('fs.list', async () => ({
    value: Object.keys(sessionFiles).map(name => ({ name, kind: 'file', size: 1, mtimeMs: 0, isLink: false }) as never),
  }))
  on('fs.read', async (_, e) => ({ value: JSON.stringify(sessionFiles[e.path.slice(SESSIONS_DIR.length + 1)]) }))
  on('session.id', async () => ({ value: 'aaaa1111' }))
  on('ui.open', async () => ({ value: {} as never }))
  on('ui.close', async () => ({ value: undefined }))
  on('process.run', async (_, e) => {
    const [command, ...rest] = e.argv
    if (command === 'sh') return ok(HOME)
    if (command === 'ps') return ok(world.ps)
    if (command === 'grep') {
      const isApi = (rest.at(-1) as string).endsWith('/-Users-someone-code-api/aaaa1111.jsonl')

      return isApi ? ok(TITLE_RECORDS) : ran(1, '')
    }
    tmuxCommands.push([...rest])
    if (rest[0] === 'list-panes') return ok(world.panes)
    if (rest[0] === 'list-clients') return ok(world.clients)

    return ok('')
  })
}

for (const [platform, world, clientTty] of [
  ['macOS', MAC_TMUX, '/dev/ttys010'],
  ['Linux', LINUX_TMUX, '/dev/pts/0'],
] as const) {
  for (const surface of ['terminal', 'desktop'] as const) {
    test(`lists the sessions in tmux panes and switches to the picked pane on ${platform}, ${surface}`, async ($, on) => {
      const tmuxCommands: string[][] = []
      stubSessions(on, world, tmuxCommands)

      await $.command.run({ command: 'sessions', args: '' } as never)
      const pane = await $.ui.mount({ plugin: 'session-switcher', surface, component: 'Pane', props: {} as never, requestId: 'sessions' })
      const rows = await pane.findAll({ type: 'Button' })
      await pane.press({ key: 'session:200' })

      expect(rows.map(row => row.key)).toEqual(['session:100', 'session:200'])
      expect(await pane.find({ text: '(this session)' })).toBeDefined()
      expect(await pane.find({ type: 'Text', text: 'Fix the fee calculator' })).toBeDefined()
      expect(await pane.find({ type: 'Text', text: 'Newer guess' })).toBeUndefined()
      expect((await pane.find({ key: 'row:100' }))?.props.backgroundColor).toBe('diffAdded')
      expect((await pane.find({ key: 'row:200' }))?.props.backgroundColor).toBeUndefined()
      expect(await pane.find({ text: 'gone' })).toBeUndefined()
      expect(tmuxCommands.at(-1)).toEqual([
        'switch-client', '-c', clientTty, '-t', 'side',
        ';', 'select-window', '-t', '@3',
        ';', 'select-pane', '-t', '%5',
      ])
    })
  }
}

test('lists no sessions when no tmux server runs', async ($, on) => {
  stubSessions(on, { ...MAC_TMUX, panes: '' }, [])

  await $.command.run({ command: 'sessions', args: '' } as never)
  const pane = await $.ui.mount({ plugin: 'session-switcher', surface: 'terminal', component: 'Pane', props: {} as never, requestId: 'sessions' })

  expect(await pane.findAll({ type: 'Button' })).toEqual([])
  expect(await pane.find({ text: 'No Claude sessions running in tmux.' })).toBeDefined()
})

test('tells how to attach when this session is not in tmux', async ($, on) => {
  const tmuxCommands: string[][] = []
  const toasts: string[] = []
  stubSessions(on, { ...MAC_TMUX, ps: '  100 ttys020\n  200 ttys014\n' }, tmuxCommands)
  on('ui.toast', async (_, e) => {
    toasts.push(e.text)

    return { value: undefined }
  })

  await $.command.run({ command: 'sessions', args: '' } as never)
  const pane = await $.ui.mount({ plugin: 'session-switcher', surface: 'terminal', component: 'Pane', props: {} as never, requestId: 'sessions' })
  await pane.press({ key: 'session:200' })

  expect(toasts).toEqual(['This session is not in tmux. Open web-1 with: tmux attach -t side'])
  expect(tmuxCommands.some(argv => argv[0] === 'switch-client')).toBe(false)
})

test('the bar button opens the list, then closes it', async ($, on) => {
  const openPanes: string[] = []
  on('fs.list', async () => ({ value: [] }))
  on('session.id', async () => ({ value: 'aaaa1111' }))
  on('process.run', async () => ok(HOME))
  on('ui.panes', async () => ({ value: openPanes.map(id => ({ id }) as never) }))
  on('ui.open', async (_, e) => {
    openPanes.push(e.id)

    return { value: {} as never }
  })
  on('ui.close', async () => {
    openPanes.length = 0

    return { value: undefined }
  })
  on('ui.render', { component: 'AbovePrompt' }, async ($, e) => {
    const { Text } = $.ui.resolve(e)

    return Text({ children: 'another mod' })
  })
  const bar = await $.ui.mount({ plugin: 'session-switcher', surface: 'terminal', component: 'AbovePrompt', props: {} as never })

  await bar.press({ key: 'toggle-sessions' })
  const afterOpen = [...openPanes]
  await bar.press({ key: 'toggle-sessions' })

  expect(await bar.find({ text: 'another mod' })).toBeDefined()
  expect(afterOpen).toEqual(['sessions'])
  expect(openPanes).toEqual([])
})
