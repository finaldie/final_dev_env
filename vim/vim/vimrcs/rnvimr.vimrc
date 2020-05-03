if has('nvim')
  Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}

  tnoremap <silent> <M-i> <C-\><C-n>:RnvimrResize<CR>
  nnoremap <silent> <M-o> :RnvimrToggle<CR>
  tnoremap <silent> <M-o> <C-\><C-n>:RnvimrToggle<CR>
endif
