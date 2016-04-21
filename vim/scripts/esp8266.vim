command! -nargs=* -complete=file ESP8266LuaUpload call esp8266#LuaUpload(<f-args>)
command! -nargs=0 ESP8266LuaWipe call esp8266#LuaWipe()
command! -nargs=? -complete=file ESP8266Flash call esp8266#Flash(<f-args>)
command! -nargs=0 ESP8266Wipe call esp8266#Wipe()

let g:arduino_package = 'esp8266'
let g:arduino_arch = 'esp8266'
let g:arduino_board = 'ESP8266_ESP01'

if !exists('g:luatool_binary')
    let g:luatool_binary = '~/Workspace/esp8266/luatool/luatool/luatool.py'
endif

setlocal tags-=~/.vim/tags/c/c
setlocal tags+=~/.vim/tags/c/esp8266
