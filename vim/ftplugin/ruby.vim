setlocal softtabstop=2
setlocal tabstop=2
setlocal shiftwidth=2

map <silent> ]] /\m\<def\><cr>
map <silent> [[ ?\m\<def\><cr>

nnoremap <buffer> <silent> <leader>t :let @*="spring rspec ".expand("%").":".line(".")<cr>

command! -buffer -range HashToJson s/=>/:/e | s/\<nil\>/null/e | .!json_pp
