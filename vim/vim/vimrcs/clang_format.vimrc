
" press CRTL + K, to format the code automaticly
" Notes: use ':py3f' to execute the python3 script. The ':pyf' will use
" python2 to execute it which lead errors if there is no python2 provider
" loaded. Run :checkHealth to confirmt the provider status.
map <C-K> :py3f /usr/local/share/clang/clang-format.py<CR>
imap <C-K> <ESC>:py3f /usr/local/share/clang/clang-format.py<CR>i

"" Format on save. This also can be done by configure it into linter fixer
"  section
"function! Formatonsave()
"  let l:formatdiff = 1
"  py3f /usr/local/share/clang/clang-format.py
"endfunction
"autocmd BufWritePre *.h,*.cc,*.cpp call Formatonsave()
