command! -buffer -nargs=? -complete=file Upload call arduino#Upload(<f-args>)
command! -buffer -nargs=? -complete=file Verify call arduino#Verify(<f-args>)

nnoremap <buffer> <leader>mk :Verify<cr>
nnoremap <buffer> <leader>mr :Upload<cr>

if !exists('g:processing_binary')
    let g:processing_binary = 'processing-java'
endif

command! -buffer -nargs=? -complete=file ProcessingRun call processing#Run(<f-args>)

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
