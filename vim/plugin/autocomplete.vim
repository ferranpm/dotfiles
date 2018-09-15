"
" settings:
" g:mkw_any - default regular expression used as wildcard
" - possible settings:
" - ''
"   every nothing around character in pattern is used as wildcard, so for KEY is '\<\k*K\k*E\k*Y\k*\>' used for matching keywords
" - '\k\zs'
"   every nothing around characters but the first is used as wildcard, so for KEY is '\<K\k*E\k*Y\k*\>' used for matching keywords
" - or any other reg.expression (e.g. '\.\.', '', '_', '\', '::', '`')
"   be careful it doesn't mix with language constructs used in your sources (as '\.' in C is used for structure members)
"   if zero-length match is used:
" - prepend \k\@<= if the first char in pattern must be the first in match
" - postpend \k\@= if the last char in pattern must be the last in match
" b:mkw_any - regular expression to be used for current buffer as wildcard

if v:version < 700
  echohl ERROR "Smart completion will work only in vim version 7+"
  finish
endif

if !exists("g:mkw_any")
  let g:mkw_any = '\k\zs'
endif

if !exists("g:mkw_loaded")
  let g:mkw_loaded = 1
endif

set completefunc=autocomplete#complete
