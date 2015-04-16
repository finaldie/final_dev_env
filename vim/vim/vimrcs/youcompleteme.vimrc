
Plugin 'Valloric/YouCompleteMe'

" global/fallback ycm_extra_conf
let g:ycm_global_ycm_extra_conf = $FENV_HOME.'/vim/ycm_extra_conf.py'

" shutdown the confirmation every time you open a file
let g:ycm_confirm_extra_conf = 0

" jump to definition
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>

" compile code immediately
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>

" load identifiers from tags
" let g:ycm_collect_identifiers_from_tags_files = 1

" When you encounter crash or some strange bugs, turn on the 2 settings
" let g:ycm_server_use_vim_stdout = 1
" let g:ycm_server_log_level = 'debug'

" If you want to change the python interpreter, change the value below
" let g:ycm_path_to_python_interpreter = '/usr/bin/python'

" For enable autocomplete for Java
let g:EclimCompletionMethod = 'omnifunc'
