" LuaUpload([file, [outputfilename]])
function! esp8266#LuaUpload(...)
    let filename = glob('%')
    let outputfilename = expand('%:t')
    if a:0 > 0 | let filename = a:1 | endif
    if a:0 > 1 | let outputfilename = a:2 | endif
    let port = serial#SelectPort(['ttyUSB*'])
    call utils#Run(expand(g:luatool_binary).' -s -f '.filename.' -t '.outputfilename.' -p '.port)
endfunction

function! esp8266#LuaWipe()
    let port = serial#SelectPort(['ttyUSB*'])
    call utils#Run(expand(g:luatool_binary).' -p '.port.' -w')
endfunction

" Flash([firmware])
function! esp8266#Flash(...)
    let base = '~/Workspace/esp8266/firmwares/'
    let firmware = 'nodemcu-master-9-modules-2015-09-17-09-00-52-integer.bin'
    if a:0 > 0 | let firmware = a:1 | endif
    let esptool_bin = 'esptool.py'
    let port = serial#SelectPort(['ttyUSB*', 'ttyACM*'])
    call utils#Run(expand(esptool_bin).' --port '.port.' write_flash 0x00000 '.expand(base.firmware))
endfunction

function! esp8266#Wipe()
    let esptool_bin = 'esptool.py'
    let port = serial#SelectPort(['ttyUSB*'])
    call utils#Run(expand(esptool_bin).' --port '.port.' erase_flash')
endfunction
