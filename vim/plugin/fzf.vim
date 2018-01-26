nnoremap <silent> <c-p> :Buffers<cr>
nnoremap <silent> <c-q> :FZF<cr>
nnoremap <silent> <c-t> :Tags<cr>

if executable('ag')
  let $FZF_DEFAULT_COMMAND='ag -g ""'
endif
