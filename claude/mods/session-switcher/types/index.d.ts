export type LiveSession = {
  pid: number
  name: string
  title: string | null
  cwd: string
  status: string
  tty: string
  isCurrent: boolean
}

declare module 'claude-code' {
  interface PluginState {
    'session-switcher': { sessions: LiveSession[] }
  }
}
