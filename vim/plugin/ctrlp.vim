nnoremap <C-q> :CtrlP<cr>
nnoremap <C-t> :CtrlPTag<cr>

let g:ctrlp_cmd = 'CtrlPBuffer'
let g:ctrlp_by_filename=0
let g:ctrlp_max_files=0
let g:ctrlp_max_height=100
let g:ctrlp_show_hidden=0
let g:ctrlp_use_caching=0
let g:ctrlp_working_path_mode='0'

if executable('ag')
    let g:ctrlp_user_command = 'ag %s --files-with-matches --nocolor -g "" --ignore-dir node_modules'
endif

let g:ctrlp_buffer_func = { 'enter': 'CtrlPMappings' }

function! CtrlPMappings()
  nnoremap <buffer> <silent> <C-@> :call <sid>DeleteBuffer()<cr>
endfunction

function! s:DeleteBuffer()
  let path = fnamemodify(getline('.')[2:], ':p')
  echo path
  let bufn = matchstr(path, '\v\d+\ze')
  execute "bwipeout" . bufn
  execute "normal \<F5>"
endfunction
