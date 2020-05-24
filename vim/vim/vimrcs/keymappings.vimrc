" This is the bottom part of the vim-which-key mappings
" Notes: Be careful of this mapping file, this plugin's config seems only
" works with leaderKey = <Space>
" map leader to WhichKey
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>

nnoremap <silent> <localleader> :<c-u>WhichKey ','<CR>
vnoremap <silent> <localleader> :<c-u>WhichKeyVisual ','<CR>

" Register the which key map
call which_key#register('<Space>', "g:which_key_map")
call which_key#register(',', "g:which_key_map")

" Define prefix dictionary
let g:which_key_map = {}

" Insert descriptions
let g:which_key_map.f = {'name' : '+Term'}
let g:which_key_map.l = {'name' : '+LSP'}

" Single mappings
nnoremap <Leader><CR> :buffer#<CR>
let g:which_key_map['<CR>'] = 'Toggle last buffer'

" Group mappings
let g:which_key_map.b = {
      \ 'name' : '+Buffer' ,
      \ '1' : [':b 1'        , 'buffer 1']        ,
      \ '2' : [':b 2'        , 'buffer 2']        ,
      \ 'd' : [':bd'        , 'delete-buffer']   ,
      \ 'l' : [':ls'        , 'list-buffer']   ,
      \ 'h' : [':Startify'  , 'home-buffer']     ,
      \ 'n' : [':bnext'     , 'next-buffer']     ,
      \ 'p' : [':bprevious' , 'previous-buffer'] ,
      \ '?' : [':Buffers'   , 'fzf-buffer']      ,
      \ }

" v is for wiki
let g:which_key_map.v = {
      \ 'name' : '+Wiki' ,
      \ 'i' : ['<Plug>VimwikiIndex'   , 'Goto Index'],
      \ 'v' : [':MarkdownPreview'     , 'Open Preview'],
      \ }

let g:which_key_map.g = {
      \ 'name' : '+Git' ,
      \ 'l' : [':Git log'     , 'logs'],
      \ 'a' : [':Git add'     , 'add file'],
      \ 's' : [':Git status'  , 'status'],
      \ 'b' : [':Git blame'   , 'blame'],
      \ 'n' : ['<Plug>(GitGutterNextHunk)'   , 'Jump to next Hunk'],
      \ 'p' : ['<Plug>(GitGutterPrevHunk)'   , 'Jump to prev Hunk'],
      \ }

let g:which_key_map.m = {
      \ 'name' : '+Marks' ,
      \ 'm' : [':marks'     , 'Show marks'],
      \ }

" w is for window
let g:which_key_map['w'] = {
      \ 'name' : '+Windows' ,
      \ 'w' : ['<C-W>w'     , 'other-window']          ,
      \ 'd' : ['<C-W>c'     , 'delete-window']         ,
      \ '-' : ['<C-W>s'     , 'split-window-below']    ,
      \ '|' : ['<C-W>v'     , 'split-window-right']    ,
      \ '2' : ['<C-W>v'     , 'layout-double-columns'] ,
      \ 'h' : ['<C-W>h'     , 'window-left']           ,
      \ 'j' : ['<C-W>j'     , 'window-below']          ,
      \ 'l' : ['<C-W>l'     , 'window-right']          ,
      \ 'k' : ['<C-W>k'     , 'window-up']             ,
      \ 'H' : ['<C-W>5<'    , 'expand-window-left']    ,
      \ 'J' : ['resize +5'  , 'expand-window-below']   ,
      \ 'L' : ['<C-W>5>'    , 'expand-window-right']   ,
      \ 'K' : ['resize -5'  , 'expand-window-up']      ,
      \ '=' : ['<C-W>='     , 'balance-window']        ,
      \ 's' : ['<C-W>s'     , 'split-window-below']    ,
      \ 'v' : ['<C-W>v'     , 'split-window-below']    ,
      \ '?' : ['Windows'    , 'fzf-window']            ,
      \ }
