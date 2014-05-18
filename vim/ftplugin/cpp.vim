function! QtCppIndent()
    " Patterns used to recognise labels and search for the start
    " of declarations
    let labelpat='signals:\|slots:\|public:\|protected:\|private:\|Q_OBJECT'
    let declpat='\(;\|{\|}\)\_s*.'

    " If the line is a label, it's a no brainer
    if match(getline(v:lnum),labelpat) != -1
        return &shiftwidth
    endif

    return cindent(v:lnum)
endfunc

set indentexpr=QtCppIndent()
