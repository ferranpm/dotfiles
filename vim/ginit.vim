colorscheme monokai

GuiFont Anonymous Pro:h11

augroup guiau
    autocmd!
    autocmd DirChanged * call rpcnotify(0, 'Dir', getcwd())
augroup END

command! TreeViewShow call rpcnotify(0, 'TreeView', 'ShowHide', 1)
command! TreeViewHide call rpcnotify(0, 'TreeView', 'ShowHide', 0)
command! TreeViewToggle call rpcnotify(0, 'TreeView', 'Toggle')

nnoremap <silent> <leader>t :TreeViewToggle<cr>
