" ================= Setup data sources for asyncompletion ====================

" vim-lsp as source
Plug 'prabirshrestha/asyncomplete-lsp.vim'

" Snippets: Ultisnips
if has('python3')

  " Snippets Engine
  Plug 'SirVer/ultisnips'

  " More snippets
  Plug 'honza/vim-snippets'

  Plug 'prabirshrestha/asyncomplete-ultisnips.vim'
endif

Plug 'thomasfaingnaert/vim-lsp-snippets'
Plug 'thomasfaingnaert/vim-lsp-ultisnips'

" Buffer source
Plug 'prabirshrestha/asyncomplete-buffer.vim'

" Filename completion
Plug 'prabirshrestha/asyncomplete-file.vim'

" Word completion from nearby Tmux panes
Plug 'wellle/tmux-complete.vim'

let g:tmuxcomplete#asyncomplete_source_options = {
  \ 'name':      'tmuxcomplete',
  \ 'whitelist': ['*'],
  \ 'config': {
  \     'splitmode':      'words',
  \     'filter_prefix':   1,
  \     'show_incomplete': 1,
  \     'sort_candidates': 0,
  \     'scrollback':      0,
  \     'truncate':        0
  \     }
  \ }
