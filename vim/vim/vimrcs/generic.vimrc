" Status bar related information
set showcmd
set showmatch
set showmode
set ruler

" Content search options
set hlsearch
set incsearch
set ignorecase
set smartcase

set nu
set relativenumber

set backspace=indent,eol,start
set t_Co=256
set laststatus=2
set encoding=utf-8

" Disable text mode for 'INSERT|NORMAL|...' since status bar plugin has
" handled it
set noshowmode

" Force using old regex engine to avoid performance issue
" re=0 is better than re=1 in some cases
set re=0

"set statusline=%<%f\ %h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %-14.(%l,%c%V%)\ %P
"set listchars=tab:>-

" load tags
set tags+=./.tags;,.tags;./tags;,tags;

set foldcolumn=2
set foldmethod=marker

" Command Autocompletion
set wildmenu
set wildmode=longest,list,full

set hidden
set nobackup
set nowritebackup

"set cmdheight=2
set updatetime=100

" By default timeoutlen is 1000 ms
set timeoutlen=300

" Remap leader keys
let g:mapleader = "\<Space>"
let g:maplocalleader = '\'

set shortmess+=c
set signcolumn=yes

set lazyredraw
set redrawtime=10000

" tab produces a 2-space indentation
set softtabstop=2
set shiftwidth=2
set tabstop=2
set expandtab

" Highlight current line
hi CursorLine cterm=NONE ctermbg=darkgray ctermfg=white guibg=gray guifg=white
hi CursorColumn cterm=NONE ctermbg=darkgray ctermfg=white guibg=darkred guifg=white
set cursorline

" toggle highlight current line and column
"nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>

"set mouse=a

" Highlight trailing whitespace and lines longer than 80 columns.
" highlight LongLine ctermbg=DarkYellow guibg=DarkYellow
" highlight WhitespaceEOL ctermbg=DarkYellow guibg=DarkYellow
" if v:version >= 702
"   " Lines longer than 80 columns.
"   au BufWinEnter * let w:m0=matchadd('LongLine', '\%>80v.\+', -1)
"
"   " Whitespace at the end of a line. This little dance suppresses
"   " whitespace that has just been typed.
"   au BufWinEnter * let w:m1=matchadd('WhitespaceEOL', '\s\+$', -1)
"   au InsertEnter * call matchdelete(w:m1)
"   au InsertEnter * let w:m2=matchadd('WhitespaceEOL', '\s\+\%#\@<!$', -1)
"   au InsertLeave * call matchdelete(w:m2)
"   au InsertLeave * let w:m1=matchadd('WhitespaceEOL', '\s\+$', -1)
"
"   " clear all match when leave buffer
"   autocmd BufWinLeave * call clearmatches()
" else
"   au BufRead,BufNewFile * syntax match LongLine /\%>80v.\+/
"   au InsertEnter * syntax match WhitespaceEOL /\s\+\%#\@<!$/
"   au InsertLeave * syntax match WhitespaceEOL /\s\+$/
" endif

if exists('+colorcolumn')
    set colorcolumn=80
endif

if (has("termguicolors"))
  set termguicolors
endif

"set columns=100
"set textwidth=80
set nolinebreak
set showbreak=…

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

" Enable filetype detection
filetype on

" Optional
" C/C++ programming helpers
augroup csrc
  au!
  "autocmd FileType *      set nocindent smartindent
  autocmd FileType *      set nocindent
  autocmd FileType c,cpp  set cindent
augroup END

" display of space error for C programming language
let c_space_errors = 1

" Set a few indentation parameters. See the VIM help for cinoptions-values for
" details.  These aren't absolute rules; they're just an approximation of
" common style in LLVM source.
set cinoptions=:0,g0,(0,Ws,l1
" Add and delete spaces in increments of `shiftwidth' for tabs
set smarttab

" Highlight syntax in programming languages
syntax on
syntax enable
set synmaxcol=120

" LLVM Makefiles can have names such as Makefile.rules or TEST.nightly.Makefile,
" so it's important to categorize them as such.
augroup filetype
  au! BufRead,BufNewFile *Makefile* set filetype=make
  au! BufRead,BufNewFile *.mk       set filetype=make
augroup END

" In Makefiles, don't expand tabs to spaces, since we need the actual tabs
autocmd FileType make set noexpandtab

" Useful macros for cleaning up code to conform to LLVM coding guidelines

" Delete trailing whitespace and tabs at the end of each line
command! DeleteTrailingWs :%s/\s\+$//

" Convert all tab characters to 2 spaces
command! TabExpand :%s/\t/  /g

" Enable syntax highlighting for LLVM files. To use, copy
" utils/vim/llvm.vim to ~/.vim/syntax .
augroup filetype
  au! BufRead,BufNewFile *.ll     set filetype=llvm
augroup END

" Enable syntax highlighting for tablegen files. To use, copy
" utils/vim/tablegen.vim to ~/.vim/syntax .
augroup filetype
  au! BufRead,BufNewFile *.td     set filetype=tablegen
augroup END

" Enable syntax highlighting for reStructuredText files. To use, copy
" rest.vim (http://www.vim.org/scripts/script.php?script_id=973)
" to ~/.vim/syntax .
augroup filetype
  au! BufRead,BufNewFile *.rst     set filetype=rest
augroup END

" Auto save/reload fold view when close and open a file
"au BufWinLeave ?* silent! mkview
"au BufWinEnter ?* silent! loadview
