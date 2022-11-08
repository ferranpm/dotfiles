if executable("rg")
  let g:picker_custom_find_executable = 'rg'
  let g:picker_custom_find_flags = '--files'
elseif executable("ag")
  let g:picker_custom_find_executable = 'ag'
  let g:picker_custom_find_flags = '-g ""'
elseif executable("fd")
  let g:picker_custom_find_executable = 'fd'
  let g:picker_custom_find_flags = '-t f'
endif

if executable("pick")
  let g:picker_selector_executable = 'pick'
  let g:picker_selector_flags = '-KX'
elseif executable("fzy")
  let g:picker_selector_executable = 'fzy'
  let g:picker_selector_flags = '-l 40'
endif

let g:picker_split = 'botright'
let g:picker_height = 20
