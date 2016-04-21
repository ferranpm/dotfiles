function! java#IsUnusedImport()
    let cur = getpos('.')
    normal! f;b*
    let val = getpos('.')[1] == cur[1]
    call setpos('.', cur)
    return val
endfunction

function! java#DeleteUnusedImports()
    let cur = getpos('.')
    normal! gg
    while search('\m^\<import\> ', 'W') > 0
        if java#IsUnusedImport()
            normal! ddk
            if getpos('.')[1] < cur[1]
                let cur[1] = cur[1] - 1
            endif
        endif
    endwhile
    call setpos('.', cur)
endfunction
