import type { RenderPropsOf } from 'claude-code'
import { expect, test } from 'claude-code/testing'
import type { Engine, TestBody } from 'claude-code/testing'

type On = Parameters<TestBody>[1]

const BAND = {
  component: 'AbovePrompt' as const,
  props: { hasSurvey: false, isWorking: false, maxRows: 10, bodyColumns: 120 } as RenderPropsOf['AbovePrompt'],
}

const fakeEngine = (on: On, calls: string[]) => {
  let model = 'claude-opus-5-5'
  on('session.start', (_, e) => ({ cwd: e.cwd }))
  on('session.model', () => ({ value: model }) as never)
  on('settings.read', () => ({
    value: { effortLevel: 'high', modelSettings: { 'claude-opus-5-5': { effortLevel: 'medium' } } },
  }) as never)
  on('config.list', () => ({ value: [{ key: 'model', options: ['opus', 'sonnet', 'haiku'] }] }) as never)
  on('config.set', (_, e) => {
    calls.push(`model ${e.value}`)
    model = `claude-${e.value}-5-5`

    return { value: e.value }
  })
  on('command.run', (_, e) => {
    calls.push(`/${e.command} ${e.args}`)

    return { text: '' }
  })
}

const startSession = ($: Engine) => $.session.start({ cwd: '/repo', surface: 'terminal', isInteractive: true })

test('sits between the context bars and the sessions buttons whatever order it receives them in', async ($, on) => {
  fakeEngine(on, [])
  on('ui.render', ($e, e) => {
    const { Box, Button } = $e.ui.resolve(e)

    return (
      <Box key="mod-band" flexDirection="column">
        <Box key="mod-band-row" flexDirection="row">
          <Box key="mod-band:sessions">
            <Button key="toggle-sessions" label="Sessions" onPress={() => undefined} />
          </Box>
          <Box key="mod-band:context-bars">
            <Button key="show" label="Context bars" onPress={() => undefined} />
          </Box>
        </Box>
      </Box>
    )
  })
  await startSession($)

  const ui = await $.ui.mount({ plugin: 'model-effort', surface: 'terminal', ...BAND })
  const buttons = await ui.findAll({ type: 'Button' })

  expect(buttons.map(button => button.key)).toEqual(['show', 'toggle-model-effort', 'toggle-sessions'])
  expect((await ui.find({ key: 'toggle-model-effort' }))?.text).toContain('opus-5-5 · medium')
  await ui.unmount()
})

test('the toggle drops the picker into the bar, and picking applies and relabels', async ($, on) => {
  const calls: string[] = []
  fakeEngine(on, calls)
  on('ui.render', ($e, e) => { const { Text } = $e.ui.resolve(e); return <Text>engine band</Text> })
  await startSession($)
  const band = await $.ui.mount({ plugin: 'model-effort', surface: 'terminal', ...BAND })
  const closedPicker = await band.find({ key: 'model:sonnet' })

  await band.press({ key: 'toggle-model-effort' })
  await band.press({ key: 'model:sonnet' })
  await band.press({ key: 'effort:low' })

  expect(closedPicker).toBeUndefined()
  expect(calls).toEqual(['model sonnet', '/effort low'])
  expect((await band.find({ key: 'toggle-model-effort' }))?.text).toContain('sonnet-5-5 · low')
  expect(await band.find({ type: 'Text', text: 'engine band' })).toBeDefined()

  await band.press({ key: 'toggle-model-effort' })

  expect(await band.find({ key: 'model:sonnet' })).toBeUndefined()
  await band.unmount()
})

test('shows the selected model\'s own effort, falling back to the global one', async ($, on) => {
  fakeEngine(on, [])
  on('ui.render', ($e, e) => { const { Text } = $e.ui.resolve(e); return <Text>engine band</Text> })
  await startSession($)
  const band = await $.ui.mount({ plugin: 'model-effort', surface: 'terminal', ...BAND })
  const atStart = (await band.find({ key: 'toggle-model-effort' }))?.text

  await band.press({ key: 'toggle-model-effort' })
  await band.press({ key: 'model:haiku' })

  expect(atStart).toContain('opus-5-5 · medium')
  expect((await band.find({ key: 'toggle-model-effort' }))?.text).toContain('haiku-5-5 · high')
  await band.unmount()
})
