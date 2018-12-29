Plug 'autozimu/LanguageClient-neovim', {'branch': 'next'}

"" https://github.com/autozimu/LanguageClient-neovim

let g:LanguageClient_autoStart = 1

""" Links
"" For clangd integration: https://github.com/autozimu/LanguageClient-neovim/wiki/Clangd
"" For cquery integration: https://github.com/autozimu/LanguageClient-neovim/wiki/cquery

"" Client side shortcuts
function SetLSPShortcuts()
  nnoremap <leader>ld :call LanguageClient#textDocument_definition({'gotoCmd': 'split'})<CR>
  nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
  nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
  nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
  nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
  nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
  nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
  nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
  nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
  nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
endfunction()

augroup LSP
  autocmd!
  autocmd FileType cpp,c,python call SetLSPShortcuts()
augroup END

"""
"" Backends
""  - Clang6: Cannot customize 'include' path which causes a lot of undefined
""            errors. TODO: Re-evaluate the 'compile_commands.json'
""  - Python: palantir/python-language-server. Current problem is, it's not
""            that fast, disable it for now since the lint part is handled by
""            ALE. In next, consider to create a ls-settings.json to disable
""            those lint functionality from pyls

" For Python server pyls
""  \ 'python': ['pyls'],
"
" For C/C++ server clangd
"  \ 'c': ['clangd'],
"  \ 'cpp': ['clangd'],
"
" For C/C++ server cquery
"  \ 'c': ['/usr/local/bin/cquery',
"  \   '--log-file=/tmp/cq.log',
"  \   '--init={"cacheDirectory":"/var/cquery/"}'],"
"  \ 'cpp': ['/usr/local/bin/cquery',
"  \   '--log-file=/tmp/cq.log',
"  \   '--init={"cacheDirectory":"/var/cquery/"}'],"
"
" For C/C++ server ccls
"  \ 'c': ['/usr/local/bin/ccls', '--log-file=/tmp/cc.log'],
"  \ 'cpp': ['/usr/local/bin/ccls', '--log-file=/tmp/cc.log'],

let g:LanguageClient_serverCommands = {
  \ }

"let g:LanguageClient_loadSettings = 1
"let g:LanguageClient_settingsPath = 'ls-settings.json'
