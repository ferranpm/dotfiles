import { atom, read, update } from 'claude-code'
import type { EngineInterface as Engine, Register, RenderElement, RenderNode } from 'claude-code'

import type { ModelChoice } from '../types'

const EFFORTS = ['low', 'medium', 'high', 'xhigh', 'max']

const BAND = 'mod-band'
const BAND_ROW = 'mod-band-row'
const BAND_ITEM = 'mod-band:model-effort'
const BAND_ORDER = ['mod-band:context-bars', 'mod-band:model-effort', 'mod-band:sessions']

const current = atom({ plugin: 'model-effort', key: 'current' } as const, null)
const isPickerOpen = atom({ plugin: 'model-effort', key: 'isPickerOpen' } as const, false)

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

const formatModel = (model: string) => model.replace(/^claude-/, '')

type EffortSettings = { effortLevel?: string; modelSettings?: Record<string, { effortLevel?: string }> }

const effortFromSettings = async ($: Engine, model: string) => {
  const settings = (await $.settings.read()) as EffortSettings

  return settings.modelSettings?.[model]?.effortLevel ?? settings.effortLevel ?? null
}

const modelOptions = async ($: Engine) =>
  [...((await $.config.list()).find(row => row.key === 'model')?.options ?? [])]

const refresh = async ($: Engine, effort?: string) => {
  const model = await $.session.model()
  const found: ModelChoice = {
    model,
    effort: effort ?? (await effortFromSettings($, model)),
    modelOptions: await modelOptions($),
  }
  await update($, current, () => found)
}

const pickModel = async ($: Engine, model: string) => {
  const { deny } = await $.config.set({ key: 'model', value: model })
  if (deny !== undefined) $.ui.toast(`Model not changed: ${deny}`)
  await refresh($)
}

const pickEffort = async ($: Engine, effort: string) => {
  await $.command.run({ command: 'effort', args: effort })
  await refresh($, effort)
}

export const register: Register = on => {
  on('session.start', async ($, e, next) => {
    const result = await next(e)
    await refresh($)

    return result
  })

  on('turn.step', async function* ($, e, next) {
    const shown = await read($, current)
    const effort = e.effort === undefined ? null : String(e.effort)
    if (e.agentId === undefined && shown !== null && (shown.model !== e.model || shown.effort !== effort)) {
      await update($, current, () => ({ ...shown, model: e.model, effort }))
    }

    return yield* next(e)
  })

  on('ui.render', { component: 'AbovePrompt' }, async ($, e, next) => {
    const shown = await read($, current)
    if (e.props.hasSurvey || shown === null) return next(e)
    const { Box, Button, Text } = $.ui.resolve(e)
    const { above, items } = bandParts(await next(e))
    const isOpen = await read($, isPickerOpen)
    const label = shown.effort === null ? formatModel(shown.model) : `${formatModel(shown.model)} · ${shown.effort}`
    const own = (
      <Box key={BAND_ITEM}>
        <Button key="toggle-model-effort" label={label} dimColor={!isOpen} onPress={() => update($, isPickerOpen, () => !isOpen)} />
      </Box>
    )
    const sorted = [...items, own].sort((first, second) => rankOf(first) - rankOf(second))

    return (
      <Box key={BAND} flexDirection="column">
        {above}
        {isOpen && (
          <Box flexDirection="column">
            <Box flexDirection="row" gap={1}>
              <Text bold>{'Model '}</Text>
              {shown.modelOptions.map(option => (
                <Button key={`model:${option}`} label={option} onPress={() => pickModel($, option)} />
              ))}
            </Box>
            <Box flexDirection="row" gap={1}>
              <Text bold>{'Effort'}</Text>
              {EFFORTS.map(effort => (
                <Button
                  key={`effort:${effort}`}
                  label={effort === shown.effort ? `• ${effort}` : effort}
                  onPress={() => pickEffort($, effort)}
                />
              ))}
            </Box>
          </Box>
        )}
        <Box key={BAND_ROW} flexDirection="row" gap={1}>
          {sorted}
        </Box>
      </Box>
    )
  })
}
