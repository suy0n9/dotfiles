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
" Mapping
" ============================================================================
let mapleader = "\<Space>"
nnoremap <Leader>w :<C-u>w<CR>
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" Quickfix
nnoremap <silent> <C-p> :<C-u>cprevious<CR>
nnoremap <silent> <C-n> :<C-u>cnext<CR>

nnoremap <silent> <Leader>t :<C-u>Fern . -reveal=% -drawer -toggle -width=40<CR>

" Buffer
nnoremap <silent> <Space>p :bprevious<CR>
nnoremap <silent> <Space>n :bnext<CR>

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
Plug 'mtth/scratch.vim'
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

" ----------------------------------------------------------------------------
" FZF
" ----------------------------------------------------------------------------
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:fzf_layout = { 'down': '20%' }

" Files command with preview window
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

" Delete buffer command
" https://github.com/junegunn/fzf.vim/pull/733#issuecomment-559720813
function! s:list_buffers()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
  execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

command! BD call fzf#run(fzf#wrap({
    \ 'source': s:list_buffers(),
    \ 'sink*': { lines -> s:delete_buffers(lines) },
    \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
    \ }))

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
" fern
" ----------------------------------------------------------------------------
let g:fern#default_hidden=1
let g:fern#renderer = 'nerdfont'

" https://github.com/lambdalisue/fern.vim/issues/233#issuecomment-743101883
" Add dirs and files inside the brackets that need to remain hidden
let hide_dirs  = '^\%(\.git\|node_modules\)$'  " here you write the dir names
let hide_files = '\%(\.swp\)\+'                " here you write the file names
let g:fern#default_exclude = hide_dirs . '\|' . hide_files  " here you exclude them

" fern-preview.vim
function! s:fern_settings() abort
  nmap <silent> <buffer> p     <Plug>(fern-action-preview:toggle)
  nmap <silent> <buffer> <C-p> <Plug>(fern-action-preview:auto:toggle)
  nmap <silent> <buffer> <C-d> <Plug>(fern-action-preview:scroll:down:half)
  nmap <silent> <buffer> <C-u> <Plug>(fern-action-preview:scroll:up:half)
endfunction

augroup fern-settings
  autocmd!
  autocmd FileType fern call s:fern_settings()
augroup END

" glyph-palette.vim
augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END

" ----------------------------------------------------------------------------
" vim-airline
" ----------------------------------------------------------------------------
let g:airline_theme = 'bubblegum'
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled = 0
let g:airline#extensions#tabline#enabled = 1

let g:airline_left_sep=''
let g:airline_right_sep=''

" ----------------------------------------------------------------------------
" rainbow
" ----------------------------------------------------------------------------
let g:rainbow_active = 1

" ----------------------------------------------------------------------------
" sonictemplate-vim
" ----------------------------------------------------------------------------
let g:sonictemplate_vim_template_dir = [
    \ '$HOME/.vim/template'
\]

" ----------------------------------------------------------------------------
" scratch.vim
" ----------------------------------------------------------------------------
let g:scratch_filetype = 'markdown'
let g:scratch_autohide = 0

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

let g:gitgutter_sign_added = '.'
let g:gitgutter_sign_modified = '.'
let g:gitgutter_sign_removed = '.'
let g:gitgutter_sign_removed_first_line = '.'
let g:gitgutter_sign_modified_removed = '.'

" ----------------------------------------------------------------------------
" vim-lsp
" ----------------------------------------------------------------------------

autocmd BufWritePre *.go call execute(['LspCodeActionSync source.organizeImports', 'LspDocumentFormatSync'])

let g:lsp_diagnostics_enabled = 0       " disable diagnostics support

" Mappings
" --------------------------
nmap <Leader>d <plug>(lsp-definition)
nmap <Leader>r <plug>(lsp-references)
nmap <Leader>h <plug>(lsp-hover)

" debug
" --------------------------
" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('~/vim-lsp.log')
" let g:asyncomplete_log_file = expand('~/asyncomplete.log')

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

" Disabling conceal
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

" Highlight YAML front matter as used by Jekyll or Hugo.
let g:vim_markdown_frontmatter = 1

" ----------------------------------------------------------------------------
" vim-table-mode
" ----------------------------------------------------------------------------
let g:table_mode_corner='|'

" ----------------------------------------------------------------------------
" vim-terraform
" ----------------------------------------------------------------------------
let g:terraform_fmt_on_save = 1

" ----------------------------------------------------------------------------
" winresizer
" ----------------------------------------------------------------------------
let g:winresizer_vert_resize = 1
let g:winresizer_horiz_resize = 1

" ----------------------------------------------------------------------------
" ALE
" ----------------------------------------------------------------------------
let g:ale_fixers = {
            \ 'python': ['black', 'isort'],
            \}
let g:ale_fix_on_save = 1

let g:ale_linters = {
\   'python': ['flake8'],
\   'javascript': ['eslint'],
\   'html': ['htmlhint'],
\   'markdown': ['textlint']
\}
