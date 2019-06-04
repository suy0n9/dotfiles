"*****************************************************************************
"" Plugin
"*****************************************************************************
runtime! rc/dein/dein.vim
set rtp+=/usr/local/opt/fzf

"*****************************************************************************
"" Basic Setup
"*****************************************************************************
set encoding=UTF-8
set ambiwidth=double
set nrformats-=octal
set hidden "保存されていないファイルがある時でも別のファイルを開くことが出来る
set history=50
set virtualedit=block
set whichwrap=b,s,[,],<,>
set wildmenu

"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs
set tabstop=4
set expandtab
set smarttab
set shiftwidth=4
set smartindent

filetype plugin indent on

autocmd filetype html setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab
autocmd filetype javascript setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab
autocmd filetype sh  setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab

au BufRead,BufNewFile *.tsv setfiletype tsv
autocmd filetype tsv  setlocal tabstop=4 noexpandtab

"" Searching
set hlsearch "ハイライト検索
set ignorecase "大文字/小文字の区別なく検索する
set smartcase "検索文字列に大文字が含まれている場合は区別して検索する
set incsearch "検索ワードの最初の文字を入力した時点で検索を開始する

autocmd QuickFixCmdPost *grep* cwindow

"*****************************************************************************
"" Visual Settings
"*****************************************************************************
syntax enable
colorscheme Tomorrow-Night-Bright
set updatetime=100
set number
set title

set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%

"" Statusline
set laststatus=2

"" Show gitgutter column always
set signcolumn=yes

"*****************************************************************************
"" Mapping
"*****************************************************************************
" inoremap { {}<Left>
" inoremap {<Enter> {}<Left><CR><ESC><S-o>
" inoremap ( ()<ESC>i
" inoremap (<Enter> ()<Left><CR><ESC><S-o>
" inoremap [ []<LEFT>
" inoremap " ""<LEFT>
" inoremap ' ''<LEFT>
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
