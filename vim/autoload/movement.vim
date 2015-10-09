highlight WhiteOnRed ctermfg=255 ctermbg=196 guifg=#ffffff guibg=#ff0000

function! movement#HLNext(blinktime) " {{{
    let [bufnum, lnum, col, off] = getpos('.')
    let target_pat = '\c\%#'.@/
    let blinks = 1
    for n in range(1, blinks)
        let red = matchadd('WhiteOnRed', target_pat, 100)
        redraw
        execute 'sleep '.float2nr(a:blinktime/(2*blinks)*500).'m'
        call matchdelete(red)
        redraw
        execute 'sleep '.float2nr(a:blinktime/(2*blinks)*500).'m'
    endfor
endfunction " }}}
