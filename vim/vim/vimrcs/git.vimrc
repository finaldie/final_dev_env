Plug 'rhysd/git-messenger.vim'

nmap <Leader>gm <Plug>(git-messenger)

" options: 'none', 'current', 'all'. default: none
let g:git_messenger_include_diff = 'none'

" default: v:false
let g:git_messenger_always_into_popup = v:false
