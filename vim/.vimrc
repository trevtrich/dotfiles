set nocompatible

source ~/.vim/plugins.vim
source ~/.vim/settings.vim
source ~/.vim/remap.vim
source ~/.vim/autocmd.vim

if filereadable("~/.files.extra/vim/.vim/settings.vim")
  source ~/.files.extra/vim/.vim/settings.vim
endif

silent! so .vimlocal
