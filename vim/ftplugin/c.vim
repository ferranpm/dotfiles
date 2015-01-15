function! ToC() range
    for line in reverse(range(a:firstline, a:lastline))
        execute 'normal! '.line.'gg'
        silent! s/;$/ {\r}\r
    endfor
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
    endfor
    if a:firstline != a:lastline
        '<,'>g/^$/d
    endif
endfunction
noremap <leader>m: :call ToH()<cr>
