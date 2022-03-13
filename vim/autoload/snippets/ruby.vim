function! snippets#ruby#defi()
  let arguments = input("Arguments: ")
  let list = map(split(arguments, '\m,\s*'), { _, arg -> matchstr(arg, '^\m\k\+') })
  if empty(list)
    return "def initialize\nend\<esc>O"
  else
    let blop = map(copy(list), { _, el -> "@".el." = ".el })
    let reader = map(copy(list), { _, el -> ":".el })
    return "attr_reader ".join(reader, ", ")."\n\ndef initialize(".arguments.")\n".join(blop, "\n")."\nend\<esc>"
  endif
endfunction

function! snippets#ruby#class_name()
  return substitute(expand('%:t:r'), '\m\%(_\|\<\)\(\l\)', '\U\1', 'g')
endfunction

function! snippets#ruby#module_name()
  return substitute(expand('%:h:t'), '\m\%(_\|\<\)\(\l\)', '\U\1', 'g')
endfunction
