" Cscope settings
if has('cscope')
    "set cscopetag cscopeverbose
    "set csto=1
    set cscopetag

    "if has('quickfix')
    "    set cscopequickfix=s-,c-,d-,i-,t-,e-
    "endif

    cnoreabbrev csa cs add
    cnoreabbrev csf cs find
    cnoreabbrev csk cs kill
    cnoreabbrev csr cs reset
    cnoreabbrev css cs show
    cnoreabbrev csh cs help

    "command -nargs=0 Cscope cs add $VIMSRC/src/cscope.out $VIMSRC/src
    "if filereadable("cscope.out")
        "cs add cscope.out
        "cs add ~/.vim/tags/stl_cscope/cscope.out
        "cs add ~/.vim/tags/sys_cscope/cscope.out
        cs add .cscope.out
        cs add ../.cscope.out
        cs add ../../.cscope.out
        cs add ../../../.cscope.out
        cs add ../../../../.cscope.out
    "endif

    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
endif

function! LoadCscope()
    let db = findfile(".cscope.out", ".;")
    if (!empty(db))
        let path = strpart(db, 0, match(db, "/.cscope.out$"))
        set nocscopeverbose " suppress 'duplicate connection' error
        exe "cs add " . db . " " . path
    endif
endfunction

au BufEnter /* call LoadCscope()
