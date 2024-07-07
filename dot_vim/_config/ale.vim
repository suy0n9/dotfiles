UsePlugin 'ale'

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
