UsePlugin 'vim-lsp'

autocmd BufWritePre *.go call execute(['LspCodeActionSync source.organizeImports', 'LspDocumentFormatSync'])

let g:lsp_diagnostics_enabled = 0       " disable diagnostics support

" mapping
" --------------------------
nmap <Leader>d <plug>(lsp-definition)
nmap <Leader>r <plug>(lsp-references)
nmap <Leader>h <plug>(lsp-hover)

" debug
" --------------------------
" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('~/vim-lsp.log')
" let g:asyncomplete_log_file = expand('~/asyncomplete.log')
