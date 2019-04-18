function! c#to_source() range
  let pos = getpos('.')
  execute a:firstline.','.a:lastline.'call utils#indent()'
  execute a:firstline.','.a:lastline.'s/;$/ {\r}\r/e'
  call setpos('.', pos)
endfunction

function! c#to_header() range
  let pos = getpos('.')
  execute a:firstline.','.a:lastline.'s/)\s*{\?\s*$/);/e'
  execute a:firstline.','.a:lastline.'s/ \?\w\+\(,\|)\)/\1/e'
  execute a:firstline.','.a:lastline.'g/^\%(\s\|\s*{\|\s*}\)\|^$/d'
  let maxposition = min([a:lastline, line('$')])
  execute a:firstline.','.maxposition.'call utils#indent()'
  call setpos('.', pos)
endfunction

