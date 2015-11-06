command! -nargs=* -complete=file ESP8266LuaUpload call esp8266#lua_upload(<f-args>)
command! -nargs=0 ESP8266LuaWipe call esp8266#lua_wipe()
command! -nargs=? -complete=custom,esp8266#firmware_complete ESP8266Flash call esp8266#flash(<f-args>)
command! -nargs=0 ESP8266Wipe call esp8266#wipe()

let g:arduino_board = 'esp8266:esp8266:ESP8266_ESP01'

if !exists('g:luatool_binary')
    let g:luatool_binary = '~/Workspace/esp8266/luatool/luatool/luatool.py'
endif

setlocal tags-=~/.vim/tags/c/c
setlocal tags+=~/.vim/tags/c/esp8266
