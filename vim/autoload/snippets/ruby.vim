function! snippets#ruby#defi()
  let arguments = input("Arguments: ")
  let list = map(split(arguments, '\m,\s*'), { _, arg -> matchstr(arg, '^\m\k\+') })
  if empty(list)
    return "def initialize\nend\<esc>O"
  else
    let blop = map(copy(list), { _, el -> "@".el." = ".el })
    let reader = map(copy(list), { _, el -> ":".el })
    return "def initialize(".arguments.")\n".join(blop, "\n")."\nend\n\nattr_reader ".join(reader, ", ")."\<esc>"
  endif
endfunction

function! snippets#ruby#class_name()
  return substitute(expand('%:t:r'), '\m\%(_\|\<\)\(\l\)', '\U\1', 'g')
endfunction
