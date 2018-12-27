Plugin 'Shougo/deoplete.nvim'

if !has('nvim')
    Plugin 'roxma/nvim-yarp'
    Plugin 'roxma/vim-hug-neovim-rpc'
endif

let g:deoplete#enable_at_startup = 1

" Disable deoplete for c/c++/python. For these types use YCM to do the
" omnifunc triggering(completion triggering)
autocmd FileType cpp,c,python
       \ call deoplete#custom#buffer_option('auto_complete', v:false)

