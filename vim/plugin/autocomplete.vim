if v:version < 700
  echohl ERROR "Smart completion will work only in vim version 7+"
  finish
endif

if !exists("g:smart_completion")
  let g:smart_completion = 1
endif

inoremap <expr> <c-j> pumvisible() ? "\<c-n>" : "\<esc>bea\<c-x>\<c-u>"
set completefunc=autocomplete#complete
