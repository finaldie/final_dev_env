Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"" Github: https://github.com/junegunn/fzf

"" This one install fzf vim plugin, not the binary command line tool

" Empty value to disable preview window altogether
" let g:fzf_preview_window = ''

" Always enable preview window on the right with 60% width
" let g:fzf_preview_window = 'right:60%'
" let g:fzf_preview_window = 'up:60%'
let g:fzf_preview_window = 'down:60%'

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" git grep wrap
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)
