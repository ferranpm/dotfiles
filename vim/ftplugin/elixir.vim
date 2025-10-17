nnoremap <buffer> <silent> <leader>t :update \| call MixTest()<cr>

function! MixTest()
  let line = line(".")
  let filename = expand("%")

  let @*="mix test ".filename.":".line
  echo "Test copied: ".@*
endfunction
