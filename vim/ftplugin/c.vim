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
    if a:firstline == a:lastline
        normal jda{k
        call setpos('.', pos)
    endif
    execute 'silent '.range.'g/^\%(\s\|\s*{\|\s*}\)\|^$/d'
    execute 'silent '.range.'s/)\s*{\?\s*$/);/e'
    execute 'silent '.range.'s/ \?\w\+\(,\|)\)/\1/e'
    call setpos('.', pos)
endfunction
noremap <leader>m: :call ToH()<cr>
