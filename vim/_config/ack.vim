UsePlugin 'ack.vim'

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif


