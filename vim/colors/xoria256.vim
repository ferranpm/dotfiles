set background=dark

highlight clear

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
  syntax reset
endif

set t_Co=256

let colors_name = "xoria256"

highlight ColorColumn ctermbg=236 guibg=#2b2b2b
highlight Comment ctermfg=244 guifg=#808080
highlight Constant ctermfg=229 guifg=#ffffaf
highlight Cursor ctermbg=214 guibg=#ffaf00
highlight CursorColumn ctermbg=238 guibg=#444444
highlight CursorLine cterm=none gui=none ctermbg=237 guibg=#3a3a3a
highlight CursorLineNr ctermfg=253 guifg=#dedede
highlight DiffAdd ctermfg=235 guifg=#262626 ctermbg=151 guibg=#afd7af
highlight DiffChange ctermfg=235 guifg=#262626 ctermbg=181 guibg=#d7afaf
highlight DiffDelete ctermfg=235 guifg=#262626 ctermbg=246 guibg=#949494
highlight DiffText ctermfg=235 guifg=#262626 ctermbg=174 guibg=#d78787
highlight Directory ctermfg=110 guifg=#87afd7
highlight Error ctermfg=15 guifg=#ffffff ctermbg=1 guibg=#800000
highlight ErrorMsg ctermfg=15 guifg=#ffffff ctermbg=1 guibg=#800000
highlight FoldColumn ctermfg=247 guifg=#9e9e9e ctermbg=233 guibg=#121212
highlight Folded ctermfg=255 guifg=#eeeeee ctermbg=60 guibg=#5f5f87
highlight Identifier ctermfg=182 guifg=#d7afd7
highlight Ignore ctermfg=238 guifg=#444444
highlight LineNr ctermfg=247 guifg=#9e9e9e
highlight MatchParen cterm=bold gui=bold ctermfg=188 guifg=#d7d7d7 ctermbg=68 guibg=#5f87d7
highlight NonText cterm=bold gui=bold ctermfg=247 guifg=#9e9e9e
highlight Number ctermfg=180 guifg=#d7af87
highlight Pmenu ctermfg=16 guifg=#000000 ctermbg=250 guibg=#bcbcbc
highlight PmenuSbar ctermbg=252 guibg=#d0d0d0
highlight PmenuSel ctermfg=255 guifg=#eeeeee ctermbg=243 guibg=#767676
highlight PmenuThumb ctermfg=243 guifg=#767676
highlight PreProc ctermfg=150 guifg=#afd787
highlight Search ctermfg=16 guifg=#000000 ctermbg=149 guibg=#afd75f
highlight SignColumn ctermfg=247 guifg=#9e9e9e ctermbg=235 guibg=#262626
highlight Special ctermfg=174 guifg=#d78787
highlight SpecialKey ctermfg=237 guifg=#3a3a3a
highlight SpellBad cterm=underline gui=underline ctermfg=160 guifg=#d70000
highlight SpellCap cterm=underline gui=underline ctermfg=189 guifg=#d7d7ff
highlight SpellLocal cterm=underline gui=underline ctermfg=98 guifg=#875fd7
highlight SpellRare cterm=underline gui=underline ctermfg=168 guifg=#d75f87
highlight Statement ctermfg=110 guifg=#87afd7
highlight TabLine cterm=none gui=none ctermbg=238 guibg=#464646
highlight TabLineFill cterm=none gui=none
highlight TabLineSel cterm=none gui=none
highlight Title ctermfg=225 guifg=#ffd7ff
highlight Todo ctermfg=16 guifg=#000000 ctermbg=184 guibg=#d7d700
highlight Type ctermfg=146 guifg=#afafd7
highlight Underlined cterm=underline gui=underline ctermfg=39 guifg=#00afff
highlight Visual ctermfg=255 guifg=#eeeeee ctermbg=96 guibg=#875f87
highlight VisualNOS ctermfg=255 guifg=#eeeeee ctermbg=60 guibg=#5f5f87
highlight WildMenu cterm=bold gui=bold ctermfg=16 guifg=#000000 ctermbg=150 guibg=#afd787
