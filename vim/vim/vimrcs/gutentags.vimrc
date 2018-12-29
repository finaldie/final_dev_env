Plug 'ludovicchabant/vim-gutentags'

"" Auto re-generate tags
"" https://github.com/ludovicchabant/vim-gutentags

"" Run ':h gutentags' for more information

" don't generate tags when open a new file
let g:gutentags_generate_on_new = 0

" generate tags on file save, default is 1
" Run :GutentagsUpdate to refresh tag for current buffer
" Run :GutentagsUpdate! to refresh tag for whole project
let g:gutentags_generate_on_write = 0
