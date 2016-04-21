function! processing#Run(...)
    let filename = '%'
    if a:0 > 0 | let filename = a:1 | endif
    let folder = fnamemodify(expand(filename), ':p:h')
    call utils#Run(g:processing_binary.' --sketch='.folder.' --run')
endfunction
