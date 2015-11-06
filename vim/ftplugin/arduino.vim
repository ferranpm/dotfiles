command! -nargs=? -complete=file ArduinoUpload call arduino#upload(<f-args>)
command! -nargs=? -complete=file ArduinoVerify call arduino#verify(<f-args>)

if !exists('g:arduino_binary')
    let g:arduino_binary = 'arduino'
endif

if !exists('g:arduino_board')
    let g:arduino_board = 'arduino:avr:uno'
endif

setlocal tags+=~/.vim/tags/arduino/arduino
