local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true })
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true })
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gu', '<cmd>lua vim.lsp.buf.references()<CR>', { noremap = true })
end

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
