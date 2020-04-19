include $(topdir)/common/Makefile.common

files := common.bashrc tags.bashrc linux.bashrc maven.bashrc
env_homerc := env_home.bashrc

localbash := ~/.bash
rootbash := bashrc

all: prepare export_env_home copy_files fzf generate

prepare:
	@test -d $(topdir)/$(USER_ENV)/$(BASH_OUT) || mkdir -p $(topdir)/$(USER_ENV)/$(BASH_OUT);
	@mkdir -p $(localbash);

export_env_home:
	echo "export FENV_HOME=$(topdir)/$(USER_ENV)" > $(env_homerc)
	echo "export FENV_GIT=$(topdir)" >> $(env_homerc)
	mv $(env_homerc) $(topdir)/$(USER_ENV)/$(BASH_OUT)

copy_files:
	cp $(files) $(topdir)/$(USER_ENV)/$(BASH_OUT);
	cp $(rootbash) $(topdir)/$(USER_ENV)

fzf:
	test -e $(localbash)/fzf-key-bindings.bash || ln -s $(topdir)/tools/fzf/shell/key-bindings.bash $(localbash)/fzf-key-bindings.bash
	test -e $(localbash)/fzf-completion.bash || ln -s $(topdir)/tools/fzf/shell/completion.bash $(localbash)/fzf-completion.bash

generate:
	@cd $(topdir)/$(USER_ENV) && echo "" > all.$(BASH_SUFFIX) && \
	    for bashrc in `ls $(BASH_OUT) | grep .$(BASH_SUFFIX)`; do \
		echo "source $(topdir)/$(USER_ENV)/$(BASH_OUT)/$$bashrc" >> all.$(BASH_SUFFIX); \
	    done;
	test -e $(localbash)/fenv.bash || ln -s $(topdir)/$(USER_ENV)/all.$(BASH_SUFFIX) $(localbash)/fenv.bash;
	test -e ~/.$(rootbash) || ln -s $(topdir)/$(USER_ENV)/$(rootbash) ~/.$(rootbash);

clean:
	cd $(topdir)/$(USER_ENV)/$(BASH_OUT) && rm -rf $(files) $(env_homerc);

notes:
	@echo "========================BASH NOTE========================";
	@echo "If you are using bash as your default shell";
	@echo "1. Add the following into $(HOME)/.bashrc if doesn't exist";
	@echo "2. Run bash or re-login";
	@echo "=========================================================";
	@echo "if [ -f $(topdir)/$(USER_ENV)/all.$(BASH_SUFFIX) ]; then";
	@echo "    . $(topdir)/$(USER_ENV)/all.$(BASH_SUFFIX)";
	@echo "fi";
	@echo "";

.PHONY: all clean export_env_home copy_files fzf generate
