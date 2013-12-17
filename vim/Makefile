include $(topdir)/common/Makefile.common

vimrc := vimrc
vimplugins := vim
vim_bashrc := vim.bashrc
extra := $(vimplugins)/vimrcs
clang_dir := clang_complete

all:
	test -d $(topdir)/$(USER_ENV)/$(vimplugins) || mkdir $(topdir)/$(USER_ENV)/$(vimplugins)
	test -d $(topdir)/$(USER_ENV)/$(vimplugins)/$(clang_dir) || mkdir $(topdir)/$(USER_ENV)/$(vimplugins)/$(clang_dir)
	cp $(vim_bashrc) $(topdir)/$(USER_ENV)/$(BASH_OUT)
	cp $(vimrc) $(topdir)/$(USER_ENV)
	cp $(extra)/*.vimrc $(topdir)/$(USER_ENV)/$(vimplugins)

clean:
	cd $(topdir)/$(USER_ENV) && rm -rf $(topdir)/$(USER_ENV)/$(vimplugins) $(vimrc) $(BASH_OUT)/$(vim_bashrc)

notes:
	@echo ""
	@echo "=======================VIM NOTE=========================="
	@echo "please open vim, and run :BundInstall to complete the plugin's installation"
	@echo "If you don't work on Mac OS platform, please change g:clang_library_path if needed"

.PHONY: all clean notes clang
