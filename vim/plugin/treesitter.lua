local languages = {
  "c",
  "lua",
  "vim",
  "vimdoc",
  "query",
  "markdown",
  "markdown_inline",
  "json",
  "yaml",
  "html",
  "css",
  "sql",
  "javascript",
  "typescript",
  "tsx",
  "python",
  "bash",
  "dockerfile",
  "ruby",
  "toml",
}
require('nvim-treesitter.configs').setup({
  ensure_installed = languages,

  highlight = {
    enable = true,
  },
})
