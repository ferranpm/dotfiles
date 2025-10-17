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
})

vim.lsp.enable('ruby_lsp')

vim.lsp.config('ts_ls', {
  on_attach = on_attach,
  capabilities = capabilities,
})
vim.lsp.enable('ts_ls')

vim.lsp.config('elixirls', {
  cmd = { "elixir-ls" };
  capabilities = capabilities,
})
vim.lsp.enable('elixirls')

vim.lsp.config('gdscript', {
  capabilities = capabilities,
})
vim.lsp.enable('gdscript')
