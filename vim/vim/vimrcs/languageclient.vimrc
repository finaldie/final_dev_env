Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': 'bash install.sh',
  \ }

"" https://github.com/autozimu/LanguageClient-neovim

let g:LanguageClient_autoStart = 1

""" Links
"" For clangd integration: https://github.com/autozimu/LanguageClient-neovim/wiki/Clangd
"" For cquery integration: https://github.com/autozimu/LanguageClient-neovim/wiki/cquery

function SetLSPShortcuts()
  "" Client side common shortcuts
  nnoremap <leader><leader>ld :call LanguageClient#textDocument_definition({'gotoCmd': 'split'})<CR>
  nnoremap <leader><leader>lr :call LanguageClient#textDocument_rename()<CR>
  nnoremap <leader><leader>lf :call LanguageClient#textDocument_formatting()<CR>
  nnoremap <leader><leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
  nnoremap <leader><leader>lx :call LanguageClient#textDocument_references()<CR>
  nnoremap <leader><leader>la :call LanguageClient_workspace_applyEdit()<CR>
  nnoremap <leader><leader>lw :call LanguageClient#workspace_symbol()<CR>
  nnoremap <leader><leader>lc :call LanguageClient#textDocument_completion()<CR>
  nnoremap <leader><leader>lh :call LanguageClient#textDocument_hover()<CR>
  nnoremap <leader><leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
  nnoremap <leader><leader>lm :call LanguageClient_contextMenu()<CR>

  "" ccls special shortcuts
  "" link: https://github.com/MaskRay/ccls/wiki/LanguageClient-neovim
  if executable('ccls')
      " bases
      nn <silent> xb :call LanguageClient#findLocations({'method':'$ccls/inheritance'})<cr>
      " bases of up to 3 levels
      nn <silent> xB :call LanguageClient#findLocations({'method':'$ccls/inheritance','levels':3})<cr>
      " derived
      nn <silent> xd :call LanguageClient#findLocations({'method':'$ccls/inheritance','derived':v:true})<cr>
      " derived of up to 3 levels
      nn <silent> xD :call LanguageClient#findLocations({'method':'$ccls/inheritance','derived':v:true,'levels':3})<cr>

      " caller
      nn <silent> xc :call LanguageClient#findLocations({'method':'$ccls/call'})<cr>
      " callee
      nn <silent> xC :call LanguageClient#findLocations({'method':'$ccls/call','callee':v:true})<cr>

      " $ccls/member
      " nested classes / types in a namespace
      nn <silent> xs :call LanguageClient#findLocations({'method':'$ccls/member','kind':2})<cr>
      " member functions / functions in a namespace
      nn <silent> xf :call LanguageClient#findLocations({'method':'$ccls/member','kind':3})<cr>
      " member variables / variables in a namespace
      nn <silent> xm :call LanguageClient#findLocations({'method':'$ccls/member'})<cr>

      nn xx x
  endif

  "" cquery special shortcuts
  if executable('cquery')

  endif
endfunction()

augroup LanguageClient_config
  autocmd!
  autocmd FileType * call SetLSPShortcuts()
augroup END

"" ----------------------------------------------------------------------------
"""
"" Backends
""  - Clangd: Easy to setup but leak some features like cross-reference
""  - Python: palantir/python-language-server. Current problem is, it's not
""            that fast, disable it for now since the lint part is handled by
""            ALE. In next, consider to create a ls-settings.json to disable
""            those lint functionality from pyls
""  - cquery: Powerful c/c++ lsp backend for large project, but sometimes
""            crashes
""  - ccls: A fork of cquery with std=c++17 support, less code, less crash

" For Python server pyls
"  \ 'python': ['pyls'],
"
" For C/C++ server clangd
"  \ 'c': ['clangd'],
"  \ 'cpp': ['clangd'],
"
" For C/C++ server cquery
"  \ 'c': ['/usr/local/bin/cquery',
"  \   '--log-file=/tmp/cq.log',
"  \   '--init={"cacheDirectory":"/var/cquery/"}'],
"  \ 'cpp': ['/usr/local/bin/cquery',
"  \   '--log-file=/tmp/cq.log',
"  \   '--init={"cacheDirectory":"/var/cquery/"}'],
"
" For C/C++ server ccls
"  \ 'c': ['/usr/local/bin/ccls', '--log-file=/tmp/cc.log'],
"  \ 'cpp': ['/usr/local/bin/ccls', '--log-file=/tmp/cc.log'],
"
" For Bash server
"  \ 'sh': ['bash-language-server', 'start']

let g:LanguageClient_serverCommands = {
  \ }

"let g:LanguageClient_loadSettings = 1
"let g:LanguageClient_settingsPath = 'ls-settings.json'
