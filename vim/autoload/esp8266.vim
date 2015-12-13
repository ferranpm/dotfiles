function! esp8266#firmware_complete(ArgLead, CmdLine, CursorPos)
    return utils#FolderComplete(a:ArgLead, a:CmdLine, a:CursorPos, '~/Workspace/esp8266/firmwares/')
endfunction

" lua_upload([file, [outputfilename]])
function! esp8266#lua_upload(...)
    let filename = glob('%')
    let outputfilename = expand('%:t')
    if a:0 > 0 | let filename = a:1 | endif
    if a:0 > 1 | let outputfilename = a:2 | endif
    let port = serial#SelectPort(['ttyUSB*'])
    call utils#Run(expand(g:luatool_binary).' -s -f '.filename.' -t '.outputfilename.' -p '.port)
endfunction

function! esp8266#lua_wipe()
    let port = serial#SelectPort(['ttyUSB*'])
    call utils#Run(expand(g:luatool_binary).' -p '.port.' -w')
endfunction

" flash([firmware])
function! esp8266#flash(...)
    let base = '~/Workspace/esp8266/firmwares/'
    let firmware = 'nodemcu-master-9-modules-2015-09-17-09-00-52-integer.bin'
    if a:0 > 0 | let firmware = a:1 | endif
    let esptool_bin = 'esptool.py'
    let port = serial#SelectPort(['ttyUSB*', 'ttyACM*'])
    call utils#Run(expand(esptool_bin).' --port '.port.' write_flash 0x00000 '.expand(base.firmware))
endfunction

function! esp8266#wipe()
    let esptool_bin = 'esptool.py'
    let port = serial#SelectPort(['ttyUSB*'])
    call utils#Run(expand(esptool_bin).' --port '.port.' erase_flash')
endfunction
