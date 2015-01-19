function! ToC() range
    for line in reverse(range(a:firstline, a:lastline))
        execute 'normal! '.line.'gg=='
        silent! s/;$/ {\r}\r
    endfor
    if a:firstline == a:lastline
        normal 2k
    endif
endfunction
noremap <leader>m; :call ToC()<cr>

function! ToH() range
    for line in reverse(range(a:firstline, a:lastline))
        execute 'normal! '.line.'gg'
        normal! jdi{dd
        if line('.') != line('$')
            normal! k
        endif
        silent! s/)\s*{\?\s*$/);
        silent! s/ \?\w\+\(,\|)\)/\1
    endfor
    if a:firstline != a:lastline
        '<,'>g/^$/d
    endif
endfunction
noremap <leader>m: :call ToH()<cr>
