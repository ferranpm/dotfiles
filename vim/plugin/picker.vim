nmap <c-q> <Plug>(PickerEdit)
nmap <c-p> <Plug>(PickerBuffer)

if executable("rg")
  let g:picker_custom_find_executable = 'rg'
  let g:picker_custom_find_flags = '--files'
elseif executable("ag")
  let g:picker_custom_find_executable = 'ag'
  let g:picker_custom_find_flags = '-g ""'
endif

if executable("fzy")
  let g:picker_selector_executable = 'fzy'
  let g:picker_selector_flags = ''
endif

let g:picker_split = 'belowright'

command! Tag PickerBufferTag
