include $(topdir)/common/Makefile.common

vimrc := vimrc
vimrc_new := vimrc_new
vimplugins := vim
vim_bashrc := vim.bashrc
vim_zsh := vim.zsh
extra := $(vimplugins)/vimrcs
ycm_conf := $(vimplugins)/config/ycm_extra_conf.py
clang_format_tpl := $(vimplugins)/config/clang-format.tpl
tools := tools
vim_plug := vim-plug/plug.vim

USER_VIM := ~/.vim
INIT_VIM := $(USER_VIM)/init.vim

all:
	test -d $(topdir)/$(USER_ENV)/$(vimplugins) || mkdir $(topdir)/$(USER_ENV)/$(vimplugins)
	test -d $(topdir)/$(USER_ENV)/$(vimplugins)/autoload || mkdir $(topdir)/$(USER_ENV)/$(vimplugins)/autoload
	test -d $(topdir)/$(USER_ENV)/$(vimplugins)/share || mkdir $(topdir)/$(USER_ENV)/$(vimplugins)/share
	test -d $(topdir)/$(USER_ENV)/$(vimplugins)/$(tools) || mkdir $(topdir)/$(USER_ENV)/$(vimplugins)/$(tools)
	cp $(vim_bashrc) $(topdir)/$(USER_ENV)/$(BASH_OUT)
	cp $(vim_zsh) $(topdir)/$(USER_ENV)/$(ZSH_OUT)/rcs
	cp $(vimrc_new) $(topdir)/$(USER_ENV)/vimrc
	cp $(extra)/*.vimrc $(topdir)/$(USER_ENV)/$(vimplugins)
	cp $(ycm_conf) $(topdir)/$(USER_ENV)/$(vimplugins)/share
	cp $(clang_format_tpl) $(topdir)/$(USER_ENV)/$(vimplugins)/share
	cp $(vimplugins)/$(tools)/* $(topdir)/$(USER_ENV)/$(vimplugins)/$(tools)
	cp $(vimplugins)/$(vim_plug) $(topdir)/$(USER_ENV)/$(vimplugins)/autoload
	mkdir -p $(USER_VIM) && touch $(INIT_VIM)
	test -e ~/.vimrc || ln -s $(topdir)/$(USER_ENV)/$(vimrc) ~/.vimrc

clean:
	cd $(topdir)/$(USER_ENV) && rm -rf $(topdir)/$(USER_ENV)/$(vimplugins) $(vimrc) $(BASH_OUT)/$(vim_bashrc)

notes:
	@echo "* ======================== VIM NOTE ========================= *"
	@echo "1 | 'vim +PlugInstall +qall' to install all the plugins"
	@echo "";

.PHONY: all clean notes clang
