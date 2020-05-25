
" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"

"let g:UltiSnipsExpandTrigger="<c-e>"
"let g:UltiSnipsExpandTrigger="<c-\>"
"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
  \ 'name': 'ultisnips',
  \ 'whitelist': ['*'],
  \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
  \ }))
