
Plug 'ycm-core/YouCompleteMe'

" global/fallback ycm_extra_conf
let g:ycm_global_ycm_extra_conf = $FENV_HOME.'/vim/share/ycm_extra_conf.py'

" shutdown the confirmation every time you open a file
let g:ycm_confirm_extra_conf = 0

" Short-cuts
function SetYCMShortcuts()
  " jump to definition
  nnoremap <leader>jd  :YcmCompleter GoToDefinitionElseDeclaration<CR>
  nnoremap <leader>gt  :YcmCompleter GoTo<CR>
  nnoremap <leader>gtt :YcmCompleter GoToImprecise<CR>
  nnoremap <leader>gr  :YcmCompleter GoToReferences<CR>
  nnoremap <leader>h   :YcmCompleter GetType<CR>
  nnoremap <leader>hh  :YcmCompleter GetTypeImprecise<CR>
  nnoremap <leader>gp  :YcmCompleter GetParent<CR>
  nnoremap <leader>gd  :YcmCompleter GetDoc<CR>
  nnoremap <leader>gdd :YcmCompleter GetDocImprecise<CR>

  nnoremap <leader>fi  :YcmCompleter FixIt<CR>
  nnoremap <leader>rn  :YcmCompleter RefactorRename<CR>
  nnoremap <leader>fm  :YcmCompleter Format<CR>
  nnoremap <leader>oi  :YcmCompleter OrganizeImports<CR>

  " compile code immediately
  nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
endfunction()

augroup YCM_config
  autocmd!
  autocmd FileType * call SetYCMShortcuts()
augroup END

" load identifiers from tags
" let g:ycm_collect_identifiers_from_tags_files = 1

" When you encounter crash or some strange bugs, turn on the 2 settings
" let g:ycm_server_use_vim_stdout = 1
" let g:ycm_server_log_level = 'debug'

" If you want to change the python interpreter, change the value below
" let g:ycm_path_to_python_interpreter = '/usr/bin/python3'

" Disable Eclim to prevent any potential conflict
let g:EclimFileTypeValidate = 0
" let g:EclimCompletionMethod = 'omnifunc'

" Prevent conflict with syntastic plugin
let g:syntastic_java_checkers = []

" To disable using 'tab' to select items, since 'tab' is mainly for other
" purpose, like snippets
let g:ycm_key_list_select_completion = []
