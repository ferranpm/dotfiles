vim.api.nvim_create_autocmd(
  { "DiagnosticChanged" },
  {
    pattern = { "*" },
    callback = function() vim.diagnostic.setloclist({ open = false }) end
  }
)

vim.diagnostic.config({
  virtual_text = false,
  underline = true,
  signs = true,
  loclist = true,
})

local lspconfig = require('lspconfig')

lspconfig.ruby_lsp.setup({
  on_attach = on_attach,
  diagnostics = true,
})

lspconfig.ts_ls.setup({
  on_attach = on_attach,
})
