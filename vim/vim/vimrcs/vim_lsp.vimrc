Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'

"" Github: https://github.com/prabirshrestha/vim-lsp

"" Short-Cuts
function SetVimLSPShortcuts()
  nnoremap <leader>lD  :LspPeekDefinition<CR>
  nnoremap <leader>ld  :LspDefinition<CR>
  nnoremap <leader>lr  :LspRename<CR>

  nnoremap <leader>lt  :LspPeekTypeDefinition<CR>
  nnoremap <leader>lT  :LspTypeDefinition<CR>
  nnoremap <leader>lH  :LspTypeHierarchy<CR>
  nnoremap <leader>lh  :LspHover<CR>

  nnoremap <leader>lf  :LspReferences<CR>
  nnoremap <leader>ls  :LspDocumentSymbol<CR>
  nnoremap <leader>lw  :LspWorkspaceSymbol<CR>  " Search/Show workspace symbol

  nnoremap <leader>la  :LspCodeAction<CR>
  nnoremap <leader>lc  :LspCodeLens<CR>
  nnoremap <leader>ln  :LspNextError<CR>
  nnoremap <leader>lp  :LspPreviousError<CR>
  nnoremap <leader>lS  :LspStatus<CR>
endfunction()

"" No shortcut commands
" :LspDocumentDiagnostics Get current document diagnostics information
" :LspDocumentRangeFormat Format document selection
" :LspImplementation      Show implementation of interface

augroup VimLSP_config
  autocmd!
  autocmd FileType * call SetVimLSPShortcuts()
augroup END

function! s:on_lsp_buffer_enabled() abort
  " Omnifunc will be taken care by asyncomplete
  "setlocal omnifunc=lsp#complete
  "setlocal signcolumn=yes

  if exists('+tagfunc')
    setlocal tagfunc=lsp#tagfunc
  endif

  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> <f2> <plug>(lsp-rename)
  " refer to doc to add more commands
endfunction

augroup lsp_install
  au!
  " call s:on_lsp_buffer_enabled only for languages that has the server registered.
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
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

"" LSP Servers (Below are optional since vim-lsp-settings plugin are handling
""              all these parts)
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

"if executable('bash-language-server')
"  au User lsp_setup call lsp#register_server({
"        \ 'name': 'bash-language-server',
"        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'bash-language-server start']},
"        \ 'whitelist': ['sh'],
"        \ })
"endif
