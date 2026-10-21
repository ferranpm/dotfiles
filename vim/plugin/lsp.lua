vim.api.nvim_create_autocmd(
  { "DiagnosticChanged" },
  {
    pattern = { "*" },
    callback = function() vim.diagnostic.setloclist({ open = false }) end
  }
)

vim.diagnostic.config({
  underline = true,
  signs = true,
  loclist = true,
})

-- -- local vim.lsp.config = require('vim.lsp.config')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.config('ruby_lsp', {
  on_attach = on_attach,
  diagnostics = true,
  capabilities = capabilities,
  init_options = {
    addonSettings = {
      ["Ruby LSP Rails"] = {
        enablePendingMigrationsPrompt = false,
      },
    },
  },
})
vim.lsp.enable('ruby_lsp')

-- Native TypeScript 7 language server (`tsc --lsp --stdio`). nvim-lspconfig
-- prefers the project's node_modules/.bin/tsc and falls back to the one on $PATH.
vim.lsp.config('tsc', {
  capabilities = capabilities,
})
vim.lsp.enable('tsc')

vim.lsp.config('elixirls', {
  cmd = { "elixir-ls" };
  capabilities = capabilities,
})
vim.lsp.enable('elixirls')

vim.lsp.config('gdscript', {
  capabilities = capabilities,
})
vim.lsp.enable('gdscript')
