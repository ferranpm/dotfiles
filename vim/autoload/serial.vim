if !exists('g:picocom_baud')
    let g:picocom_baud = 9600
endif

function! serial#SelectPort(prefixes)
    let cmd = 'find /dev'
    let first_item = 1
    for prefix in a:prefixes
        if first_item
            let first_item = 0
        else
            let cmd = cmd . ' -or'
        endif
        let cmd = cmd . ' -name "' . prefix . '"'
    endfor
    let cmd = cmd . ' 2> /dev/null'
    let ports = split(system(cmd), '\n')
    let selection = 0
    if len(ports) > 1
        let selection = inputlist(map(copy(ports), 'v:key . ". " . v:val'))
    elseif len(ports) <= 0
        throw "No ports available"
    endif
    return get(ports, selection, ports[0])
endfunction

function! serial#Picocom()
    let port = serial#SelectPort(["ttyUSB*", "ttyACM*"])
    call utils#Run('picocom -b '.g:picocom_baud.' '.port)
endfunction

function! serial#PicocomExit()
    if exists('*VimuxRunCommand')
        call VimuxSendKeys('C-a C-x')
    endif
endfunction
