set omnifunc=javacomplete#Complete
set completefunc=javacomplete#CompleteParamsInfo

" If this is an android project, set the classpath env variable
" so javacomplete can do it's job
if glob('AndroidManifest.xml') =~ ''
    if filereadable('project.properties')
        let s:androidSdkPath = '/opt/android-sdk'
        let s:androidTargetPlatform = system('grep "target=" project.properties | sed -e "s/target=\(.*\)/\1/" | tr -d "\n"')
        let s:targetAndroidJar = s:androidSdkPath . '/platforms/' . s:androidTargetPlatform . '/android.jar'
        if $CLASSPATH =~ ''
            let $CLASSPATH = s:targetAndroidJar . ':' . $CLASSPATH
        else
            let $CLASSPATH = s:targetAndroidJar
        endif
    end
endif


let g:projectName = system('grep "<project name=" build.xml | sed -e "s/ *<project name=\"\(.*\)\" .*$/\1/" | tr -d "\n"')
nnoremap <F5> :execute "!ant debug && adb install -r bin/".g:projectName."-debug.apk && adb shell am start -n com.pelmon.shoppinglist/com.pelmon.shoppinglist.Main"<cr>
