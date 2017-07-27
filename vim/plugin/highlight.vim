command! -nargs=+ Highlight  call highlight#set(<f-args>)
command! -nargs=+ -complete=customlist,highlight#complete Unhighlight call highlight#unset(<f-args>)
command! -nargs=0 ListHighlights echo highlight#list()
command! -nargs=0 HighlightClear  call highlight#clear()
