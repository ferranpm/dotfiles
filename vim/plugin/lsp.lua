local custom_on_attach = function(client)
  -- See `:help nvim_buf_set_keymap()` for more information
  vim.api.nvim_buf_set_keymap(0, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true })
  vim.api.nvim_buf_set_keymap(0, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true })

  vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
end

vim.cmd([[
  command! LspCodeAction lua vim.lsp.buf.code_action()
  augroup NvimLsp
  autocmd!
  autocmd DiagnosticChanged * lua vim.diagnostic.setloclist({ open = false })
  augroup END
]])

vim.diagnostic.config({
  virtual_text = false,
  underline = true,
  signs = true,
})

local lspconfig = require('lspconfig')

lspconfig.solargraph.setup({
  on_attach = custom_on_attach,
  diagnostics = true,
})

lspconfig.tsserver.setup({
  on_attach = custom_on_attach,
})
