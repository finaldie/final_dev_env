include $(topdir)/common/Makefile.common

files := common.zsh linux.zsh
env_homerc := env_home.zsh

rootzsh := zshrc

p10k_zsh := p10k.zsh # powerlevel10k theme config
p10k_zsh_theme := p10k.zsh-theme

all: prepare export_env_home copy_files generate
	
prepare:
	mkdir -p $(topdir)/$(USER_ENV)/$(ZSH_OUT)/rcs;
	mkdir -p $(topdir)/$(USER_ENV)/$(ZSH_OUT)/theme;

export_env_home:
	echo "export FENV_HOME=$(topdir)/$(USER_ENV)" > $(env_homerc)
	echo "export FENV_GIT=$(topdir)" >> $(env_homerc)
	mv $(env_homerc) $(topdir)/$(USER_ENV)/$(ZSH_OUT)/rcs

copy_files:
	cp $(files) $(topdir)/$(USER_ENV)/$(ZSH_OUT)/rcs;
	cp $(rootzsh) $(topdir)/$(USER_ENV)/$(ZSH_OUT);
	cp $(p10k_zsh) $(topdir)/$(USER_ENV)/$(ZSH_OUT)/theme;

generate:
	@cd $(topdir)/$(USER_ENV)/$(ZSH_OUT) && echo "" > all.$(ZSH_SUFFIX) && \
	    for zshrc_file in `ls rcs | grep .$(ZSH_SUFFIX)`; do \
		echo "source $(topdir)/$(USER_ENV)/$(ZSH_OUT)/rcs/$$zshrc_file" >> all.$(ZSH_SUFFIX); \
	    done;
	test -f ~/.fenv.zsh || ln -s $(topdir)/$(USER_ENV)/$(ZSH_OUT)/all.$(ZSH_SUFFIX) ~/.fenv.zsh
	test -f ~/.$(rootzsh) || ln -s $(topdir)/$(USER_ENV)/$(ZSH_OUT)/$(rootzsh) ~/.$(rootzsh)
	test -f ~/.$(p10k_zsh) || ln -s $(topdir)/$(USER_ENV)/$(ZSH_OUT)/theme/$(p10k_zsh) ~/.$(p10k_zsh)
	test -f ~/.$(p10k_zsh_theme) || ln -s $(topdir)/zsh/theme/powerlevel10k/powerlevel10k.zsh-theme ~/.$(p10k_zsh_theme)

clean:
	cd $(topdir)/$(USER_ENV)/$(ZSH_OUT) && rm -rf $(files);

notes:
	@cd $(topdir)/$(USER_ENV) && echo "" > all.$(ZSH_SUFFIX) && \
	    for bashrc in `ls $(ZSH_OUT) | grep .$(ZSH_SUFFIX)`; do \
		echo "source $(topdir)/$(USER_ENV)/$(ZSH_OUT)/$$bashrc" >> all.$(ZSH_SUFFIX); \
	    done;
	@echo "========================ZSH NOTE========================";
	@echo "If you are using zsh as your default shell";
	@echo "1. Add the following into $(HOME)/.zshrc";
	@echo "2. Run zsh or re-login";
	@echo "=========================================================";
	@echo "[[ ! -f $(topdir)/$(USER_ENV)/all.$(ZSH_SUFFIX) ]] || source $(topdir)/$(USER_ENV)/all.$(ZSH_SUFFIX)"
	@echo "";

.PHONY: all clean notes
