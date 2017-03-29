setlocal softtabstop=2
setlocal tabstop=2
setlocal shiftwidth=2
setlocal foldmethod=syntax

map <silent> ]] /\m\<def\><cr>
map <silent> [[ ?\m\<def\><cr>

if !exists('current_compiler')
    compiler ruby
endif
