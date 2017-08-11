let g:ctrlp_map='<c-q>'

nnoremap <c-p> :CtrlPBuffer<cr>
nnoremap <c-t> :CtrlPTag<cr>
nnoremap <c-g> :CtrlPBufTag<cr>

let g:ctrlp_open_multiple_files='i'
let g:ctrlp_match_current_file=0
let g:ctrlp_match_window='max:100,results:100'
let g:ctrlp_working_path_mode="w"
let g:ctrlp_prompt_mappings={
      \ 'PrtSelectMove("j")': ['<c-n>', '<down>'],
      \ 'PrtSelectMove("k")': ['<c-p>', '<up>'],
      \ 'PrtHistory(-1)': ['<c-j>'],
      \ 'PrtHistory(1)': ['<c-k>'],
      \ }

if executable("ag")
  let g:ctrlp_user_command='ag %s --nocolor -g ""'
  let g:ctrlp_use_caching=0
end
