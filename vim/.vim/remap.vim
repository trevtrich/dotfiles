nnoremap <leader>ev :vsplit $MYVIMRC<cr>    " edit the .vimrc in a split pane
nnoremap <leader>sv :source $MYVIMRC<cr>    " source the .vimrc to make changes take effect in current session

" some key remappings to improve my use
inoremap jk <esc>
inoremap <esc> <nop>

" JS Dev Helpers
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nmap <Leader>tt :!npm run tests:unit 2> /dev/null<CR>
nmap <Leader>ti :!npm run tests:integration 2> /dev/null<CR>
nmap <Leader>ll  :!npm run lint:js:fix 2> /dev/null<CR><CR>
