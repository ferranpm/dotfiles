set background=dark

highlight clear

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
  syntax reset
endif

set t_Co=256

let colors_name = "xoria256"

highlight ColorColumn guibg=#2b2b2b
highlight Comment guifg=#808080
highlight Constant guifg=#ffffaf
highlight Cursor guibg=#ffaf00
highlight CursorColumn guibg=#444444
highlight CursorLine cterm=none gui=none guibg=#3a3a3a
highlight CursorLineNr guifg=#dedede
highlight DiffAdd guifg=#262626 guibg=#afd7af
highlight DiffChange guifg=#262626 guibg=#d7afaf
highlight DiffDelete guifg=#262626 guibg=#949494
highlight DiffText guifg=#262626 guibg=#d78787
highlight Directory guifg=#87afd7
highlight Error guifg=#ffffff guibg=#800000
highlight ErrorMsg guifg=#ffffff guibg=#800000
highlight FoldColumn guifg=#9e9e9e guibg=#121212
highlight Folded guifg=#eeeeee guibg=#5f5f87
highlight Identifier guifg=#d7afd7
highlight Ignore guifg=#444444
highlight LineNr guifg=#9e9e9e
highlight MatchParen cterm=bold gui=bold guifg=#d7d7d7 guibg=#5f87d7
highlight NonText cterm=bold gui=bold guifg=#9e9e9e
highlight Number guifg=#d7af87
highlight Pmenu guifg=#000000 guibg=#bcbcbc
highlight PmenuSbar guibg=#d0d0d0
highlight PmenuSel guifg=#eeeeee guibg=#767676
highlight PmenuThumb guifg=#767676
highlight PreProc guifg=#afd787
highlight Search guifg=#000000 guibg=#afd75f
highlight SignColumn guifg=#9e9e9e guibg=#262626
highlight Special guifg=#d78787
highlight SpecialKey guifg=#3a3a3a
highlight SpellBad cterm=underline gui=underline guifg=#d70000
highlight SpellCap cterm=underline gui=underline guifg=#d7d7ff
highlight SpellLocal cterm=underline gui=underline guifg=#875fd7
highlight SpellRare cterm=underline gui=underline guifg=#d75f87
highlight Statement guifg=#87afd7
highlight TabLine cterm=none gui=none guibg=#464646
highlight TabLineFill cterm=none gui=none
highlight TabLineSel cterm=none gui=none
highlight Title guifg=#ffd7ff
highlight Todo guifg=#000000 guibg=#d7d700
highlight Type guifg=#afafd7
highlight Underlined cterm=underline gui=underline guifg=#00afff
highlight Visual guifg=#eeeeee guibg=#875f87
highlight VisualNOS guifg=#eeeeee guibg=#5f5f87
highlight WildMenu cterm=bold gui=bold guifg=#000000 guibg=#afd787
