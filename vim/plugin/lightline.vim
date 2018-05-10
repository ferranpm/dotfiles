let g:lightline = {}

let g:lightline.component = {
      \ 'directory': '%{fnamemodify(getcwd(),":t")}'
      \ }

let g:lightline.component_function = {
      \ 'gitbranch': 'fugitive#head'
      \ }

let g:lightline.active = {
      \ 'left': [ [ 'mode', 'paste' ],
      \           [ 'readonly', 'relativepath', 'modified' ] ],
      \ 'right': [ [ 'lineinfo', 'gitbranch', 'directory' ],
      \            [ 'percent' ],
      \            [ 'fileformat', 'fileencoding', 'filetype'] ] }
