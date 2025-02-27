" ~/.vim/plugins.vim
"
call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree'
" Add other plugins here
call plug#end()

" Automatically open NERDTree when Vim starts
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

" NERDTree keybinding
nnoremap <C-n> :NERDTreeToggle<CR>

