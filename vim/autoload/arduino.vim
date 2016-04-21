function! arduino#GetBoard()
    return g:arduino_package.':'.g:arduino_arch.':'.g:arduino_board
endfunction

function! arduino#Upload(...)
    let board = arduino#GetBoard()
    let filename = '%'
    if a:0 > 0 | let filename = a:1 | endif
    let port = serial#SelectPort(['ttyACM*', 'ttyUSB*'])
    execute 'setlocal makeprg='.g:arduino_binary.'\ --upload\ --board\ '.l:board.'\ --port\ '.l:port.'\ '.expand(l:filename)
    call utils#Make()
endfunction

function! arduino#Verify(...)
    let board = arduino#GetBoard()
    let filename = '%'
    if a:0 > 0 | let filename = a:1 | endif
    let filename = glob(filename)
    execute 'setlocal makeprg='.g:arduino_binary.'\ --verify\ --board\ '.l:board.'\ '.l:filename
    call utils#Make()
endfunction
