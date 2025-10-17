augroup Experimental
  autocmd!
  autocmd FocusGained * checktime
  autocmd FileType qf wincmd J
augroup END
