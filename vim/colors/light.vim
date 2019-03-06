set background=light

highlight clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'light'

let s:white   = ['#ffffff', 231]

let s:lred    = ['#ee0000', 9]
let s:lgreen  = ['#00ee00', 10]
let s:lyellow = ['#eeee00', 11]
let s:lblue   = ['#0000ee', 12]
let s:lpurple = ['#ee00ee', 13]
let s:lcyan   = ['#00eeee', 14]
let s:lgray   = ['#eeeeee', 255]

let s:red     = ['#cc0000', 9]
let s:green   = ['#00cc00', 10]
let s:yellow  = ['#cccc00', 11]
let s:blue    = ['#0000cc', 12]
let s:purple  = ['#cc00cc', 13]
let s:cyan    = ['#00cccc', 14]
let s:gray    = ['#cccccc', 252]

let s:dred    = ['#a00000', 1]
let s:dgreen  = ['#00a000', 2]
let s:dyellow = ['#a0a000', 3]
let s:dblue   = ['#0000a0', 4]
let s:dpurple = ['#a000a0', 5]
let s:dcyan   = ['#a000a0', 6]
let s:dgray   = ['#aaaaaa', 7]

let s:black   = ['#000000', 0]

let s:default_fg = s:black
let s:default_bg = s:white

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
  endif

  exec join(cmd, ' ')
endfunction


"
" --- Vim interface ------------------------------------------------------------
"

call s:hi('ColorColumn', s:default_fg, s:lgray)
call s:hi('CursorColumn', s:default_fg, s:lgray)
call s:hi('CursorLine', s:default_fg, s:lgray)
call s:hi('CursorLineNr', s:black)
call s:hi('Error', s:default_bg, s:red)
call s:hi('ErrorMsg', s:default_bg, s:red)
call s:hi('IncSearch', s:default_fg, s:green)
call s:hi('Normal', s:black, s:default_bg)
call s:hi('Search', s:default_fg, s:yellow)
call s:hi('StatusLine', s:black, s:white)
call s:hi('StatusLineNC', s:black, s:white)
call s:hi('StatusLineTerm', s:white, s:black)
call s:hi('StatusLineTermNC', s:white, s:black)
call s:hi('TabLine', s:black)
call s:hi('TabLineFill', s:default_fg, s:default_bg)
call s:hi('TabLineSel', s:black, s:gray)
call s:hi('Visual', s:default_fg, s:gray)

" Tildes at the bottom of a buffer, etc.
call s:hi('NonText', s:dblue)

" Folding.
call s:hi('FoldColumn', s:dblue, s:default_bg)
call s:hi('Folded', s:dblue, s:gray)

" Line numbers gutter.
call s:hi('LineNr', s:black)

" Small arrow used for tabs.
call s:hi('SpecialKey', s:dblue)

" File browsers.
call s:hi('Directory', s:dblue)

" Popup menu.
call s:hi('Pmenu', s:black, s:cyan)
call s:hi('PmenuSbar', s:default_fg, s:gray)
call s:hi('PmenuSel', s:black, s:gray)
call s:hi('PmenuThumb')

" Notes.
call s:hi('Todo', s:black, s:lyellow)

" Signs.
call s:hi('SignColumn', s:dblue, s:default_bg)

"
" --- Programming languages ----------------------------------------------------
"

call s:hi('Comment', s:dgray)
call s:hi('Constant', s:dred)
call s:hi('Identifier', s:dblue)
call s:hi('Statement', s:dpurple)
call s:hi('PreProc', s:dpurple)
call s:hi('Type', s:lblue)
call s:hi('Special', s:purple)

call s:hi('MatchParen', s:default_fg, s:yellow)

"
" --- Diffs --------------------------------------------------------------------
"

call s:hi('DiffAdd', s:default_fg, s:green)
call s:hi('DiffChange', s:default_fg, s:lgray)
call s:hi('DiffDelete', s:default_fg, s:red)
call s:hi('DiffText', s:default_fg, s:red)
call s:hi('diffAdded', s:default_fg, s:green)
call s:hi('diffFile', s:dgray)
call s:hi('diffIndexLine', s:dgray)
call s:hi('diffLine', s:dgray)
call s:hi('diffNewFile', s:dgray)
call s:hi('diffRemoved', s:default_fg, s:red)
call s:hi('diffSubname', s:dgray)


let g:terminal_ansi_colors = [
      \ s:black[0],
      \ s:dred[0],
      \ s:dgreen[0],
      \ s:dyellow[0],
      \ s:dblue[0],
      \ s:red[0],
      \ s:green[0],
      \ s:lgray[0],
      \ s:dgray[0],
      \ s:red[0],
      \ s:green[0],
      \ s:yellow[0],
      \ s:blue[0],
      \ s:lred[0],
      \ s:lblue[0],
      \ s:white[0],
      \ ]
