setlocal makeprg=arduino\ --verify\ %

nnoremap <F5> :update<cr>:Verify %<cr>
nnoremap <F6> :update<cr>:Upload %<cr>

command! -nargs=+ -complete=file Upload call s:Upload(<f-args>)
command! -nargs=+ -complete=file Verify call s:Verify(<f-args>)

if !exists('g:arduino_binary')
    let g:arduino_binary = 'arduino'
endif

if !exists('g:arduino_board')
    let g:arduino_board = 'arduino:avr:uno'
endif

if !exists('g:arduino_baud_rate')
    let g:arduino_baud_rate = '9600'
endif

function! s:Upload(sketch)
    let port = serial#SelectPort(["ttyACM*", "ttyUSB*"])
    call utils#Run(g:arduino_binary, ' --upload --board '.g:arduino_board.' --port '.port.' '.a:sketch.' && picocom '.port.' -b '.g:arduino_baud_rate)
endfunction

function! s:Verify(sketch)
    call utils#Run(g:arduino_binary, ' --verify --board '.g:arduino_board.' '.a:sketch)
endfunction
