Plug 'w0rp/ale'

"" ----------------- Message Window -------------------
" Write this in your vimrc file
"let g:ale_set_loclist = 0
"let g:ale_set_quickfix = 1

let g:ale_open_list = 1

" Set this if you want to.
" This can be useful if you are combining ALE with
" some other plugin which sets quickfix errors, etc.
"let g:ale_keep_list_window_open = 1

"let g:ale_list_vertical = 1

"" ----------------- Linters --------------------------
" Write this in your vimrc file
let g:ale_lint_on_text_changed = 'never'

" You can disable this option too
" if you don't want linters to run on opening a file
let g:ale_lint_on_enter = 0

let g:ale_lint_on_save = 1

let g:ale_completion_enabled = 0

" Only run linters named in ale_linters settings.
let g:ale_linters_explicit = 1

"let g:ale_c_parse_compile_commands = 1
let g:ale_c_parse_makefile = 1

" clangtidy linter checks (Comment out by using default clang-analyzer-*)
let g:ale_c_clangtidy_checks = [
\   'clang-analyzer-*',
\   'google-*',
\   'cppcoreguidelines-*',
\   'modernize-*',
\   'performance-*',
\   'portability-*',
\   'readability-*'
\]

let g:ale_cpp_clangtidy_checks = [
\   'clang-analyzer-*',
\   'google-*',
\   'cppcoreguidelines-*',
\   'modernize-*',
\   'performance-*',
\   'portability-*',
\   'readability-*'
\]

" E.g. 'python': ['flake8', 'pylint'],
" Notes: for filetype c and cpp, if 'parse_makefile' doesn't work well,
" needs to generate compile_commands.json and switch to
" 'parse_compile_commands' to try again
let g:ale_linters = {
\   'python': ['flake8', 'pylint'],
\   'c': ['clangtidy'],
\   'cpp': ['clangtidy'],
\}

"" ----------------- Disable warnings -----------------
" Disable warnings about trailing whitespace for Python files.
let b:ale_warn_about_trailing_whitespace = 0

"" ----------------- Fixers ---------------------------
" Set this variable to 1 to fix files when you save them.
let g:ale_fix_on_save = 0

" short-cut to manual trigger the fixers
nmap <F8> <Plug>(ale_fix)

" Examples
"let g:ale_fixers = {
"\   '*': ['remove_trailing_lines', 'trim_whitespace'],
"\   'javascript': ['eslint'],
"\}
"
"let g:ale_fixers = {
"\   'python': ['autopep8', 'yapf'],
"\   'c': ['clang-format'],
"\   'cpp': ['clang-format'],
"\}

" Fixers. Notes: For a single language, the item order should be: fixer first
" then formatter
let g:ale_fixers = {
\   'python': ['yapf'],
\   'c': ['clang-format'],
\   'cpp': ['clang-format'],
\}

"" References
" Python linters: https://github.com/vintasoftware/python-linters-and-code-analysis
