UsePlugin 'fern.vim'

" mapping
nnoremap <silent> <Leader>t :<C-u>Fern . -reveal=% -drawer -toggle -width=40<CR>

" customize fern buffer
function! s:init_fern() abort
    nmap <buffer> i <Plug>(fern-action-open:split)
    nmap <buffer> s <Plug>(fern-action-open:vsplit)
endfunction
augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END

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
