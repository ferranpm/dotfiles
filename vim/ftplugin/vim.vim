nnoremap <buffer> <leader>l :<c-r>=getline('.')<cr><cr>
vnoremap <buffer> <leader>l <esc>:<c-r>=join(getline("'<", "'>"), "\n")<cr><cr>
