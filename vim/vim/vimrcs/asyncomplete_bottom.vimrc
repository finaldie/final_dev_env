" --------------------- Asyncomplete data source bottom ----------------------

" Snippets: Ultisnips registration
if has('python3')
  " Trigger configuration. Do not use <tab> if you use
  " https://github.com/Valloric/YouCompleteMe.
  let g:UltiSnipsExpandTrigger="<tab>"

  "let g:UltiSnipsExpandTrigger="<c-e>"
  "let g:UltiSnipsExpandTrigger="<c-\>"

  "let g:UltiSnipsJumpForwardTrigger="<c-b>"
  "let g:UltiSnipsJumpBackwardTrigger="<c-z>"

  " If you want :UltiSnipsEdit to split your window.
  let g:UltiSnipsEditSplit="vertical"

  call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
    \ 'name': 'ultisnips',
    \ 'whitelist': ['*'],
    \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
    \ }))

endif

" Buffer completion registration
call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
  \ 'name': 'buffer',
  \ 'whitelist': ['*'],
  \ 'blacklist': ['go'],
  \ 'completor': function('asyncomplete#sources#buffer#completor'),
  \ 'config': {
  \    'max_buffer_size': 5000000,
  \  },
  \ }))

" Filename completion registration
call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
  \ 'name': 'file',
  \ 'whitelist': ['*'],
  \ 'priority': 10,
  \ 'completor': function('asyncomplete#sources#file#completor')
  \ }))

" Tmux-complete
" n/a
