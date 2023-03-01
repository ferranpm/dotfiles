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

lspconfig.solargraph.setup({
  on_attach = on_attach,
  diagnostics = true,
})

lspconfig.tsserver.setup({
  on_attach = on_attach,
})
