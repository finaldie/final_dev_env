Plug 'prabirshrestha/asyncomplete.vim'

" For asyncomplete.vim log
"let g:asyncomplete_log_file = expand('~/asyncomplete.log')

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

"imap <c-space> <Plug>(asyncomplete_force_refresh)

autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
