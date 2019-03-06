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

let s:italic    = 'italic'
let s:bold      = 'bold'
let s:underline = 'underline'
let s:none      = 'NONE'

let s:default_lst = []
let s:default_str = ''

if !exists("g:monochrome_italic_comments")
  let g:monochrome_italic_comments = 0
endif
let s:comment_attr = g:monochrome_italic_comments ? s:italic : s:none

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
call s:hi('CursorColumn', s:default_lst, s:bgray, s:none)
call s:hi('CursorLine', s:default_lst, s:bgray, s:none)
call s:hi('CursorLineNr', s:white, s:default_bg, s:bold)
call s:hi('ErrorMsg', s:white, s:red)
call s:hi('Normal')
call s:hi('Search', s:white, s:sblue)
call s:hi('StatusLine', s:lgray, s:black)
call s:hi('StatusLineNC', s:lgray, s:black)
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

" Help.
call s:hi('helpSpecial')
call s:hi('helpHyperTextJump', s:sblue, s:default_bg, s:underline)
call s:hi('helpNote')

" Popup menu.
call s:hi('Pmenu', s:white, s:cgray)
call s:hi('PmenuSel', s:black, s:white)

" Notes.
call s:hi('Todo', s:black, s:yellow, s:bold)

" Signs.
call s:hi('SignColumn')

"
" --- Programming languages ----------------------------------------------------
"

call s:hi('Comment', s:cgray, s:default_bg, s:comment_attr)
call s:hi('Constant')
call s:hi('String', s:sblue)
call s:hi('Character', s:sblue)
call s:hi('Number', s:sblue)
call s:hi('Boolean', s:sblue)
call s:hi('Float', s:sblue)
call s:hi('Identifier')
call s:hi('Statement', s:white, s:default_bg)
call s:hi('PreProc', s:white, s:default_bg)
call s:hi('Type', s:white, s:default_bg, s:bold)
call s:hi('Special', s:white, s:default_bg, s:bold)

call s:hi('MatchParen', s:black, s:lgray)


"
" --- VimL ---------------------------------------------------------------------
"

call s:hi('vimOption')
call s:hi('vimGroup')
call s:hi('vimHiClear')
call s:hi('vimHiGroup')
call s:hi('vimHiAttrib')
call s:hi('vimHiGui')
call s:hi('vimHiGuiFgBg')
call s:hi('vimHiCTerm')
call s:hi('vimHiCTermFgBg')
call s:hi('vimSynType')
hi link vimCommentTitle Comment


"
" --- Ruby ---------------------------------------------------------------------
"

call s:hi('rubyConstant')
call s:hi('rubySharpBang', s:cgray)
call s:hi('rubyStringDelimiter', s:sblue)
call s:hi('rubyStringEscape', s:sblue)
call s:hi('rubyRegexpEscape', s:sblue)
call s:hi('rubyRegexpAnchor', s:sblue)
call s:hi('rubyRegexpSpecial', s:sblue)


"
" --- Elixir -------------------------------------------------------------------
"

call s:hi('elixirAlias', s:default_fg, s:default_bg, s:none)
call s:hi('elixirDelimiter', s:sblue)
call s:hi('elixirSelf', s:default_fg, s:default_bg, s:none)

" For ||, ->, etc.
call s:hi('elixirOperator')

" Module attributes like @doc or @type.
hi link elixirVariable Statement

" While rendered as comments in other languages, docstrings are strings,
" experimental.
hi link elixirDocString String
hi link elixirDocTest String
hi link elixirStringDelimiter String


"
" --- Perl ---------------------------------------------------------------------
"

call s:hi('perlSharpBang', s:cgray)
call s:hi('perlStringStartEnd', s:sblue)
call s:hi('perlStringEscape', s:sblue)
call s:hi('perlMatchStartEnd', s:sblue)


"
" --- Python -------------------------------------------------------------------
"

call s:hi('pythonEscape', s:sblue)


"
" --- JavaScript ---------------------------------------------------------------
"

call s:hi('javaScriptFunction', s:white, s:default_bg, s:bold)


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


"
" --- Markdown -----------------------------------------------------------------
"

call s:hi('Title', s:white, s:default_bg, s:bold)
call s:hi('markdownHeadingDelimiter', s:white, s:default_bg, s:bold)
call s:hi('markdownHeadingRule', s:white, s:default_bg, s:bold)
call s:hi('markdownLinkText', s:sblue, s:default_bg, s:underline)


"
" --- vim-fugitive -------------------------------------------------------------
"

call s:hi('gitcommitComment', s:default_fg, s:default_bg, s:none)
call s:hi('gitcommitOnBranch', s:default_fg, s:default_bg, s:none)
call s:hi('gitcommitBranch', s:sblue, s:default_bg, s:none)
call s:hi('gitcommitHeader', s:white, s:default_bg, s:bold)
call s:hi('gitcommitSelected', s:default_fg, s:default_bg, s:none)
call s:hi('gitcommitDiscarded', s:default_fg, s:default_bg, s:none)
call s:hi('gitcommitSelectedType', s:default_fg, s:default_bg, s:none)
call s:hi('gitcommitDiscardedType', s:default_fg, s:default_bg, s:none)


"
" --- NeoMake ------------------------------------------------------------------
"

call s:hi('NeomakeMessageSign')
call s:hi('NeomakeWarningSign', s:sblue)
call s:hi('NeomakeErrorSign', s:yellow)
call s:hi('NeomakeInfoSign')
call s:hi('NeomakeError', s:yellow)
call s:hi('NeomakeInfo', s:default_fg, s:default_bg, s:bold)
call s:hi('NeomakeMessage')
call s:hi('NeomakeWarning', s:yellow)

let g:terminal_ansi_colors = [
      \ "#353a44",
      \ "#e88388",
      \ "#a7cc8c",
      \ "#ebca8d",
      \ "#72bef2",
      \ "#d291e4",
      \ "#65c2cd",
      \ "#e3e5e9",
      \ "#353a44",
      \ "#e88388",
      \ "#a7cc8c",
      \ "#ebca8d",
      \ "#72bef2",
      \ "#d291e4",
      \ "#65c2cd",
      \ "#e3e5e9",
      \ ]