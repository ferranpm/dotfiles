let s:lights = {}
let s:groups = [
            \ 'Highlight1',
            \ 'Highlight2',
            \ 'Highlight3',
            \ 'Highlight4',
            \ 'Highlight5',
            \ 'Highlight6',
            \ 'Highlight9',
            \ 'Highlight10',
            \ 'Highlight11',
            \ 'Highlight12',
            \ 'Highlight13',
            \ 'Highlight14'
            \ ]

highlight Highlight1  ctermfg=0 ctermbg=1  guifg=#ffffff guibg=#800000
highlight Highlight2  ctermfg=0 ctermbg=2  guifg=#ffffff guibg=#008000
highlight Highlight3  ctermfg=0 ctermbg=3  guifg=#ffffff guibg=#808000
highlight Highlight4  ctermfg=0 ctermbg=4  guifg=#ffffff guibg=#000080
highlight Highlight5  ctermfg=0 ctermbg=5  guifg=#ffffff guibg=#800080
highlight Highlight6  ctermfg=0 ctermbg=6  guifg=#ffffff guibg=#008080
highlight Highlight9  ctermfg=0 ctermbg=9  guifg=#ffffff guibg=#ff0000
highlight Highlight10 ctermfg=0 ctermbg=10 guifg=#ffffff guibg=#00ff00
highlight Highlight11 ctermfg=0 ctermbg=11 guifg=#ffffff guibg=#ffff00
highlight Highlight12 ctermfg=0 ctermbg=12 guifg=#ffffff guibg=#0000ff
highlight Highlight13 ctermfg=0 ctermbg=13 guifg=#ffffff guibg=#ff00ff
highlight Highlight14 ctermfg=0 ctermbg=14 guifg=#ffffff guibg=#00ffff

function! highlight#set(key, ...)
    let l:regexp = a:0 > 0 ? a:1 : a:key
    call highlight#unset(a:key)
    let s:lights[a:key] = matchadd(s:groups[len(keys(s:lights))%len(s:groups)], l:regexp)
endfunction

function! highlight#unset(key)
    if has_key(s:lights, a:key)
        call matchdelete(s:lights[a:key])
        call remove(s:lights, a:key)
    endif
endfunction

function! highlight#list()
    return keys(s:lights)
endfunction

function! highlight#complete(lead, line, pos)
    return filter(keys(s:lights), 'v:val =~ "^'.a:lead.'"')
endfunction
