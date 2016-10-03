set background=light

highlight clear

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
    syntax reset
endif

set t_Co=256

let colors_name = "light"

highlight ColorColumn      term=NONE cterm=NONE             ctermbg=224 gui=NONE               guibg=#ffd7d7
highlight Comment          term=NONE cterm=NONE ctermfg=34              gui=NONE guifg=#00af00
highlight Conceal          term=NONE cterm=NONE ctermfg=7   ctermbg=242 gui=NONE guifg=#c0c0c0 guibg=#666666
highlight Constant         term=NONE cterm=NONE ctermfg=1               gui=NONE guifg=#800000
highlight CursorColumn     term=NONE cterm=NONE             ctermbg=7   gui=NONE               guibg=#c0c0c0
highlight CursorLine       term=NONE cterm=NONE             ctermbg=254 gui=NONE               guibg=#e4e4e4
highlight CursorLineNr     term=NONE cterm=NONE ctermfg=0               gui=NONE guifg=#000000
highlight DiffAdd          term=NONE cterm=NONE             ctermbg=81  gui=NONE               guibg=#5fd7ff
highlight DiffChange       term=NONE cterm=NONE             ctermbg=225 gui=NONE               guibg=#ffd7ff
highlight DiffDelete       term=NONE cterm=NONE ctermfg=12  ctermbg=159 gui=NONE guifg=#0000ff guibg=#afffff
highlight DiffText         term=NONE cterm=NONE             ctermbg=9   gui=NONE               guibg=#ff0000
highlight Directory        term=NONE cterm=NONE ctermfg=4               gui=NONE guifg=#000080
highlight Error            term=NONE cterm=NONE ctermfg=15  ctermbg=9   gui=NONE guifg=#ffffff guibg=#ff0000
highlight ErrorMsg         term=NONE cterm=NONE ctermfg=15  ctermbg=1   gui=NONE guifg=#ffffff guibg=#800000
highlight FoldColumn       term=NONE cterm=NONE ctermfg=4   ctermbg=15  gui=NONE guifg=#000080 guibg=#ffffff
highlight Folded           term=NONE cterm=NONE ctermfg=12  ctermbg=254 gui=NONE guifg=#0000ff guibg=#e4e4e4
highlight Identifier       term=NONE cterm=NONE ctermfg=33              gui=NONE guifg=#0087ff
highlight Ignore           term=NONE cterm=NONE ctermfg=15              gui=NONE guifg=#ffffff
highlight IncSearch        term=NONE cterm=NONE ctermfg=0   ctermbg=10  gui=NONE guifg=#000000 guibg=#00ff00
highlight LineNr           term=NONE cterm=NONE ctermfg=0               gui=NONE guifg=#000000
highlight MatchParen       term=NONE cterm=NONE             ctermbg=220 gui=NONE               guibg=#ffd700
highlight MoreMsg          term=NONE cterm=NONE ctermfg=2               gui=NONE guifg=#008000
highlight NonText          term=NONE cterm=NONE ctermfg=12              gui=NONE guifg=#0000ff
highlight Normal           term=NONE cterm=NONE ctermfg=0   ctermbg=15  gui=NONE guifg=#000000 guibg=#ffffff
highlight Pmenu            term=NONE cterm=NONE ctermfg=0   ctermbg=225 gui=NONE guifg=#000000 guibg=#ffd7ff
highlight PmenuSbar        term=NONE cterm=NONE             ctermbg=248 gui=NONE               guibg=#a8a8a8
highlight PmenuSel         term=NONE cterm=NONE ctermfg=0   ctermbg=254 gui=NONE guifg=#000000 guibg=#e4e4e4
highlight PmenuThumb       term=NONE cterm=NONE             ctermbg=0   gui=NONE               guibg=#000000
highlight PreProc          term=NONE cterm=NONE ctermfg=5               gui=NONE guifg=#800080
highlight Question         term=NONE cterm=NONE ctermfg=2               gui=NONE guifg=#008000
highlight Search           term=NONE cterm=NONE             ctermbg=3   gui=NONE               guibg=#808000
highlight SignColumn       term=NONE cterm=NONE ctermfg=4   ctermbg=15  gui=NONE guifg=#000080 guibg=#ffffff
highlight Special          term=NONE cterm=NONE ctermfg=5               gui=NONE guifg=#800080
highlight SpecialKey       term=NONE cterm=NONE ctermfg=4               gui=NONE guifg=#000080
highlight SpellBad         term=NONE cterm=NONE             ctermbg=224 gui=NONE               guibg=#ffd7d7
highlight SpellCap         term=NONE cterm=NONE             ctermbg=81  gui=NONE               guibg=#5fd7ff
highlight SpellLocal       term=NONE cterm=NONE             ctermbg=14  gui=NONE               guibg=#00ffff
highlight SpellRare        term=NONE cterm=NONE             ctermbg=225 gui=NONE               guibg=#ffd7ff
highlight Statement        term=NONE cterm=NONE ctermfg=131             gui=NONE guifg=#af5f5f
highlight StatusLine       term=NONE cterm=NONE ctermfg=231 ctermbg=16  gui=NONE guifg=#ffffff guibg=#000000
highlight TabLine          term=NONE cterm=NONE ctermfg=15  ctermbg=0   gui=NONE guifg=#ffffff guibg=#000000
highlight Title            term=NONE cterm=NONE ctermfg=5               gui=NONE guifg=#800080
highlight Todo             term=NONE cterm=NONE ctermfg=0   ctermbg=11  gui=NONE guifg=#000000 guibg=#ffff00
highlight Type             term=NONE cterm=NONE ctermfg=4               gui=NONE guifg=#000080
highlight Underlined       term=NONE cterm=NONE ctermfg=5               gui=NONE guifg=#800080
highlight Visual           term=NONE cterm=NONE             ctermbg=254 gui=NONE               guibg=#e4e4e4
highlight WarningMsg       term=NONE cterm=NONE ctermfg=1               gui=NONE guifg=#800000
highlight WildMenu         term=NONE cterm=NONE ctermfg=0   ctermbg=11  gui=NONE guifg=#000000 guibg=#ffff00

highlight link Boolean         Constant
highlight link Character       Constant
highlight link Conditional     Statement
highlight link Debug           Special
highlight link Define          PreProc
highlight link Delimiter       Special
highlight link Exception       Statement
highlight link Float           Number
highlight link Function        Identifier
highlight link Include         PreProc
highlight link Keyword         Statement
highlight link Label           Statement
highlight link Macro           PreProc
highlight link Number          Constant
highlight link Operator        Statement
highlight link PreCondit       PreProc
highlight link Repeat          Statement
highlight link SpecialChar     Special
highlight link SpecialComment  Special
highlight link StorageClass    Type
highlight link String          Constant
highlight link Structure       Type
highlight link Tag             Special
highlight link Typedef         Type
