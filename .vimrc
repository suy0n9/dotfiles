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
set belloff=all

"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs
set tabstop=4
set expandtab
set smarttab
set shiftwidth=4
set smartindent

"" cursor
set cursorline

autocmd filetype html       setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab
autocmd filetype javascript setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab
autocmd filetype sh         setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab
autocmd filetype yml        setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab
autocmd filetype yaml       setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab

autocmd BufRead,BufNewFile *.tsv setfiletype tsv
autocmd filetype tsv  setlocal tabstop=4 noexpandtab

" Turn off paste mode when leaving insert
autocmd InsertLeave * set nopaste

"Automatically removing trailing whitespace
fun! StripTrailingWhiteSpace()
    " don't strip on these filetypes
    if &ft =~ 'markdown'
        return
    endif
    %s/\s\+$//e
endfun
autocmd BufWritePre * :call StripTrailingWhiteSpace()

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
" Plugin
" ============================================================================
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'Yggdroot/indentLine'

" filer
Plug 'lambdalisue/fern.vim'
Plug 'yuki-yano/fern-preview.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/glyph-palette.vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'Shougo/unite.vim'
Plug 'luochen1990/rainbow'
Plug 'mechatroner/rainbow_csv'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'mattn/sonictemplate-vim'
Plug 'dhruvasagar/vim-table-mode'
Plug 'simeji/winresizer'

" git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" lsp
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

" lang
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'mattn/emmet-vim'
Plug 'gko/vim-coloresque'
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'stephpy/vim-yaml', { 'for': 'yaml' }
Plug 'plasticboy/vim-markdown', { 'for': ['markdown', 'mkd'] }
Plug 'kannokanno/previm', { 'for': ['markdown', 'mkd'] }
Plug 'tyru/open-browser.vim', { 'for': ['markdown', 'mkd'] }
Plug 'hashivim/vim-terraform', { 'for': 'tf' }

" Lint
Plug 'w0rp/ale'
Plug 'editorconfig/editorconfig-vim'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" load split vimrc
" https://zenn.dev/mattn/articles/565c4ec71f461cbbf5c9
let s:plugs = get(s:, 'plugs', get(g:, 'plugs', {}))
function! FindPlugin(name) abort
  return has_key(s:plugs, a:name) ? isdirectory(s:plugs[a:name].dir) : 0
endfunction
command! -nargs=1 UsePlugin if !FindPlugin(<args>) | finish | endif

runtime! _config/*.vim
