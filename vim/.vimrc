set nocompatible

let vundle_readme=expand($HOME.'/.vim/bundle/Vundle.vim/README.md')
if !filereadable(vundle_readme)
	echo "Installing Vundle..."
	echo ""
	silent !mkdir -p $HOME/.vim/bundle
	silent !git clone https://github.com/gmarik/Vundle.vim $HOME/.vim/bundle/Vundle.vim
endif

filetype off " required to enable filetype checking to include types from vundle managed plugins
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'editorconfig-vim'
Plugin 'rodjek/vim-puppet'

" All of your Plugins must be added before the following line
call vundle#end()            " required

filetype plugin indent on
syntax on

" General Config
colorscheme icansee
set background=dark
set guifont=Meslo\ LG\ M:h17
set autoindent
set ruler
set visualbell
set showcmd

set scrolloff=10                " Start scrolling this number of lines from top/bottom

set smarttab                    " Make Tab work fine with spaces

set showmatch                   " show matching brackets
set matchtime=5                 " tenths of a second to blink matching brackets

set list                        " show tabs, trailings spaces, ...
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<

set encoding=utf-8              " Let Vim use utf-8 internally
set fileencoding=utf-8          " Default for new files
set termencoding=utf-8          " Terminal encoding
set fileformats=unix,dos,mac    " support all three, in this order
set fileformat=unix             " default file format

set nonu                        " Turn off line numbering
set lbr                         " Wrap text
set cursorline                  " Highlight current line

set hlsearch                    " Highlight searches
set ignorecase                  " Ignore case of searches
set incsearch                   " Highlight dynamically as pattern is typed

" Automatic commands
if has("autocmd")
    " Enable file type detection
    filetype on
    " Treat .json files as .js
    autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript

    " Remember last position in file
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif
