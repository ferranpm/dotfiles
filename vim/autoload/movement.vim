highlight WhiteOnRed ctermfg=255 ctermbg=196 guifg=#ffffff guibg=#ff0000

function! movement#HLNext(blinktime)
    let target_pat = '\c\%#'.@/
    let red = matchadd('WhiteOnRed', target_pat, 100)
    redraw
    execute 'sleep '.float2nr(a:blinktime).'m'
    call matchdelete(red)
endfunction
