include $(topdir)/common/Makefile.common

vimrc := vimrc
vimplugins := vim
vim_bashrc := vim.bashrc
extra := $(vimplugins)/vimrcs
ycm_conf := $(vimplugins)/config/ycm_extra_conf.py
clang_format_tpl := $(vimplugins)/config/clang-format.tpl

all:
	test -d $(topdir)/$(USER_ENV)/$(vimplugins) || mkdir $(topdir)/$(USER_ENV)/$(vimplugins)
	cp $(vim_bashrc) $(topdir)/$(USER_ENV)/$(BASH_OUT)
	cp $(vimrc) $(topdir)/$(USER_ENV)
	cp $(extra)/*.vimrc $(topdir)/$(USER_ENV)/$(vimplugins)
	cp $(ycm_conf) $(topdir)/$(USER_ENV)/$(vimplugins)
	cp $(clang_format_tpl) $(topdir)/$(USER_ENV)/$(vimplugins)

clean:
	cd $(topdir)/$(USER_ENV) && rm -rf $(topdir)/$(USER_ENV)/$(vimplugins) $(vimrc) $(BASH_OUT)/$(vim_bashrc)

notes:
	@echo ""
	@echo "=======================VIM NOTE=========================="
	@echo "please open vim, and run :BundInstall to complete the plugin's installation"
	@echo "after that, run cd $(topdir)/$(USER_ENV)/vim/YouCompleteMe && ./install.sh --clang-completer"

.PHONY: all clean notes clang
