nnoremap <leader>ev :vsplit $MYVIMRC<cr>    " edit the .vimrc in a split pane
nnoremap <leader>sv :source $MYVIMRC<cr>    " source the .vimrc to make changes take effect in current session

" global remappings to improve my use
nmap <Leader>E :Explore<CR>
nmap <Leader>to :tabonly<CR>
inoremap jk <esc>
inoremap <esc> <nop>
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>

" File browsing
nmap <Leader>ff :CtrlP<CR>

" Grep Stuff "
" grep global
nmap <Leader>sg :Ack<Space>
" search and replace in files found for grep global with confirmation
nmap <Leader>sr :cfdo %s///gc<Left><Left><Left><Left>
nnoremap ]q :cnext<cr>
nnoremap [q :cprevious<cr>

" General dev helpers
nmap <silent> rr <Plug>(coc-rename)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)"

" JS Dev Helpers
nmap <Leader>rt :!ctags -R --exclude=.git --exclude=lib --exclude=node_modules . 2> /dev/null<CR>
nmap <Leader>tt :!npm run test:unit:base<CR>
nmap <Leader>ti :!npm run test:integration 2> /dev/null<CR>
nmap <Leader>ll  :!npm run lint:js:fix % 2> /dev/null<CR><CR>
