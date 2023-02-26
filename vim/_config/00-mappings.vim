let mapleader = "\<Space>"
nnoremap <Leader>w :<C-u>w<CR>
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" Quickfix
nnoremap <silent> <C-p> :<C-u>cprevious<CR>
nnoremap <silent> <C-n> :<C-u>cnext<CR>

" Buffer
nnoremap <silent> <Space>p :bprevious<CR>
nnoremap <silent> <Space>n :bnext<CR>
