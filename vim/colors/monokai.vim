" File:       monokai.vim
" Maintainer: Crusoe Xia (crusoexia)
" URL:        https://github.com/crusoexia/vim-monokai
" License:    MIT
"
" The colour palette is from http://www.colourlovers.com/
" The original code is from https://github.com/w0ng/vim-hybrid

if !has('gui_running') && &t_Co < 256
  finish
endif

set background=dark

highlight clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'monokai'

let s:white       = [ '#E8E8E3', 252 ]
let s:black       = [ '#272822', 234 ]
let s:lightblack  = [ '#2D2E27', 235 ]
let s:lightblack2 = [ '#383a3e', 236 ]
let s:darkblack   = [ '#211F1C', 233 ]
let s:grey        = [ '#8F908A', 243 ]
let s:lightgrey   = [ '#575b61', 237 ]
let s:darkgrey    = [ '#64645e', 239 ]
let s:warmgrey    = [ '#75715E', 59 ]
let s:pink        = [ '#F92772', 197 ]
let s:green       = [ '#A6E22D', 148 ]
let s:aqua        = [ '#66d9ef', 81 ]
let s:yellow      = [ '#E6DB74', 186 ]
let s:orange      = [ '#FD9720', 208 ]
let s:purple      = [ '#ae81ff', 141 ]
let s:red         = [ '#e73c50', 196 ]
let s:darkred     = [ '#5f0000', 52 ]
let s:addfg       = [ '#d7ffaf', 193 ]
let s:addbg       = [ '#5f875f', 65 ]
let s:delbg       = [ '#f75f5f', 167 ]
let s:changefg    = [ '#d7d7ff', 189 ]
let s:changebg    = [ '#5f5f87', 60 ]

let s:default_fg = s:white
let s:default_bg = s:black

let s:bold      = 'bold'
let s:underline = 'underline'
let s:reverse   = 'reverse'
let s:none      = 'NONE'

let s:default_lst = []
let s:default_str = ''

function! s:hi(...)
  let group = a:1
  let fg    = get(a:, 2, s:default_fg)
  let bg    = get(a:, 3, s:default_bg)
  let attr  = get(a:, 4, s:default_str)

  let cmd = ['hi', group]

  if fg != s:default_lst
    call add(cmd, 'guifg='.fg[0])
    call add(cmd, 'ctermfg='.fg[1])
  endif

  if bg != s:default_lst
    call add(cmd, 'guibg='.bg[0])
    call add(cmd, 'ctermbg='.bg[1])
  endif

  if attr != s:default_str
    call add(cmd, 'gui='.attr)
    call add(cmd, 'cterm='.attr)
  end

  exec join(cmd, ' ')
endfunction

"
" --- Vim interface ------------------------------------------------------------
"

call s:hi('ColorColumn', s:white, s:lightblack)
call s:hi('Cursor', s:default_bg, s:orange)
call s:hi('CursorColumn', s:default_fg, s:lightblack2)
call s:hi('CursorLine', s:default_fg, s:lightblack2)
call s:hi('CursorLineNr', s:orange, s:lightblack)
call s:hi('ErrorMsg', s:black, s:red, 'standout')
call s:hi('Normal')
call s:hi('Search', s:black, s:yellow)
call s:hi('StatusLine', s:warmgrey, s:black, 'reverse')
call s:hi('StatusLineNC', s:lightgrey, s:black, 'reverse')
call s:hi('StatusLineTerm', s:warmgrey, s:black, 'reverse')
call s:hi('StatusLineTermNC', s:lightgrey, s:black, 'reverse')
call s:hi('TabLine', s:darkblack, s:white, 'reverse')
call s:hi('TabLineFill', s:darkblack, s:white, 'reverse')
call s:hi('TabLineSel', s:white, s:darkblack, 'reverse')
call s:hi('Visual', s:default_fg, s:lightgrey)

" Tildes at the bottom of a buffer, etc.
call s:hi('NonText', s:lightgrey)

" Folding.
call s:hi('FoldColumn', s:default_fg, s:lightblack)
call s:hi('Folded', s:warmgrey, s:darkblack)

" Line numbers gutter.
call s:hi('LineNr', s:grey, s:lightblack)

" Small arrow used for tabs.
call s:hi('SpecialKey', s:pink)

" File browsers.
call s:hi('Directory', s:aqua)

" Popup menu.
call s:hi('Pmenu', s:lightblack, s:white)
call s:hi('PmenuSel', s:aqua, s:black, 'reverse,bold')
call s:hi('PmenuThumb', s:lightblack, s:grey)

" Notes.
call s:hi('Todo', s:orange, s:default_bg, 'bold')

" Signs.
call s:hi('SignColumn', s:default_fg, s:lightblack)

call s:hi('Title', s:yellow)

"
" --- Programming languages ----------------------------------------------------
"

call s:hi('Comment', s:warmgrey, s:default_bg)

call s:hi('Constant', s:purple)
call s:hi('String', s:yellow)
call s:hi('Character', s:yellow)

call s:hi('Identifier', s:green)

call s:hi('Statement', s:pink, s:default_bg, s:none)
call s:hi('Keyword', s:aqua)

call s:hi('PreProc', s:green)
call s:hi('Include', s:pink)
call s:hi('Define', s:pink)
call s:hi('Macro', s:pink)
call s:hi('PreCondit', s:green)

call s:hi('Type', s:aqua, s:default_bg, s:none)

call s:hi('Special', s:purple)
call s:hi('SpecialChar', s:pink)
call s:hi('Tag', s:pink)
call s:hi('Delimiter', s:pink)
call s:hi('SpecialComment', s:aqua)

call s:hi('MatchParen', s:purple)

"
" --- Diffs --------------------------------------------------------------------
"

call s:hi('DiffAdd', s:addfg, s:addbg)
call s:hi('DiffChange', s:changefg, s:changebg)
call s:hi('DiffDelete', s:black, s:delbg)
call s:hi('DiffText', s:black, s:aqua)

call s:hi('WarningMsg', s:red)
call s:hi('VertSplit', s:darkgrey, s:darkblack)
call s:hi('Question', s:yellow)
call s:hi('MoreMsg', s:yellow)

call s:hi('Underlined', s:green)
call s:hi('Ignore')
call s:hi('Error', s:red, s:darkred)
