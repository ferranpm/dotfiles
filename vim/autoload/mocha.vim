let s:testPattern = '\s*it\s*(\|\s*describe\s*('
let s:descriptionPattern = '\s*describe\s*('

function! mocha#GetLine(pattern)
    let l:pos = getpos('.')
    execute '?'.a:pattern
    let l:line = getline('.')
    call setpos('.', l:pos)
    return l:line
endfunction

function! mocha#GetTestLine()
    return mocha#GetLine(s:testPattern)
endfunction

function! mocha#GetDescriptionLine()
    return mocha#GetLine(s:descriptionPattern)
endfunction

function! mocha#SearchTestLine()
    let l:line = getline('.')
    return mocha#LineMatches(s:testPattern) ? l:line : mocha#GetTestLine()
endfunction

function! mocha#SearchDescriptionLine()
    let l:line = getline('.')
    return mocha#LineMatches(s:descriptionPattern) ? l:line : mocha#GetDescriptionLine()
endfunction

function! mocha#Run(line)
    try
        let l:compiler_cmd = exists('b:current_compiler') ? 'compiler '.b:current_compiler : ''
        compiler mocha
        execute 'make! -g ' . mocha#ParseTestLine(a:line) . ' ' . expand('%') . '|' .  l:compiler_cmd
    catch
        echoerr 'No test found'
    endtry
endfunction

function! mocha#RunTest()
    call mocha#Run(mocha#SearchTestLine())
endfunction

function! mocha#RunDescription()
    call mocha#Run(mocha#SearchDescriptionLine())
endfunction

function! mocha#ParseTestLine(line)
    return matchstr(a:line, "['\"][^'\"]*['\"]")
endfunction

function! mocha#LineMatches(pattern)
    return match(getline('.'), a:pattern) >= 0
endfunction
