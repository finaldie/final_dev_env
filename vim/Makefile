include $(topdir)/common/Makefile.common

vimrc := vimrc
vimplugins := vim
vim_bashrc := vim.bashrc

all:
	test -d $(topdir)/$(USER_ENV)/$(vimplugins) || mkdir $(topdir)/$(USER_ENV)/$(vimplugins)
	cp -R $(vimplugins) $(topdir)/$(USER_ENV)
	cp $(vim_bashrc) $(topdir)/$(USER_ENV)/$(BASH_OUT)
	cp $(vimrc) $(topdir)/$(USER_ENV)

clean:
	cd $(topdir)/$(USER_ENV) && rm -rf $(topdir)/$(USER_ENV)/$(vimplugins) $(vimrc) $(BASH_OUT)/$(vim_bashrc)

notes:

.PHONY: all clean notes
