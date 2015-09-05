nnoremap <F6> :update<cr>:Upload %<cr>

command! -nargs=+ -complete=file Upload call s:Upload(<f-args>)
command! -nargs=0 Wipe call s:Wipe()
command! -nargs=? -complete=file Flash call s:Flash(<f-args>)
command! -nargs=0 Picocom call s:Picocom()

if !exists('g:luatool_binary')
    let g:luatool_binary = '~/Workspace/thethings.iO/esp8266/luatool/luatool/luatool.py'
endif

if !exists('g:picocom_baud')
    let g:picocom_baud = 9600
endif

function! s:Upload(filename)
    let port = serial#SelectPort(["ttyUSB*"])
    call utils#Run(expand(g:luatool_binary), ' -sdr -f '.a:filename.' -t init.lua -p '.port.' && picocom -b '.g:picocom_baud.' '.port)
endfunction

function! s:Wipe()
    let port = serial#SelectPort(["ttyUSB*"])
    call utils#Run(expand(g:luatool_binary), ' -p '.port.' -w')
endfunction

function! s:Picocom()
    let port = serial#SelectPort(["ttyUSB*"])
    call utils#Run('picocom', ' -b '.g:picocom_baud.' '.port)
endfunction

" Flash([firmware])
function! s:Flash(...)
    let firmware = '~/Workspace/thethings.iO/esp8266/firmware/nodemcu_latest.bin'
    if a:0 > 0 | let firmware = a:1 | endif
    let esptool_bin = '~/Workspace/thethings.iO/esp8266/esptool/esptool.py'
    let port = serial#SelectPort(["ttyUSB*"])
    call utils#Run(expand(esptool_bin), ' --port '.port.' write_flash 0x00000 '.expand(firmware))
endfunction
