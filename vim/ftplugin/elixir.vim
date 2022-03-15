if exists("b:elixir_ftplugin")
  finish
endif
let b:elixir_ftplugin = 1

nnoremap <buffer> <silent> <leader>t :update \| call ElixirTest()<cr>

function! ElixirTest()
  let filename = expand("%")
  let string = "elixir ".filename

  let @*=string
  echo "Test copied: ".@*
endfunction



