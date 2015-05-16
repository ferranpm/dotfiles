set makeprg=ant\ -emacs\ debug
set errorformat=%f:%l:\ error:\ %m

nnoremap <F5> :update<cr>:Make<cr>
nnoremap <F6> :Dispatch ant installd<cr>

let $CLASSPATH=expand("~/android-sdk/platforms/android-15/android.jar")
