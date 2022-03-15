cnoremap <c-p> <up>
cnoremap <c-n> <down>
cnoremap <up> <c-p>
cnoremap <down> <c-n>

noremap ; :
noremap : ;

noremap ` '
noremap ' `

inoremap <s-cr> <esc>O
inoremap <c-cr> <esc>o

inoremap <expr> <c-j> pumvisible() ? "\<c-n>" : "\<c-x>\<c-u>"

nnoremap <silent> ]q :cnext<cr>
nnoremap <silent> [q :cprevious<cr>

nnoremap <silent> ]t :tnext<cr>
nnoremap <silent> [t :tprevious<cr>

nnoremap <silent> ]l :lafter<cr>
nnoremap <silent> [l :lbefore<cr>

noremap <silent> ]g /\v^(\<\|\=\|\>){7}([^=].+)?$<cr>
noremap <silent> [g ?\v^(\<\|\=\|\>){7}([^=].+)\?$<cr>

vnoremap * y/<c-r>=escape('<c-r>0', '*/\[].')<cr><cr>

vnoremap > >gv
vnoremap < <gv

nnoremap Y y$
nnoremap - ^

nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

nnoremap <c-]> g<c-]>
nnoremap g<c-]> <c-]>
vnoremap <c-]> g<c-]>
vnoremap g<c-]> <c-]>

if has('nvim')
  tnoremap <c-h> <C-\><c-n><c-w>h
  tnoremap <c-j> <C-\><c-n><c-w>j
  tnoremap <c-k> <C-\><c-n><c-w>k
  tnoremap <c-l> <C-\><c-n><c-w>l

  tnoremap <c-^> <c-\><c-n><c-^>
  tnoremap <c-u> <c-\><c-n><c-u>

  augroup terminalgroup
    autocmd TermOpen * nnoremap <buffer> <c-p> i<c-p>
    autocmd TermOpen * startinsert
    autocmd WinEnter term://* startinsert
  augroup END
else
  tnoremap <c-h> <c-w>h
  tnoremap <c-j> <c-w>j
  tnoremap <c-k> <c-w>k
  tnoremap <c-l> <c-w>l

  tnoremap <c-^> <c-\><c-n><c-^>
  tnoremap <c-u> <c-\><c-n><c-u>

  augroup termgroup
    autocmd TerminalOpen * nnoremap <buffer> <c-p> i<c-p>
  augroup END
endif

nnoremap ,S :%s/\C\<<c-r>=expand('<cword>')<cr>\>/<c-f>i
nnoremap ,s :s/\C\<<c-r>=expand('<cword>')<cr>\>/<c-f>i
vnoremap ,S y:%s/\C<c-r>=escape('<c-r>0', '*/\[].~')<cr>/<c-f>i
vnoremap ,s y:s/\C<c-r>=escape('<c-r>0', '*/\[].~')<cr>/<c-f>i

nnoremap ,g :g/\C\<<c-r>=expand('<cword>')<cr>\>/
nnoremap ,v :v/\C\<<c-r>=expand('<cword>')<cr>\>/
vnoremap ,g y:g/\C<c-r>=escape('<c-r>0', '*/\[].~')<cr>/
vnoremap ,v y:v/\C<c-r>=escape('<c-r>0', '*/\[].~')<cr>/

vnoremap ,r :s/\%V

nnoremap <f2> :setlocal cursorline! cursorline?<cr>
nnoremap <f3> :setlocal hlsearch! hlsearch?<cr>
nnoremap <f4> :setlocal spell! spell?<cr>
nnoremap <f8> :setlocal wrap! wrap?<cr>

nnoremap <leader>p :buffer 
nnoremap <leader>q :find 

nmap <c-p> <Plug>(PickerBuffer)
nmap <c-q> <Plug>(PickerEdit)
nmap <c-t> <Plug>(PickerTag)

nnoremap <silent> <leader>bc :let @*=expand("%")<cr>
nnoremap <silent> <leader>zs :%s/\s\+$//<cr>
vnoremap <silent> <leader>zs :s/\s\+$//<cr>
nnoremap <silent> <leader>h :setlocal hlsearch! hlsearch?<cr>
nnoremap          <leader>s "_ddP
nnoremap <silent> <leader>zh :call edit#auto_highlight_toggle()<cr>
nnoremap          <leader>zv zMzvzz
nnoremap          <leader>e :e <c-r>=expand("%:h")<cr>/

function! GrepEscaped(string)
  let extra = matchstr(a:string, '\(!\|?\)$')
  let word = substitute(a:string, '\(!\|?\)$', '', '')
  return '\b'.fnameescape(word).'\b'.fnameescape(extra)
endfunction

let silent = has('gui_running') || has('nvim') ? 'silent ' : ''
execute 'nnoremap <leader>u :'.silent.'grep! "<c-r>=GrepEscaped(expand("<cword>"))<cr>"'
execute 'nnoremap <leader>U :'.silent.'grep! "<c-r>=GrepEscaped(expand("<cWORD>"))<cr>"'
execute 'vnoremap <leader>u y:'.silent.'grep! --case-sensitive --fixed-strings "<c-r>0"'
execute 'nnoremap <leader>g :'.silent.'grep! ""<left>'
execute 'vnoremap <leader>g y:'.silent.'grep! "<c-r>0"<left>'

if has('clipboard')
  nnoremap <c-c> "+yy
  vnoremap <c-c> "+y
end
nnoremap <silent> <c-s> :update<cr>

noremap <silent> <c-s-tab> :bprevious<cr>
noremap <silent> <c-tab> :bnext<cr>
noremap <silent> <c-pageup> :tabprevious<cr>
noremap <silent> <c-pagedown> :tabnext<cr>

cnoremap <C-A> <Home>
cnoremap <C-B> <C-A>

map , <Plug>(easymotion-prefix)
inoremap <silent><expr> <tab> TriggerSnippet()

inoremap <silent> <c-space> <c-x><c-o>

noremap <silent> <leader><leader>g :0G<cr>
