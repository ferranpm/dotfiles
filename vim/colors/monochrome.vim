" Vim color scheme
"
" Name:       monochrome.vim
" Maintainer: Xavier Noria <fxn@hashref.com>
" License:    MIT

set background=dark

highlight clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'monochrome'

let s:white  = ['White', 15]
let s:black  = ['Black', 16]
let s:lblack = ['#171717', 234]
let s:bgray  = ['#1d1d1d', 235]
let s:lgray  = ['LightGray', 255]
let s:cgray  = ['#737373', 243]
let s:dgray  = ['DarkGray', 248]
let s:sblue  = ['#778797', 67]
let s:yellow = ['Yellow', 226]
let s:red    = ['Red', 160]
let s:green  = ['DarkGreen', 28]
let s:orange = ['DarkOrange', 166]

let s:default_fg = s:lgray
let s:default_bg = s:lblack

let s:bold      = 'bold'
let s:underline = 'underline'
let s:reverse   = 'reverse'
let s:none      = 'NONE'

let s:default_lst = []
let s:default_str = s:none

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
  endif

  exec join(cmd, ' ')
endfunction

"
" --- Vim interface ------------------------------------------------------------
"

call s:hi('ColorColumn', s:default_fg, s:bgray)
call s:hi('Cursor', s:black, s:orange)
call s:hi('CursorColumn', s:default_lst, s:bgray)
call s:hi('CursorLine', s:default_lst, s:bgray)
call s:hi('CursorLineNr', s:white, s:default_bg, s:bold)
call s:hi('ErrorMsg', s:white, s:red)
call s:hi('Normal')
call s:hi('Search', s:white, s:sblue)
call s:hi('StatusLine', s:lgray, s:black, s:reverse.','.s:bold)
call s:hi('StatusLineNC', s:lgray, s:black, s:reverse)
call s:hi('StatusLineTerm', s:black, s:lgray, s:bold)
call s:hi('StatusLineTermNC', s:black, s:lgray)
call s:hi('TabLine')
call s:hi('TabLineFill', s:default_bg, s:default_bg)
call s:hi('TabLineSel', s:black, s:lgray)
call s:hi('Visual', s:white, s:sblue)

" Tildes at the bottom of a buffer, etc.
call s:hi('NonText', s:dgray)

" Folding.
call s:hi('FoldColumn', s:dgray)
call s:hi('Folded')

" Line numbers gutter.
call s:hi('LineNr', s:dgray)

" Small arrow used for tabs.
call s:hi('SpecialKey', s:sblue, s:default_bg, s:bold)

" File browsers.
call s:hi('Directory', s:white, s:default_bg)

" Popup menu.
call s:hi('Pmenu', s:white, s:cgray)
call s:hi('PmenuSel', s:black, s:white)

" Notes.
call s:hi('Todo', s:black, s:yellow, s:bold)

" Signs.
call s:hi('SignColumn')

call s:hi('Title', s:white, s:default_bg, s:bold)

"
" --- Programming languages ----------------------------------------------------
"

call s:hi('Comment', s:cgray, s:default_bg)

call s:hi('Constant')
call s:hi('String', s:sblue)
call s:hi('Character', s:sblue)
call s:hi('Number')
call s:hi('Boolean')
call s:hi('Float')

call s:hi('Identifier', s:white, s:default_bg)

call s:hi('Statement', s:white, s:default_bg)

call s:hi('PreProc', s:white, s:default_bg)

call s:hi('Type', s:white, s:default_bg)

call s:hi('Special', s:white, s:default_bg)

call s:hi('MatchParen', s:black, s:lgray)

"
" --- Diffs --------------------------------------------------------------------
"

call s:hi('DiffAdd', s:white, s:green)
call s:hi('DiffChange', s:white, s:cgray)
call s:hi('DiffDelete', s:white, s:red)
call s:hi('DiffText', s:white, s:red)
call s:hi('diffAdded', s:white, s:green)
call s:hi('diffFile', s:cgray)
call s:hi('diffIndexLine', s:cgray)
call s:hi('diffLine', s:cgray)
call s:hi('diffNewFile', s:cgray)
call s:hi('diffRemoved', s:white, s:red)
call s:hi('diffSubname', s:cgray)
