set background=dark

highlight clear

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
    syntax reset
endif

set t_Co=256

let colors_name = "xoria256"

highlight Comment        term=NONE cterm=NONE      ctermfg=244             gui=NONE      guifg=#808080
highlight Constant       term=NONE cterm=NONE      ctermfg=229             gui=NONE      guifg=#ffffaf
highlight Cursor         term=NONE cterm=NONE                  ctermbg=214 gui=NONE                    guibg=#ffaf00
highlight CursorColumn   term=NONE cterm=NONE                  ctermbg=238 gui=NONE                    guibg=#444444
highlight CursorLine     term=NONE cterm=NONE                  ctermbg=237 gui=NONE                    guibg=#3a3a3a
highlight Directory      term=NONE cterm=NONE      ctermfg=110             gui=NONE      guifg=#87afd7
highlight Error          term=NONE cterm=NONE      ctermfg=15  ctermbg=1   gui=NONE      guifg=#ffffff guibg=#800000
highlight ErrorMsg       term=NONE cterm=NONE      ctermfg=15  ctermbg=1   gui=NONE      guifg=#ffffff guibg=#800000
highlight FoldColumn     term=NONE cterm=NONE      ctermfg=247 ctermbg=233 gui=NONE      guifg=#9e9e9e guibg=#121212
highlight Folded         term=NONE cterm=NONE      ctermfg=255 ctermbg=60  gui=NONE      guifg=#eeeeee guibg=#5f5f87
highlight Identifier     term=NONE cterm=NONE      ctermfg=182             gui=NONE      guifg=#d7afd7
highlight Ignore         term=NONE cterm=NONE      ctermfg=238             gui=NONE      guifg=#444444
highlight IncSearch      term=NONE cterm=NONE      ctermfg=0   ctermbg=223 gui=NONE      guifg=#000000 guibg=#ffd7af
highlight LineNr         term=NONE cterm=NONE      ctermfg=247 ctermbg=233 gui=NONE      guifg=#9e9e9e guibg=#121212
highlight MatchParen     term=NONE cterm=bold      ctermfg=188 ctermbg=68  gui=bold      guifg=#d7d7d7 guibg=#5f87d7
highlight NonText        term=NONE cterm=bold      ctermfg=247 ctermbg=233 gui=bold      guifg=#9e9e9e guibg=#121212
highlight Normal         term=NONE cterm=NONE      ctermfg=252 ctermbg=234 gui=NONE      guifg=#d0d0d0 guibg=#1c1c1c
highlight Number         term=NONE cterm=NONE      ctermfg=180             gui=NONE      guifg=#d7af87
highlight Pmenu          term=NONE cterm=NONE      ctermfg=0   ctermbg=250 gui=NONE      guifg=#000000 guibg=#bcbcbc
highlight PmenuSbar      term=NONE cterm=NONE                  ctermbg=252 gui=NONE                    guibg=#d0d0d0
highlight PmenuSel       term=NONE cterm=NONE      ctermfg=255 ctermbg=243 gui=NONE      guifg=#eeeeee guibg=#767676
highlight PmenuThumb     term=NONE cterm=NONE      ctermfg=243             gui=NONE      guifg=#767676
highlight PreProc        term=NONE cterm=NONE      ctermfg=150             gui=NONE      guifg=#afd787
highlight Search         term=NONE cterm=NONE      ctermfg=0   ctermbg=149 gui=NONE      guifg=#000000 guibg=#afd75f
highlight SignColumn     term=NONE cterm=NONE      ctermfg=247 ctermbg=233 gui=NONE      guifg=#9e9e9e guibg=#121212
highlight Special        term=NONE cterm=NONE      ctermfg=174             gui=NONE      guifg=#d78787
highlight SpecialKey     term=NONE cterm=NONE      ctermfg=237             gui=NONE      guifg=#3a3a3a
highlight SpellBad       term=NONE cterm=underline ctermfg=160 ctermbg=bg  gui=underline guifg=#d70000 guibg=bg
highlight SpellCap       term=NONE cterm=underline ctermfg=189 ctermbg=bg  gui=underline guifg=#d7d7ff guibg=bg
highlight SpellLocal     term=NONE cterm=underline ctermfg=98  ctermbg=bg  gui=underline guifg=#875fd7 guibg=bg
highlight SpellRare      term=NONE cterm=underline ctermfg=168 ctermbg=bg  gui=underline guifg=#d75f87 guibg=bg
highlight Statement      term=NONE cterm=NONE      ctermfg=110             gui=NONE      guifg=#87afd7
highlight StatusLine     term=NONE cterm=NONE      ctermfg=255 ctermbg=0   gui=NONE      guifg=#eeeeee guibg=#000000
highlight StatusLineNC   term=NONE cterm=NONE      ctermfg=15  ctermbg=235 gui=NONE      guifg=#ffffff guibg=#262626
highlight TabLine        term=NONE cterm=NONE      ctermfg=fg  ctermbg=242 gui=NONE      guifg=fg      guibg=#666666
highlight TabLineFill    term=NONE cterm=NONE      ctermfg=fg  ctermbg=237 gui=NONE      guifg=fg      guibg=#3a3a3a
highlight Title          term=NONE cterm=NONE      ctermfg=225             gui=NONE      guifg=#ffd7ff
highlight Todo           term=NONE cterm=NONE      ctermfg=0   ctermbg=184 gui=NONE      guifg=#000000 guibg=#d7d700
highlight Type           term=NONE cterm=NONE      ctermfg=146             gui=NONE      guifg=#afafd7
highlight Underlined     term=NONE cterm=underline ctermfg=39              gui=underline guifg=#00afff
highlight VertSplit      term=NONE cterm=NONE      ctermfg=237 ctermbg=237 gui=NONE      guifg=#3a3a3a guibg=#3a3a3a
highlight Visual         term=NONE cterm=NONE      ctermfg=255 ctermbg=96  gui=NONE      guifg=#eeeeee guibg=#875f87
highlight VisualNOS      term=NONE cterm=NONE      ctermfg=255 ctermbg=60  gui=NONE      guifg=#eeeeee guibg=#5f5f87
highlight WildMenu       term=NONE cterm=bold      ctermfg=0   ctermbg=150 gui=bold      guifg=#000000 guibg=#afd787

highlight diffAdded                                ctermfg=150             guifg=#afd787
highlight diffRemoved                              ctermfg=174             guifg=#d78787
highlight diffAdd                                  ctermfg=bg  ctermbg=151 guifg=bg      guibg=#afd7af
highlight diffDelete                               ctermfg=bg  ctermbg=246 guifg=bg      guibg=#949494
highlight diffChange                               ctermfg=bg  ctermbg=181 guifg=bg      guibg=#d7afaf
highlight diffText                                 ctermfg=bg  ctermbg=174 guifg=bg      guibg=#d78787
