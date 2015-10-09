command! -nargs=? -complete=file LuaUpload call s:LuaUpload(<f-args>)
command! -nargs=0 LuaWipe call s:LuaWipe()
command! -nargs=? -complete=custom,s:FirmwareComplete Flash call s:Flash(<f-args>)
command! -nargs=0 Wipe call s:Wipe()

function! s:FirmwareComplete(ArgLead, CmdLine, CursorPos)
    return utils#FolderComplete(a:ArgLead, a:CmdLine, a:CursorPos, '~/Workspace/esp8266/firmwares/')
endfunction

let g:arduino_board = 'esp8266:esp8266:ESP8266_ESP01'

if !exists('g:luatool_binary')
    let g:luatool_binary = '~/Workspace/esp8266/luatool/luatool/luatool.py'
endif

function! s:LuaUpload(...)
    let filename = "%"
    if a:0 > 0 | let filename = a:1 | endif
    let port = serial#SelectPort(['ttyUSB*'])
    call utils#Run(expand(g:luatool_binary), ' -sdr -f '.expand(filename).' -t init.lua -p '.port)
endfunction

function! s:LuaWipe()
    let port = serial#SelectPort(["ttyUSB*"])
    call utils#Run(expand(g:luatool_binary), ' -p '.port.' -w')
endfunction

" Flash([firmware])
function! s:Flash(...)
    let base = '~/Workspace/esp8266/firmwares/'
    let firmware = 'nodemcu-master-9-modules-2015-09-17-09-00-52-integer.bin'
    if a:0 > 0 | let firmware = a:1 | endif
    let esptool_bin = 'esptool.py'
    let port = serial#SelectPort(['ttyUSB*'])
    call utils#Run(expand(esptool_bin), ' --port '.port.' write_flash 0x00000 '.expand(base.firmware))
endfunction


function! s:Wipe()
    let esptool_bin = 'esptool.py'
    let port = serial#SelectPort(["ttyUSB*"])
    call utils#Run(expand(esptool_bin), ' --port '.port.' erase_flash')
endfunction
