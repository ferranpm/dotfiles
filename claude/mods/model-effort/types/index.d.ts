export type ModelChoice = {
  model: string
  effort: string | null
  modelOptions: string[]
}

declare module 'claude-code' {
  interface PluginState {
    'model-effort': { current: ModelChoice | null; isPickerOpen: boolean }
  }
}
