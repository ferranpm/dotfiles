function! arduino#upload(...)
    let filename = '%'
    if a:0 > 0 | let filename = a:1 | endif
    let port = serial#SelectPort(['ttyACM*', 'ttyUSB*'])
    call utils#Run(g:arduino_binary.' --upload --board '.g:arduino_board.' --port '.port.' '.expand(filename))
endfunction

function! arduino#verify(...)
    let filename = '%'
    if a:0 > 0 | let filename = a:1 | endif
    let filename = glob(filename)
    call utils#Run(g:arduino_binary.' --verify --board '.g:arduino_board.' '.expand(filename))
endfunction
