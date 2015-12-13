noremap <leader>m; :call c#to_source()<cr>
noremap <leader>m: :call c#to_header()<cr>

" Text object for 'arround function'
vmap <silent> af <esc>][v%?^\w\+<cr>
onoremap <silent> af :normal Vaf<CR>

setlocal tags+=~/.vim/tags/c/c

command! CFormatFolder call c#format_folder()
