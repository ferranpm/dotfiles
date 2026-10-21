import type { RenderPropsOf } from 'claude-code'
import { expect, test } from 'claude-code/testing'
import type { Engine } from 'claude-code/testing'

const BAND = {
  component: 'AbovePrompt' as const,
  props: { hasSurvey: false, isWorking: false, maxRows: 10, bodyColumns: 120 } as RenderPropsOf['AbovePrompt'],
}

const usage = {
  startedAt: 0,
  rateLimits: [],
  context: {
    tokens: 50_000,
    window: 200_000,
    percent: 25,
    breakdown: {
      categories: [
        { name: 'System prompt', tokens: 8_000, color: 'promptBorder', isDeferred: false, kind: 'used' },
        { name: 'Messages', tokens: 42_000, color: 'claude', isDeferred: false, kind: 'used' },
        { name: 'Free space', tokens: 150_000, color: 'inactive', isDeferred: false, kind: 'free' },
      ],
      totalTokens: 50_000,
      maxTokens: 200_000,
      rawMaxTokens: 200_000,
      percentage: 25,
    },
  },
}

const showBars = async ($: Engine): Promise<void> => {
  const ui = await $.ui.mount({ plugin: 'context-bars', surface: 'terminal', ...BAND })
  await ui.press({ key: 'toggle' })
  await ui.unmount()
}

test('draws the total and one bar per used category on every surface', async ($, on) => {
  on('session.usage', () => ({ value: usage }) as never)
  on('session.measure', () => ({ changed: ['context'] }) as never)
  on('ui.render', ($e, e) => { const { Text } = $e.ui.resolve(e); return <Text>engine band</Text> })
  await $.session.measure({ context: usage.context, rateLimits: [], changed: ['context'] } as never)
  await showBars($)

  for (const surface of ['terminal', 'desktop'] as const) {
    const ui = await $.ui.mount({ plugin: 'context-bars', surface, ...BAND })

    expect(await ui.find({ type: 'Text', text: '50.0k / 200.0k' })).toBeDefined()
    expect(await ui.find({ type: 'Text', text: /^█{10}$/ })).toBeDefined()
    expect(await ui.find({ key: 'slice-Messages' })).toBeDefined()
    expect(await ui.find({ key: 'slice-Free space' })).toBeUndefined()
    await ui.unmount()
  }
})

test('the toggle collapses the band to a title filled to the usage', async ($, on) => {
  on('session.usage', () => ({ value: usage }) as never)
  on('session.measure', () => ({ changed: ['context'] }) as never)
  on('ui.render', ($e, e) => { const { Text } = $e.ui.resolve(e); return <Text>engine band</Text> })
  await $.session.measure({ context: usage.context, rateLimits: [], changed: ['context'] } as never)
  await showBars($)
  const ui = await $.ui.mount({ plugin: 'context-bars', surface: 'terminal', ...BAND })

  expect(await ui.find({ type: 'Text', text: 'Context bars (25%)' })).toBeDefined()

  await ui.press({ key: 'toggle' })

  expect(await ui.find({ key: 'slice-Messages' })).toBeUndefined()
  expect(await ui.find({ type: 'Text', text: 'Conte' })).toBeDefined()
  expect(await ui.find({ type: 'Text', text: 'xt bars (25%)' })).toBeDefined()
  expect(await ui.find({ key: 'toggle' })).toBeDefined()
  await ui.unmount()
})

test('starts hidden and the toggle brings the bars up', async ($, on) => {
  on('session.usage', () => ({ value: usage }) as never)
  on('session.measure', () => ({ changed: ['context'] }) as never)
  on('ui.render', ($e, e) => { const { Text } = $e.ui.resolve(e); return <Text>engine band</Text> })
  await $.session.measure({ context: usage.context, rateLimits: [], changed: ['context'] } as never)
  const ui = await $.ui.mount({ plugin: 'context-bars', surface: 'terminal', ...BAND })

  expect(await ui.find({ key: 'slice-Messages' })).toBeUndefined()

  await ui.press({ key: 'toggle' })

  expect(await ui.find({ key: 'slice-Messages' })).toBeDefined()
  expect(await ui.find({ type: 'Text', text: '50.0k / 200.0k' })).toBeDefined()
  await ui.unmount()
})

test('keeps what other mods draw in the bar, collapsed and expanded', async ($, on) => {
  on('session.usage', () => ({ value: usage }) as never)
  on('session.measure', () => ({ changed: ['context'] }) as never)
  on('ui.render', ($e, e) => { const { Text } = $e.ui.resolve(e); return <Text>another mod</Text> })
  await $.session.measure({ context: usage.context, rateLimits: [], changed: ['context'] } as never)
  const ui = await $.ui.mount({ plugin: 'context-bars', surface: 'terminal', ...BAND })

  const whileCollapsed = await ui.find({ type: 'Text', text: 'another mod' })
  await ui.press({ key: 'toggle' })
  const whileExpanded = await ui.find({ type: 'Text', text: 'another mod' })

  expect(whileCollapsed).toBeDefined()
  expect(whileExpanded).toBeDefined()
  await ui.unmount()
})

test('stays first in the bar whatever order the other mods drew their items in', async ($, on) => {
  on('session.usage', () => ({ value: usage }) as never)
  on('session.measure', () => ({ changed: ['context'] }) as never)
  on('ui.render', ($e, e) => {
    const { Box, Button } = $e.ui.resolve(e)

    return (
      <Box key="mod-band" flexDirection="column">
        <Box key="mod-band-row" flexDirection="row">
          <Box key="mod-band:sessions">
            <Button key="toggle-sessions" label="Sessions" onPress={() => undefined} />
          </Box>
          <Box key="mod-band:model-effort">
            <Button key="toggle-model-effort" label="opus · high" onPress={() => undefined} />
          </Box>
        </Box>
      </Box>
    )
  })
  await $.session.measure({ context: usage.context, rateLimits: [], changed: ['context'] } as never)

  const ui = await $.ui.mount({ plugin: 'context-bars', surface: 'terminal', ...BAND })
  const buttons = await ui.findAll({ type: 'Button' })

  expect(buttons.map(button => button.key)).toEqual(['toggle', 'toggle-model-effort', 'toggle-sessions'])
  await ui.unmount()
})
