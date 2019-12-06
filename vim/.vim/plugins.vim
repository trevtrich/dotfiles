let vundle_readme=expand($HOME.'/.vim/bundle/Vundle.vim/README.md')
if !filereadable(vundle_readme)
	echo "Installing Vundle..."
	echo ""
	silent !mkdir -p $HOME/.vim/bundle
	silent !git clone https://github.com/VundleVim/Vundle.vim $HOME/.vim/bundle/Vundle.vim
endif

filetype off " required to enable filetype checking to include types from vundle managed plugins
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'joshdick/onedark.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'pangloss/vim-javascript'
Plugin 'MaxMEllon/vim-jsx-pretty'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'mileszs/ack.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-surround'
Plugin 'ycm-core/YouCompleteMe'

if filereadable("~/.files.extra/vim/.vim/plugins.vim")
  source ~/.files.extra/vim/.vim/plugins.vim
endif

" All of your Plugins must be added before the following line
call vundle#end()            " required
