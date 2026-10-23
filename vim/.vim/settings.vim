filetype plugin indent on
syntax enable

" General Config
set updatetime=100
autocmd BufLeave,FocusLost * silent! wall " Save buffer on focus lost or change buffers
set autowrite
set autoread
"colorscheme molokai
colorscheme onedark
set guifont=Source\ Code\ Pro
set autoindent
set nowrap
set ruler
set visualbell
set showcmd
set relativenumber
set splitright

"let g:netrw_liststyle=3 " Display a tree by default (switcher using `i` in netrw)
let g:netrw_banner=0 " Get rid of the banner on top
"set tabline=%N/\%t

set scrolloff=10                " Start scrolling this number of lines from top/bottom

set smarttab                    " Make Tab work fine with spaces
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
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
set cursorline                  " Highlight current line
hi CursorLine cterm=bold ctermbg=237 guibg=#3a3a3a
hi Visual cterm=bold ctermbg=244 guibg=#3a3a3a

set hlsearch                    " Highlight searches
set ignorecase                  " Ignore case of searches
set smartcase                   " Unless a capital letter is used in the search
set incsearch                   " Highlight dynamically as pattern is typed

set colorcolumn=120
highlight ColorColumn ctermbg=39

" Colorful JSX
let g:vim_jsx_pretty_colorful_config = 1

" Coc Settings
let g:coc_disable_transparent_cursor = 1

" Cursor settings for different modes
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
  \,sm:block-blinkwait175-blinkoff150-blinkon175

" Terminal cursor shape support
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>[6 q\<Esc>\\"  " Insert mode - line cursor
  let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>[4 q\<Esc>\\"  " Replace mode - underline cursor
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>[2 q\<Esc>\\"  " Normal mode - block cursor
else
  let &t_SI = "\<Esc>[6 q"  " Insert mode - line cursor
  let &t_SR = "\<Esc>[4 q"  " Replace mode - underline cursor
  let &t_EI = "\<Esc>[2 q"  " Normal mode - block cursor
endif

" Reset cursor to block on startup and when leaving vim
augroup ResetCursorShape
  autocmd!
  if exists('$TMUX')
    autocmd VimEnter * silent! execute "!echo -ne '\\ePtmux;\\e\\e[2 q\\e\\\\'"
    autocmd VimLeave * silent! execute "!echo -ne '\\ePtmux;\\e\\e[2 q\\e\\\\'"
  else
    autocmd VimEnter * silent! execute "!echo -ne '\\e[2 q'"
    autocmd VimLeave * silent! execute "!echo -ne '\\e[2 q'"
  endif
augroup END

" Fuzzy file search
set path=$PWD/**
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/](\.git|lib|coverage|cypress|static|node_modules)$',
            \ 'file': '\v(tags|\.swp)$',
            \ }
let g:ctrlp_max_files=0

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

set wildmenu
