if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let g:coc_global_extensions = [
\ 'coc-json',
\ 'coc-tsserver',
\ 'coc-pyright',
\ 'coc-html',
\ 'coc-css',
\ 'coc-yaml',
\ 'coc-highlight'
\ ]

call plug#begin('~/.vim/plugged')

" let Vundle manage Vundle, required
Plug 'VundleVim/Vundle.vim'

Plug 'joshdick/onedark.vim'
Plug 'arzg/vim-colors-xcode'
Plug 'tpope/vim-fugitive'
Plug 'editorconfig/editorconfig-vim'
Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'ctrlpvim/ctrlp.vim'
"Plug 'mileszs/ack.vim'
Plug 'airblade/vim-gitgutter'
"Plug 'tpope/vim-surround'
"Plug 'ycm-core/YouCompleteMe'
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': { -> coc#util#install() } }

if filereadable("~/.files.extra/vim/.vim/plugins.vim")
  source ~/.files.extra/vim/.vim/plugins.vim
endif

call plug#end()
