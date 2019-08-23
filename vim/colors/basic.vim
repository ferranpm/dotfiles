highlight clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'basic'

if &background == 'light'
  let s:white   = ['#ffffff', 231]

  let s:red0    = ['#ee0000', 9]
  let s:green0  = ['#00ee00', 10]
  let s:yellow0 = ['#eeee00', 11]
  let s:blue0   = ['#0000ee', 12]
  let s:purple0 = ['#ee00ee', 13]
  let s:cyan0   = ['#00eeee', 14]
  let s:gray0   = ['#eeeeee', 255]

  let s:red1     = ['#cc0000', 9]
  let s:green1   = ['#00cc00', 10]
  let s:yellow1  = ['#cccc00', 11]
  let s:blue1    = ['#0000cc', 12]
  let s:purple1  = ['#cc00cc', 13]
  let s:cyan1    = ['#00cccc', 14]
  let s:gray1    = ['#cccccc', 252]

  let s:red2    = ['#a00000', 1]
  let s:green2  = ['#00a000', 2]
  let s:yellow2 = ['#808000', 3]
  let s:blue2   = ['#0000a0', 4]
  let s:purple2 = ['#a000a0', 5]
  let s:cyan2   = ['#a000a0', 6]
  let s:gray2   = ['#aaaaaa', 240]

  let s:black   = ['#000000', 0]

  let s:default_fg = s:black
  let s:default_bg = s:white
else
  let s:white   = ['#ffffff', 231]

  let s:red0    = ['#a00000', 1]
  let s:green0  = ['#00a000', 2]
  let s:yellow0 = ['#808000', 3]
  let s:blue0   = ['#aaaacc', 4]
  let s:purple0 = ['#a000a0', 5]
  let s:cyan0   = ['#a000a0', 6]
  let s:gray0   = ['#2a2a3a', 240]

  let s:red1     = ['#cc0000', 9]
  let s:green1   = ['#00cc00', 10]
  let s:yellow1  = ['#cccc00', 11]
  let s:blue1    = ['#0000cc', 12]
  let s:purple1  = ['#cc00cc', 13]
  let s:cyan1    = ['#00cccc', 14]
  let s:gray1    = ['#cccccc', 252]

  let s:red2    = ['#ee4444', 9]
  let s:green2  = ['#00ee00', 10]
  let s:yellow2 = ['#eeee00', 11]
  let s:blue2   = ['#aaaaee', 12]
  let s:purple2 = ['#ee00ee', 13]
  let s:cyan2   = ['#00eeee', 14]
  let s:gray2   = ['#aaaaaa', 255]

  let s:black   = ['#000000', 0]

  let s:default_fg = s:white
  let s:default_bg = s:black
end

let s:efault_lst2 = []
let s:efault_str2 = ''

function! s:hi(...)
  let group = a:1
  let fg    = get(a:, 2, s:default_fg)
  let bg    = get(a:, 3, s:default_bg)
  let attr  = get(a:, 4, s:efault_str2)

  let cmd = ['hi', group]

  if fg != s:efault_lst2
    call add(cmd, 'guifg='.fg[0])
    call add(cmd, 'ctermfg='.fg[1])
  endif

  if bg != s:efault_lst2
    call add(cmd, 'guibg='.bg[0])
    call add(cmd, 'ctermbg='.bg[1])
  endif

  if attr != s:efault_str2
    call add(cmd, 'gui='.attr)
    call add(cmd, 'cterm='.attr)
  endif

  exec join(cmd, ' ')
endfunction

" Vim interface
call s:hi('ColorColumn', s:default_fg, s:gray0)
call s:hi('CursorColumn', s:default_fg, s:gray0)
call s:hi('CursorLine', s:default_fg, s:gray0)
call s:hi('CursorLineNr', s:black)
call s:hi('Error', s:default_bg, s:red1)
call s:hi('ErrorMsg', s:default_bg, s:red1)
call s:hi('IncSearch', s:default_fg, s:yellow1)
call s:hi('Normal')
call s:hi('Search', s:default_fg, s:yellow1)
call s:hi('StatusLine', s:default_fg, s:default_bg)
call s:hi('StatusLineNC', s:default_fg, s:default_bg)
call s:hi('StatusLineTerm', s:default_bg, s:default_fg)
call s:hi('StatusLineTermNC', s:default_bg, s:default_fg)
call s:hi('TabLine', s:default_bg, s:default_fg, 'reverse')
call s:hi('TabLineFill', s:default_bg, s:default_fg, 'reverse')
call s:hi('TabLineSel', s:default_fg, s:default_bg, 'reverse,bold')
call s:hi('Visual', s:default_fg, s:gray1)

" Tildes at the bottom of a buffer, etc.
call s:hi('NonText', s:blue2)

" Folding.
call s:hi('FoldColumn', s:blue2, s:default_bg)
call s:hi('Folded', s:blue2, s:gray0)

" Line numbers gutter.
call s:hi('LineNr', s:gray2)

" Small arrow used for tabs.
call s:hi('SpecialKey', s:blue2)

" File browsers.
call s:hi('Directory', s:blue2)

" Popup menu.
call s:hi('Pmenu', s:black, s:gray0)
call s:hi('PmenuSbar', s:default_fg, s:gray1)
call s:hi('PmenuSel', s:black, s:gray1)
call s:hi('PmenuThumb')

" Notes.
call s:hi('Todo', s:black, s:yellow0)

" Signs.
call s:hi('SignColumn')

" Programming languages
call s:hi('Comment', s:gray2)
call s:hi('Constant', s:red2)
call s:hi('Identifier', s:blue2)
call s:hi('Statement', s:purple2)
call s:hi('PreProc', s:purple2)
call s:hi('Type', s:blue0)
call s:hi('Special', s:purple1)

call s:hi('MatchParen', s:default_fg, s:yellow1)

" Diffs
call s:hi('DiffAdd', s:default_fg, s:green0)
call s:hi('DiffChange', s:default_fg, s:gray0)
call s:hi('DiffDelete', s:default_fg, s:red0)
call s:hi('DiffText', s:default_fg, s:cyan0)
call s:hi('diffAdded', s:default_fg, s:green0)
call s:hi('diffFile', s:default_fg, s:gray0)
call s:hi('diffIndexLine', s:default_fg, s:gray0)
call s:hi('diffLine', s:default_fg, s:gray0)
call s:hi('diffNewFile', s:default_fg, s:gray0)
call s:hi('diffRemoved', s:default_fg, s:red0)
call s:hi('diffSubname', s:default_fg, s:gray0)

" Terminal
let g:terminal_ansi_colors = [
      \ s:black[0],
      \ s:red2[0],
      \ s:green2[0],
      \ s:yellow2[0],
      \ s:blue2[0],
      \ s:red1[0],
      \ s:green1[0],
      \ s:gray0[0],
      \ s:gray2[0],
      \ s:red1[0],
      \ s:green1[0],
      \ s:yellow1[0],
      \ s:blue1[0],
      \ s:red0[0],
      \ s:blue0[0],
      \ s:white[0],
      \ ]
