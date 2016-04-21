noremap <leader>m; :call c#ToSource()<cr>
noremap <leader>m: :call c#ToHeader()<cr>

" Text object for 'arround function'
vmap <silent> af <esc>][v%?^\w\+<cr>
onoremap <silent> af :normal Vaf<CR>

setlocal tags+=~/.vim/tags/c/c

command! -buffer FormatFolder call c#FormatFolder()
