command! -nargs=? -complete=file Upload call s:Upload(<f-args>)
command! -nargs=? -complete=file Verify call s:Verify(<f-args>)

if !exists('g:arduino_binary')
    let g:arduino_binary = 'arduino'
endif

if !exists('g:arduino_board')
    let g:arduino_board = 'arduino:avr:uno'
endif

function! s:Upload(...)
    let filename = "%"
    if a:0 > 0 | let filename = a:1 | endif
    let port = serial#SelectPort(["ttyACM*", "ttyUSB*"])
    call utils#Run(g:arduino_binary, ' --upload --board '.g:arduino_board.' --port '.port.' '.expand(filename))
endfunction

function! s:Verify(...)
    let filename = "%"
    if a:0 > 0 | let filename = a:1 | endif
    call utils#Run(g:arduino_binary, ' --verify --board '.g:arduino_board.' '.expand(filename))
endfunction
