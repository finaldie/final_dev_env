include $(topdir)/common/Makefile.common

files := common.zsh linux.zsh
env_homerc := env_home.zsh

rootzsh := zshrc
localzsh := ~/.zsh

p10k_zsh := p10k.zsh # powerlevel10k theme config
p10k_zsh_theme := p10k.zsh-theme

plugin_syntax_highlight := zsh-syntax-highlighting.zsh
plugin_autosuggestions  := zsh-autosuggestions.zsh

all: prepare export_env_home copy_files plugin theme fzf generate
	
prepare:
	mkdir -p $(localzsh);
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

plugin:
	test -f $(localzsh)/$(plugin_syntax_highlight) || ln -s $(topdir)/zsh/plugin/zsh-syntax-highlighting/$(plugin_syntax_highlight) $(localzsh)/$(plugin_syntax_highlight)
	test -f $(localzsh)/$(plugin_autosuggestions) || ln -s $(topdir)/zsh/plugin/zsh-autosuggestions/$(plugin_autosuggestions) $(localzsh)/$(plugin_autosuggestions)

theme:
	test -f $(localzsh)/$(p10k_zsh) || ln -s $(topdir)/$(USER_ENV)/$(ZSH_OUT)/theme/$(p10k_zsh) $(localzsh)/$(p10k_zsh)
	test -f $(localzsh)/$(p10k_zsh_theme) || ln -s $(topdir)/zsh/theme/powerlevel10k/powerlevel10k.zsh-theme $(localzsh)/$(p10k_zsh_theme)

fzf:
	test -f $(localzsh)/fzf-key-bindings.zsh || ln -s $(topdir)/tools/fzf/shell/key-bindings.zsh $(localzsh)/fzf-key-bindings.zsh
	test -f $(localzsh)/fzf-completion.zsh || ln -s $(topdir)/tools/fzf/shell/completion.zsh $(localzsh)/fzf-completion.zsh

generate:
	@cd $(topdir)/$(USER_ENV)/$(ZSH_OUT) && echo "" > all.$(ZSH_SUFFIX) && \
	    for zshrc_file in `ls rcs | grep .$(ZSH_SUFFIX)`; do \
		echo "source $(topdir)/$(USER_ENV)/$(ZSH_OUT)/rcs/$$zshrc_file" >> all.$(ZSH_SUFFIX); \
	    done;
	test -f $(localzsh)/fenv.zsh || ln -s $(topdir)/$(USER_ENV)/$(ZSH_OUT)/all.$(ZSH_SUFFIX) $(localzsh)/fenv.zsh
	test -f ~/.$(rootzsh) || ln -s $(topdir)/$(USER_ENV)/$(ZSH_OUT)/$(rootzsh) ~/.$(rootzsh)

clean:
	cd $(topdir)/$(USER_ENV)/$(ZSH_OUT) && rm -rf $(files);

notes:
	@cd $(topdir)/$(USER_ENV) && echo "" > all.$(ZSH_SUFFIX) && \
	    for bashrc in `ls $(ZSH_OUT) | grep .$(ZSH_SUFFIX)`; do \
		echo "source $(topdir)/$(USER_ENV)/$(ZSH_OUT)/$$bashrc" >> all.$(ZSH_SUFFIX); \
	    done;
	@echo "========================ZSH NOTE========================";
	@echo "If you are using zsh as your default shell";
	@echo "1. Add the following into $(HOME)/.zshrc if doesn't have";
	@echo "2. Run zsh or re-login";
	@echo "3. [Optional] Consider to set default-shell to zsh: chsh -s $(`which zsh`) $USER";
	@echo "=========================================================";
	@echo "[[ ! -f ~/.fenv.zsh ]] || source ~/.fenv.zsh";
	@echo "";

.PHONY: all clean notes copy_files plugin theme fzf generate
