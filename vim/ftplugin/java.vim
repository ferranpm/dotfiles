set omnifunc=javacomplete#Complete
set completefunc=javacomplete#CompleteParamsInfo

call javacomplete#AddSourcePath(getcwd().'/src')

set makeprg=ant\ -emacs\ debug
set errorformat=%f:%l:\ error:\ %m,%f:%l:\ %m

if !exists('g:android_sdk_path')
    let g:android_sdk_path = '/opt/android-sdk'
endif

" If this is an android project, set the classpath env variable
" so javacomplete can do it's job
if glob('AndroidManifest.xml') =~ ''
    if filereadable('project.properties')
        let s:android_target_platform = system('grep "target=" project.properties | sed -e "s/target=\(.*\)/\1/" | tr -d "\n"')
        let s:target_android_jar = g:android_sdk_path . '/platforms/' . s:android_target_platform . '/android.jar'
        if $CLASSPATH =~ ''
            let $CLASSPATH = s:target_android_jar . ':' . $CLASSPATH
        else
            let $CLASSPATH = s:target_android_jar
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

let g:android_project_name = system('xmllint AndroidManifest.xml | grep -m 1 "activity" | sed -e "s/ *<activity android:name=\"\([0-9A-Za-z_\.]\+\)\" .*/\1/" | tr -d "\n"')
let g:android_package_name = system('xmllint AndroidManifest.xml | grep -m 1 "package"  | sed -e "s/.*package=\"\([0-9A-Za-z_\.]\+\)\".*/\1/" | tr -d "\n"')

command! -nargs=0 AndroidInstall call utils#Run('ant installd && adb shell am start -a android.intent.action.MAIN -n '.g:android_package_name.'/'.g:android_project_name)
