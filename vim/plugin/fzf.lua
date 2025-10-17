require("fzf-lua").setup({
  fzf_opts = {
    ['--ignore-case'] = true,
  },
  winopts = {
    height = 0.95,
    width = 0.95,
    preview = {
      layout = 'flex',
      horizontal = 'right:40%',
      flip_columns = 150,
    },
  },
})

vim.keymap.set('n', '<c-q>', '<cmd>FzfLua files<cr>')
vim.keymap.set('n', '<c-p>', '<cmd>FzfLua buffers<cr>')
vim.keymap.set('n', '<c-t>', '<cmd>FzfLua tags<cr>')
