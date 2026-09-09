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
  files = {
    formatter = "path.filename_first",
  },
  buffers = {
    formatter = "path.filename_first",
  },
})

vim.api.nvim_set_hl(0, "FzfLuaDirPart", { fg = "gray", italic = true })

vim.keymap.set('n', '<c-q>', '<cmd>FzfLua files<cr>')
vim.keymap.set('n', '<c-p>', '<cmd>FzfLua buffers<cr>')
vim.keymap.set('n', '<c-t>', '<cmd>FzfLua tags<cr>')
