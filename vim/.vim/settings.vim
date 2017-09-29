filetype plugin indent on
syntax enable

" General Config
colorscheme onedark
set guifont=Source\ Code\ Pro
set autoindent
set ruler
set visualbell
set showcmd

set scrolloff=10                " Start scrolling this number of lines from top/bottom

set smarttab                    " Make Tab work fine with spaces
set backspace=indent,eol,start  " Make backspace work as expected on all systems

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
hi CursorLine cterm=bold ctermbg=237 guibg=#3a3a3a
hi Visual cterm=bold ctermbg=244 guibg=#3a3a3a

set hlsearch                    " Highlight searches
set ignorecase                  " Ignore case of searches
set smartcase                   " Unless a capital letter is used in the search
set incsearch                   " Highlight dynamically as pattern is typed

" Fuzzy file search
set path+=**
set wildmenu
set wildignore+=**/node_modules/**
set wildignore+=**/.git/**
set wildignore+=**/lib/**

" Syntastic setup
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe='$(npm bin)/eslint'
