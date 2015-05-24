set omnifunc=javacomplete#Complete
set completefunc=javacomplete#CompleteParamsInfo

call javacomplete#AddSourcePath(getcwd().'/src')

set makeprg=ant\ -emacs\ debug
set errorformat=%f:%l:\ error:\ %m,%f:%l:\ %m

" If this is an android project, set the classpath env variable
" so javacomplete can do it's job
if glob('AndroidManifest.xml') =~ ''
    if filereadable('project.properties')
        let s:androidSdkPath = expand('~/android-sdk')
        let s:androidTargetPlatform = system('grep "target=" project.properties | sed -e "s/target=\(.*\)/\1/" | tr -d "\n"')
        let s:targetAndroidJar = s:androidSdkPath . '/platforms/' . s:androidTargetPlatform . '/android.jar'
        if $CLASSPATH =~ ''
            let $CLASSPATH = s:targetAndroidJar . ':' . $CLASSPATH
        else
            let $CLASSPATH = s:targetAndroidJar
        endif
    end
endif

function! IsUnusedImport()
    let cur = getpos('.')
    normal! f;b*
    let val = getpos('.')[1] == cur[1]
    call setpos('.', cur)
    return val
endfunction

function! DeleteUnusedImports()
    let cur = getpos('.')
    normal! gg
    while search('\m^\<import\> ', 'W') > 0
        if IsUnusedImport()
            normal! ddk
            if getpos('.')[1] < cur[1]
                let cur[1] = cur[1] - 1
            endif
        endif
    endwhile
    call setpos('.', cur)
endfunction

command! -nargs=0 DeleteUnusedImports call DeleteUnusedImports()

let g:projectName = system('grep "<project name=" build.xml | sed -e "s/ *<project name=\"\(.*\)\" .*$/\1/" | tr -d "\n"')
let g:packageName = system('grep package AndroidManifest.xml | sed -e "s/ *package=\"\([a-zA-Z\.]\+\)\"/\1/" | tr -d "\n"')

nnoremap <F5> :update<cr>:Make<cr>
nnoremap <F6> :execute "Dispatch ant installd && adb shell am start -a android.intent.action.MAIN -n ".g:packageName."/.".g:projectName<cr>
