function! ToC() range
    let pos = getpos('.')
    if a:firstline == a:lastline
        normal ==
    else
        normal gv=
    endif
    execute 'silent '.a:firstline.','.a:lastline.'s/;$/ {\r}\r/e'
    call setpos('.', pos)
endfunction
noremap <leader>m; :call ToC()<cr>

function! ToH() range
    let pos = getpos('.')
    let range = a:firstline.','.a:lastline
    execute 'silent '.range.'s/)\s*{\?\s*$/);/e'
    execute 'silent '.range.'s/ \?\w\+\(,\|)\)/\1/e'
    execute 'silent '.range.'g/^\%(\s\|\s*{\|\s*}\)\|^$/d'
    if a:firstline == a:lastline
        normal ==
    else
        normal gv=
    endif
    call setpos('.', pos)
endfunction
noremap <leader>m: :call ToH()<cr>

" Text object for 'arround function'
vmap <silent> af <esc>][v%?^\w\+<cr>
onoremap <silent> af :normal Vaf<CR>

setlocal tags+=~/.vim/tags/c/c
