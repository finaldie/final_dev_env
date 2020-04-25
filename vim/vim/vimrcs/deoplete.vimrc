if has('nvim')
  Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'lighttiger2505/deoplete-vim-lsp'

let g:deoplete#enable_at_startup = 1

" Disable deoplete for c/c++/python. For these types use YCM to do the
" omnifunc triggering(completion triggering)
"autocmd FileType cpp,c,python
"       \ call deoplete#custom#buffer_option('auto_complete', v:false)

