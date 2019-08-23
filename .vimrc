" ============================================================================
" Basic Setup
" ============================================================================
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

autocmd filetype html setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab
autocmd filetype javascript setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab
autocmd filetype sh  setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab

autocmd BufRead,BufNewFile *.tsv setfiletype tsv
autocmd filetype tsv  setlocal tabstop=4 noexpandtab
" autocmd BufWritePre * %s/\s\+$//e "Automatically removing all trailing whitespace

"" Searching
set hlsearch "ハイライト検索
set ignorecase "大文字/小文字の区別なく検索する
set smartcase "検索文字列に大文字が含まれている場合は区別して検索する
set incsearch "検索ワードの最初の文字を入力した時点で検索を開始する

autocmd QuickFixCmdPost *grep* cwindow

" ============================================================================
" Visual Settings
" ============================================================================
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

" ============================================================================
" Mapping
" ============================================================================
" inoremap { {}<Left>
" inoremap {<Enter> {}<Left><CR><ESC><S-o>
" inoremap ( ()<ESC>i
" inoremap (<Enter> ()<Left><CR><ESC><S-o>
" inoremap [ []<LEFT>
" inoremap " ""<LEFT>
" inoremap ' ''<LEFT>
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" ============================================================================
" Plugin
" ============================================================================
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'Yggdroot/indentLine'
Plug 'scrooloose/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'Shougo/unite.vim'

" git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" lang
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'mattn/emmet-vim'
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'stephpy/vim-yaml', { 'for': 'yaml' }
Plug 'plasticboy/vim-markdown', { 'for': ['markdown', 'mkd'] }
Plug 'kannokanno/previm', { 'for': ['markdown', 'mkd'] }
Plug 'tyru/open-browser.vim', { 'for': ['markdown', 'mkd'] }
Plug 'hashivim/vim-terraform', { 'for': 'tf' }

" Lint
Plug 'w0rp/ale'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" ----------------------------------------------------------------------------
" FZF
" ----------------------------------------------------------------------------
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:fzf_layout = { 'down': '20%' }

" ----------------------------------------------------------------------------
" ack.vim
" ----------------------------------------------------------------------------
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" ----------------------------------------------------------------------------
" indentLine
" ----------------------------------------------------------------------------
" disable conceal setting
let g:indentLine_concealcursor = ''

" ----------------------------------------------------------------------------
" nerdtree
" ----------------------------------------------------------------------------
" show dot file
let NERDTreeShowHidden=1
let g:NERDTreeNodeDelimiter = "\u00a0"

let NERDTreeIgnore = ['\.swp$']
" ----------------------------------------------------------------------------
" vim-nerdtree-syntax-highlight
" ----------------------------------------------------------------------------
let g:NERDTreeLimitedSyntax = 1

" ----------------------------------------------------------------------------
" vim-airline
" ----------------------------------------------------------------------------
let g:airline_theme = 'angr'
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let b:airline_whitespace_disabled = 1

" ----------------------------------------------------------------------------
" vim-gitgutter
" ----------------------------------------------------------------------------
"let g:gitgutter_highlight_lines = 1
let g:gitgutter_override_sign_column_highlight = 0
highlight clear SignColumn
highlight GitGutterAdd ctermfg=2
highlight GitGutterChange ctermfg=3
highlight GitGutterDelete ctermfg=1
highlight GitGutterChangeDelete ctermfg=4

" ----------------------------------------------------------------------------
" vim-devicons
" ----------------------------------------------------------------------------
let g:webdevicons_enable_nerdtree = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1

" ----------------------------------------------------------------------------
" vim-go
" ----------------------------------------------------------------------------
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_fmt_command = "goimports"

" ----------------------------------------------------------------------------
" vim-json
" ----------------------------------------------------------------------------
"To conceal disable
let g:vim_json_syntax_conceal = 0

" how to use :help concealcursor
let g:indentLine_concealcursor = 'nc'

" ----------------------------------------------------------------------------
" emmet
" ----------------------------------------------------------------------------
" Enable just for html/css
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" ----------------------------------------------------------------------------
" vim-markdown
" ----------------------------------------------------------------------------
" To disable the folding configuration
let g:vim_markdown_folding_disabled = 1

" Disabling conceal for code fences
let g:vim_markdown_conceal_code_blocks = 0

" ----------------------------------------------------------------------------
" vim-terraform
" ----------------------------------------------------------------------------
let g:terraform_fmt_on_save = 1

" ----------------------------------------------------------------------------
" ALE
" ----------------------------------------------------------------------------
let g:ale_linters = {
\   'python': ['flake8'],
\   'javascript': ['eslint'],
\   'html': ['htmlhint']
\}
