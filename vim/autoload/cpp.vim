function! cpp#to_source() range
    let pos = getpos('.')
    let class_name = substitute(expand("%:t:r"), '\(^.\)', '\u\1', '')
    let range = a:firstline.','.a:lastline
    if a:firstline == a:lastline
        normal ==
    else
        normal gv=
    endif
    execute 'silent '.range.'s/\m\(\w\+\s*(\)/'.class_name.'::\1/e'
    execute 'silent '.range.'s/\%(explicit\|virtual\) //e'
    execute 'silent '.range.'s/ \?= \?\w\+//e'
    execute range.'call c#to_source()'
    call setpos('.', pos)
endfunction

function! cpp#to_header() range
    let pos = getpos('.')
    let range = a:firstline.','.a:lastline
    execute 'silent '.range.'s/\w\+:://e'
    execute 'silent '.range.'s/ \?=//e'
    execute range.'call c#to_header()'
    call setpos('.', pos)
endfunction

function! cpp#qt_cpp_indent()
    " Patterns used to recognise labels and search for the start
    " of declarations
    let labelpat='signals:\|slots:\|public:\|protected:\|private:\|Q_OBJECT'
    let declpat='\(;\|{\|}\)\_s*.'
    " If the line is a label, it's a no brainer
    if match(getline(v:lnum),labelpat) != -1
        return 0
    endif
    " If the line starts with a closing brace, it's also easy: use cindent
    if match(getline(v:lnum),'^\s*}') != -1
        return cindent(v:lnum)
    endif
    " Save cursor position and move to the line we're indenting
    let pos=getpos('.')
    call setpos('.',[0,v:lnum,1,0])
    " Find the beginning of the previous declaration (this is what
    " cindent will mimic)
    call search(declpat,'beW',v:lnum>10?v:lnum-10:0)
    let prevlnum = line('.')
    " Find the beginning of the next declaration after that (this may
    " just get us back where we started)
    call search(declpat,'eW',v:lnum<=line('$')-10?v:lnum+10:0)
    let nextlnum = line('.')
    " Restore the cursor position
    call setpos('.',pos)
    " If we're not after a label, cindent will do the right thing
    if match(getline(prevlnum),labelpat)==-1
        return cindent(v:lnum)
        " It will also do the right thing if we're in the middle of a
        " declaration; this occurs when we are neither at the beginning of
        " the next declaration after the label, nor on the (non-blank) line
        " directly following the label
    elseif nextlnum != v:lnum && prevlnum != prevnonblank(v:lnum-1)
        return cindent(v:lnum)
    endif
    " Otherwise we adjust so the beginning of the declaration is one
    " shiftwidth in
    return &shiftwidth
endfunc

