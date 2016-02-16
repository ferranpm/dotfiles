command! -nargs=? -complete=file ArduinoUpload call arduino#upload(<f-args>)
command! -nargs=? -complete=file ArduinoVerify call arduino#verify(<f-args>)

nnoremap <buffer> <leader>mk :ArduinoVerify<cr>
nnoremap <buffer> <leader>mr :ArduinoUpload<cr>

if !exists('g:processing_binary')
    let g:processing_binary = 'processing-java'
endif

command! -nargs=? -complete=file ProcessingRun call processing#run(<f-args>)

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

set tags+=~/.vim/tags/arduino/arduino
set errorformat=%E%f:%*[^:]:,%Z%*[^:]:%l:\ %m
