let g:fzf_preview_window = []
let $FZF_DEFAULT_COMMAND='ag -g .'

let g:fzf_layout = { 'window' : 'tabe' }

command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, {'options': ['-i']}, <bang>0)
command! -bang -nargs=? -complete=dir Buffers call fzf#vim#buffers(<q-args>, {'options': ['-i']}, <bang>0)
