function! c#to_source() range
    let pos = getpos('.')
    if a:firstline == a:lastline
        normal ==
    else
        normal gv=
    endif
    execute 'silent '.a:firstline.','.a:lastline.'s/;$/ {\r}\r/e'
    call setpos('.', pos)
endfunction

function! c#to_header() range
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

function c#format_folder()
    silent! argdelete *
    silent! argadd *.c *.h
    silent! argdo normal! gg=G
    silent! argdo g/^$\n^$/d
    silent! argdo %s/\s\+$//
    silent! argdo w
endfunction
