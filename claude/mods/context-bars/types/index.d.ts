export type ContextSlice = { name: string; tokens: number; color: string }

export type ContextSnapshot = {
  tokens: number
  window: number
  percent: number
  slices: ContextSlice[]
}

declare module 'claude-code' {
  interface PluginState {
    'context-bars': { snapshot: ContextSnapshot | null; isHidden: boolean }
  }
}
