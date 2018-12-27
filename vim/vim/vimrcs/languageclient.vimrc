Plugin 'autozimu/LanguageClient-neovim'

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
  autocmd FileType cpp,c,py call SetLSPShortcuts()
augroup END

"""
"" Backends
""  - Clang6: Cannot customize 'include' path which causes a lot of undefined
""            errors. TODO: Re-evaluate newer version later
""  - Python: palantir/python-language-server

let g:LanguageClient_serverCommands = {
"  \ 'c': ['clangd-6.0'],
"  \ 'cpp': ['clangd-6.0'],
  \ 'python': ['pyls'],
  \ }

