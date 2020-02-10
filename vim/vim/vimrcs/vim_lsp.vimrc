Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

"" Github: https://github.com/prabirshrestha/vim-lsp

"" Short-Cuts
function SetVimLSPShortcuts()
  nnoremap <leader><leader>ld :LspDefinition<CR>
  nnoremap <leader><leader>lr :LspRename<CR>
  nnoremap <leader><leader>lf :LspDocumentFormat<CR>
  nnoremap <leader><leader>lt :LspTypeDefinition<CR>
  nnoremap <leader><leader>lx :LspReferences<CR>
  nnoremap <leader><leader>lh :LspHover<CR>
  nnoremap <leader><leader>ls :LspDocumentSymbol<CR>
  nnoremap <leader><leader>lw :LspWorkspaceSymbol<CR>  " Search/Show workspace symbol
endfunction()

"" No shortcut commands
" :LspCodeAction     Gets a list of possible commands that can be applied to a file so it can be fixed (quick fix)
" :LspDocumentDiagnostics Get current document diagnostics information
" :LspDocumentRangeFormat Format document selection
" :LspImplementation      Show implementation of interface
" :LspNextError           Jump to next error
" :LspPreviousError       Jump to previous error
" :LspStatus              Show the status of the language server
" :LspTypeHierarchy       View type hierarchy of the symbol under the cursor

augroup VimLSP_config
  autocmd!
  autocmd FileType * call SetVimLSPShortcuts()
augroup END

"" Global settings
"  Enable signs
let g:lsp_signs_enabled = 1

" enable echo under cursor when in normal mode
let g:lsp_diagnostics_enabled = 0
let g:lsp_diagnostics_echo_cursor = 1

let g:lsp_signs_error = {'text': '✗'}
"let g:lsp_signs_warning = {'text': '‼', 'icon': '/path/to/some/icon'} " icons require GUI
"let g:lsp_signs_hint = {'icon': '/path/to/some/other/icon'} " icons require GUI
let g:lsp_signs_information = {'text': 'i'}

let g:lsp_highlight_references_enabled = 1

"" Debug
"let g:lsp_log_verbose = 1
"let g:lsp_log_file = expand('~/vim-lsp.log')

" For asyncomplete.vim log
"let g:asyncomplete_log_file = expand('~/asyncomplete.log')

"" LSP Servers
"" ------------------ Python lsp server ---------------------
if executable('pyls')
    " pip3 install python-language-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ 'workspace_config': {'pyls': {'plugins': {'pydocstyle': {'enabled': v:true}}}}
        \ })
endif

if executable('clangd')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd', '-background-index']},
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
        \ })

    autocmd FileType c setlocal omnifunc=lsp#complete
    autocmd FileType cpp setlocal omnifunc=lsp#complete
    autocmd FileType objc setlocal omnifunc=lsp#complete
    autocmd FileType objcpp setlocal omnifunc=lsp#complete
endif

"if executable('ccls')
"   au User lsp_setup call lsp#register_server({
"      \ 'name': 'ccls',
"      \ 'cmd': {server_info->['ccls']},
"      \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
"      \ 'initialization_options': { 'cacheDirectory': '.ccls-cache' },
"      \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
"      \ })
"endif

"if executable('cquery')
"   au User lsp_setup call lsp#register_server({
"      \ 'name': 'cquery',
"      \ 'cmd': {server_info->['cquery']},
"      \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
"      \ 'initialization_options': { 'cacheDirectory': '/path/to/cquery/cache' },
"      \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
"      \ })
"endif

if executable('bash-language-server')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'bash-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'bash-language-server start']},
        \ 'whitelist': ['sh'],
        \ })
endif
