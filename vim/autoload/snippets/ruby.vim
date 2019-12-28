function! snippets#ruby#defi()
  let arguments = input("Arguments: ")
  let list = map(split(arguments, '\m,\s*'), { _, arg -> matchstr(arg, '^\m\k\+') })
  let blop = map(list, { _, el -> "@".el." = ".el })
  return "def initialize(".arguments.")\n".join(blop, "\n")."\nend\<esc>"
endfunction
