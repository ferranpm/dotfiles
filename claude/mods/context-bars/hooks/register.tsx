import { atom, read, update } from 'claude-code'
import type { EngineInterface, Register, RenderElement, RenderNode } from 'claude-code'

import type { ContextSlice, ContextSnapshot } from '../types'

const MAX_BAR_WIDTH = 40
const MIN_BAR_WIDTH = 10
const TOTAL_TEXT_WIDTH = 34
const LABEL_WIDTH = 22

const BAND = 'mod-band'
const BAND_ROW = 'mod-band-row'
const BAND_ITEM = 'mod-band:context-bars'
const BAND_ORDER = ['mod-band:context-bars', 'mod-band:model-effort', 'mod-band:sessions']

const snapshot = atom({ plugin: 'context-bars', key: 'snapshot' } as const, null)
const isHidden = atom({ plugin: 'context-bars', key: 'isHidden' } as const, true)

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

const formatTokens = (tokens: number): string =>
  tokens >= 1000 ? `${(tokens / 1000).toFixed(1)}k` : `${tokens}`

const fillColor = (percent: number): string =>
  percent >= 85 ? 'error' : percent >= 60 ? 'warning' : 'success'

const barWidthFor = (columns: number): number =>
  Math.max(MIN_BAR_WIDTH, Math.min(MAX_BAR_WIDTH, columns - LABEL_WIDTH - TOTAL_TEXT_WIDTH))

const cellsFor = (tokens: number, window: number, width: number): number =>
  Math.min(width, Math.round((tokens / window) * width))

const measure = async ($: EngineInterface): Promise<void> => {
  const { context } = await $.session.usage({ breakdown: 'summary' })
  const breakdown = context.breakdown
  if (breakdown === undefined) {
    return
  }

  const slices: ContextSlice[] = breakdown.categories
    .filter(category => category.kind === 'used' && category.tokens > 0)
    .map(({ name, tokens, color }) => ({ name, tokens, color }))
    .sort((first, second) => second.tokens - first.tokens)

  const next: ContextSnapshot = {
    tokens: context.tokens ?? breakdown.totalTokens,
    window: context.window,
    percent: context.percent ?? breakdown.percentage,
    slices,
  }
  await update($, snapshot, () => next)
}

export const register: Register = on => {
  on('session.start', async ($, e, next) => {
    await $.command.register({
      name: 'context-bars',
      description: 'Show or hide the context usage bars above the prompt',
    })
    const result = await next(e)
    await measure($)

    return result
  })

  on('session.measure', async ($, e, next) => {
    if (e.changed.includes('context')) {
      await measure($)
    }

    return next(e)
  })

  on('command.run', { command: 'context-bars' }, async $ => {
    const wasHidden = await read($, isHidden)
    await update($, isHidden, () => !wasHidden)
    await measure($)

    return { text: wasHidden ? 'Context bars shown.' : 'Context bars hidden.' }
  })

  on('ui.render', { component: 'AbovePrompt' }, async ($, e, next) => {
    const current = await read($, snapshot)
    if (e.props.hasSurvey || current === null) {
      return next(e)
    }

    const { Box, Button, Text } = $.ui.resolve(e)
    const { above, items } = bandParts(await next(e))
    const hidden = await read($, isHidden)
    const title = `Context bars (${current.percent}%)`
    const titleFill = cellsFor(current.tokens, current.window, title.length)
    const own = (
      <Box key={BAND_ITEM} flexDirection="row" gap={1}>
        <Button key="toggle" plain label={hidden ? '▸' : '▾'} onPress={() => update($, isHidden, () => !hidden)} />
        {hidden ? (
          <Box flexDirection="row">
            <Text color="inverseText" backgroundColor={fillColor(current.percent)}>
              {title.slice(0, titleFill)}
            </Text>
            <Text backgroundColor="subtle">{title.slice(titleFill)}</Text>
          </Box>
        ) : (
          <Text bold>{title}</Text>
        )}
      </Box>
    )
    const sorted = [...items, own].sort((first, second) => rankOf(first) - rankOf(second))
    const width = barWidthFor(e.props.bodyColumns)
    const filled = cellsFor(current.tokens, current.window, width)
    const roomForSlices = Math.max(0, e.props.maxRows - 3)

    return (
      <Box key={BAND} flexDirection="column">
        {!hidden && (
          <Box flexDirection="column">
            <Box flexDirection="row">
              <Text bold>{'Context'.padEnd(LABEL_WIDTH)}</Text>
              <Text color={fillColor(current.percent)}>{'█'.repeat(filled)}</Text>
              <Text dimColor>{'░'.repeat(width - filled)}</Text>
              <Text>
                {' '}
                {current.percent}% · {formatTokens(current.tokens)} / {formatTokens(current.window)}
              </Text>
            </Box>
            {current.slices.slice(0, roomForSlices).map(slice => {
              const cells = Math.max(1, cellsFor(slice.tokens, current.window, width))

              return (
                <Box key={`slice-${slice.name}`} flexDirection="row">
                  <Text dimColor>{`  ${slice.name}`.slice(0, LABEL_WIDTH).padEnd(LABEL_WIDTH)}</Text>
                  <Text color={slice.color}>{'█'.repeat(cells)}</Text>
                  <Text dimColor>{'░'.repeat(width - cells)}</Text>
                  <Text dimColor> {formatTokens(slice.tokens)}</Text>
                </Box>
              )
            })}
          </Box>
        )}
        {above}
        <Box key={BAND_ROW} flexDirection="row" gap={1}>
          {sorted}
        </Box>
      </Box>
    )
  })
}
