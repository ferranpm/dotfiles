let g:fzf_preview_window = []

let g:fzf_layout = { 'window' : { 'width': 0.85, 'height': 0.85 } }

let opts = [ '--layout=reverse', '--info=inline', '--ignore-case' ]
let file_opts = extendnew(opts, [ '--preview', '~/.vim/bundle/fzf.vim/bin/preview.sh {}' ])

command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, { 'options': file_opts }, <bang>0)
command! -bang -nargs=? -complete=dir Buffers call fzf#vim#buffers(<q-args>, { 'options': file_opts }, <bang>0)
command! -bang -nargs=? -complete=dir Tags call fzf#vim#tags(<q-args>, { 'options': opts }, <bang>0)
