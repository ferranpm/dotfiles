setlocal softtabstop=2
setlocal tabstop=2
setlocal shiftwidth=2
setlocal foldmethod=indent
setlocal foldlevelstart=1

map <silent> ]] /\m\<def\><cr>
map <silent> [[ ?\m\<def\><cr>

if !exists('current_compiler')
    compiler ruby
endif
