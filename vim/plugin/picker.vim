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

if executable("fzy")
  let g:picker_selector_executable = 'fzy'
  let g:picker_selector_flags = '--lines 100'
elseif executable("pick")
  let g:picker_selector_executable = 'pick'
  let g:picker_selector_flags = '-KX'
endif

let g:picker_split = 'botright'
let g:picker_height = 20
