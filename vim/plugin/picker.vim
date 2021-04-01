if executable("ag")
  let g:picker_custom_find_executable = 'ag'
  let g:picker_custom_find_flags = '-g ""'
endif

if executable("fzy")
  let g:picker_selector_executable = 'fzy'
  let g:picker_selector_flags = ''
endif

let g:picker_split = 'belowright'
