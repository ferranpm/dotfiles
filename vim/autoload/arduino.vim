function! arduino#upload(...)
    let board = g:arduino_package.':'.g:arduino_arch.':'.g:arduino_board
    let filename = '%'
    if a:0 > 0 | let filename = a:1 | endif
    let port = serial#SelectPort(['ttyACM*', 'ttyUSB*'])
    call utils#Run(g:arduino_binary.' --upload --board '.board.' --port '.port.' '.expand(filename))
endfunction

function! arduino#verify(...)
    let board = g:arduino_package.':'.g:arduino_arch.':'.g:arduino_board
    let filename = '%'
    if a:0 > 0 | let filename = a:1 | endif
    let filename = glob(filename)
    call utils#Run(g:arduino_binary.' --verify --board "'.board.'" '.expand(filename))
endfunction
