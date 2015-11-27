command! -nargs=? -complete=file ArduinoUpload call arduino#upload(<f-args>)
command! -nargs=? -complete=file ArduinoVerify call arduino#verify(<f-args>)

if !exists('g:arduino_binary')
    let g:arduino_binary = 'arduino'
endif

if !exists('g:arduino_package')
    let g:arduino_package = 'arduino'
endif

if !exists('g:arduino_arch')
    let g:arduino_arch = 'avr'
endif

if !exists('g:arduino_board')
    let g:arduino_board = 'uno'
endif

setlocal tags+=~/.vim/tags/arduino/arduino
