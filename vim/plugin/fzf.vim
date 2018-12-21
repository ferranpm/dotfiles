nnoremap <silent> <c-p> :Buffers<cr>
nnoremap <silent> <c-q> :FZF<cr>
nnoremap <silent> <c-t> :BTags<cr>
nnoremap <silent> g<c-t> :Tags <c-r>=expand('<cword>')<cr><cr>
vnoremap <silent> g<c-t> y:Tags <c-r>=escape('<c-r>0', '*/\[].')<cr><cr>

if executable('ag')
  let $FZF_DEFAULT_COMMAND='ag -g ""'
endif

let g:fzf_tags_command = 'ctags -R'

let g:fzf_colors = {
      \ 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment']
      \ }
