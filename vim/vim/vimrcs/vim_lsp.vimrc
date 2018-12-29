Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'

"" Github: https://github.com/prabirshrestha/vim-lsp

"" Global settings
" enable signs
let g:lsp_signs_enabled = 1

" enable echo under cursor when in normal mode
let g:lsp_diagnostics_echo_cursor = 1

"let g:lsp_signs_error = {'text': '✗'}
"let g:lsp_signs_warning = {'text': '‼', 'icon': '/path/to/some/icon'} " icons require GUI
"let g:lsp_signs_hint = {'icon': '/path/to/some/other/icon'} " icons require GUI
"let g:lsp_signs_information = {'text': 'i'}

"" Debug
"let g:lsp_log_verbose = 1
"let g:lsp_log_file = expand('~/vim-lsp.log')

" for asyncomplete.vim log
"let g:asyncomplete_log_file = expand('~/asyncomplete.log')

"" LSP Servers
"" ------------------ Python lsp server ---------------------
"if executable('pyls')
"    " pip install python-language-server
"    au User lsp_setup call lsp#register_server({
"        \ 'name': 'pyls',
"        \ 'cmd': {server_info->['pyls']},
"        \ 'whitelist': ['python'],
"        \ })
"endif
"
"if executable('clangd')
"    au User lsp_setup call lsp#register_server({
"        \ 'name': 'clangd',
"        \ 'cmd': {server_info->['clangd']},
"        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
"        \ })
"
"    autocmd FileType c setlocal omnifunc=lsp#complete
"    autocmd FileType cpp setlocal omnifunc=lsp#complete
"    autocmd FileType objc setlocal omnifunc=lsp#complete
"    autocmd FileType objcpp setlocal omnifunc=lsp#complete
"endif
"
"if executable('ccls')
"   au User lsp_setup call lsp#register_server({
"      \ 'name': 'ccls',
"      \ 'cmd': {server_info->['ccls']},
"      \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
"      \ 'initialization_options': { 'cacheDirectory': '.ccls-cache' },
"      \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
"      \ })
"endif
"
"if executable('cquery')
"   au User lsp_setup call lsp#register_server({
"      \ 'name': 'cquery',
"      \ 'cmd': {server_info->['cquery']},
"      \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
"      \ 'initialization_options': { 'cacheDirectory': '/path/to/cquery/cache' },
"      \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
"      \ })
"endif

