noremap ; :
noremap : ;

nnoremap q; q:
xnoremap q; q:

noremap ` '
noremap ' `

inoremap <C-o> <C-x><C-o><C-p>
inoremap <C-j> <esc>O

nnoremap <silent> <C-@> :call buffer#AlternateSource()<cr>
nnoremap <silent> <C-^> :call buffer#AlternateFile()<cr>

nnoremap ) <Esc>/[)}"'\]>]<CR>
nnoremap ( <Esc>?[({"'\[<]<CR>
vnoremap ) /[)}"'\]>]<CR>
vnoremap ( ?[({"'\[<]<CR>

noremap [[ ?{<CR>w99[{
noremap ][ /}<CR>b99]}
map ]] j0[[%/{<CR>
map [] k$][%?}<CR>

nnoremap <silent> ]q :cnext<cr>
nnoremap <silent> [q :cprevious<cr>

nnoremap <silent> ]t :tnext<cr>
nnoremap <silent> [t :tprevious<cr>

nnoremap <silent> ]g /\v^(\<\|\=\|\>){7}([^=].+)?$<CR>
nnoremap <silent> [g ?\v^(\<\|\=\|\>){7}([^=].+)\?$<CR>

vnoremap <M-/> <Esc>/\%V
vnoremap * y/<c-r>=escape('<c-r>0', '*/\[].')<cr><cr>

nnoremap <silent> n n:call movement#HLNext(0.2)<cr>
nnoremap <silent> N N:call movement#HLNext(0.2)<cr>
nnoremap <silent> * *:call movement#HLNext(0.2)<cr>
nnoremap <silent> # #:call movement#HLNext(0.2)<cr>

nnoremap z/ :call edit#AutoHighlightToggle()<cr>

vnoremap > >gv
vnoremap < <gv

nnoremap Y y$

nnoremap - ^

nnoremap <silent> ,. :update<cr>

nnoremap <F1>   :Dispatch 
nnoremap <F2>   :setlocal cursorline! cursorline?<cr>
nnoremap <F3>   :setlocal hlsearch! hlsearch?<cr>
nnoremap <F4>   :setlocal spell! spell?<cr>
nnoremap <F5>   :call utils#Make()<cr>
nnoremap <F9>   :Gstatus<cr>
nnoremap <F12>  :call system('ctags')<cr>

 noremap                <leader>a :Align 
 noremap                <leader>c "+y
 noremap                <leader>p :put *<cr>
 noremap                <leader>v "+p
nnoremap                <leader>vc :VimuxCloseRunner<cr>
nnoremap    <silent>    <leader>zs :%s/\s\+$//<cr>
vnoremap    <silent>    <leader>zs :s/\s\+$//<cr>
nnoremap                <leader>bc :ls!<cr>:bwipeout 
nnoremap                <leader>bw :call buffer#BufferWipeOut()<cr>
nnoremap                <leader>cd :call buffer#SetProjectRoot()<cr>
nnoremap                <leader>d  :only<cr>:Gdiff<cr>
nnoremap                <leader>e :e <C-R>=expand('%:p:h') . '/' <CR>
nnoremap                <leader>fc zM
nnoremap                <leader>fe zMzvzz
nnoremap                <leader>fo zR
nnoremap                <leader>ff :find 
nnoremap                <leader>g :Grep 
nnoremap                <leader>h :Help 
nnoremap                <leader>rs :Shell 
nnoremap                <leader>rp :Pipe 
nnoremap                <leader>L O<Esc>
nnoremap                <leader>l o<Esc>
nnoremap                <leader>mm dapGplrXk/^\[ \]<cr>
nnoremap                <leader>u :call utils#FindUsage(0)<cr>
nnoremap                <leader>U :call utils#FindUsage(1)<cr>
nnoremap                <leader>S :%s/\C\<<C-r>=expand('<cword>')<CR>\>/
nnoremap                <leader>s :s/\C\<<C-r>=expand('<cword>')<CR>\>/
vnoremap                <leader>S y<esc>:%s/\C<C-r>=escape('<C-r>0', '*/\[].~')<cr>/
vnoremap                <leader>s y<esc>:s/\C<C-r>=escape('<C-r>0', '*/\[].~')<cr>/
nnoremap                <leader>t :tag 
nnoremap    <silent>    <leader>. :update<cr>
nnoremap    <silent>    <leader>bk :call buffer#BufferKill()<cr>
nnoremap    <silent>    <leader>ms iSigned-off-by: Ferran Pelayo Monfort <ferran.pel.mon@gmail.com><Esc>

if has('nvim')
    tnoremap <Esc> <C-\><C-n>
    tnoremap <C-g><C-p> <C-\><C-n>pi
    tnoremap <silent> <C-^> <C-\><C-n>:call buffer#AlternateFile()<cr>
    tnoremap <silent> <C-\>n <C-\><C-n>? \<in\> ?e<cr>wyiW:cd <c-r>0<cr>i
    tnoremap <silent> <C-\>t cd <C-\><C-n>:let @@=getcwd() \| .put 0<cr>i<cr>
    tnoremap <C-h> <C-\><C-n><C-w>h
    tnoremap <C-j> <C-\><C-n><C-w>j
    tnoremap <C-k> <C-\><C-n><C-w>k
    tnoremap <C-l> <C-\><C-n><C-w>l
endif
