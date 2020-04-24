include $(topdir)/common/Makefile.common

FOLDER := tmux
TMUX_CONF := ./tmux.conf
DEFAULT_USER_CONF := ~/.tmux.conf

TARGET_CONF := $(topdir)/$(USER_ENV)/$(FOLDER)/$(TMUX_CONF)

all: prepare copy_files completion

prepare:
	@mkdir -p ~/.$(FOLDER)

copy_files:
	@test -d $(topdir)/$(USER_ENV)/$(FOLDER) || mkdir -p $(topdir)/$(USER_ENV)/$(FOLDER)
	@cp $(TMUX_CONF) $(topdir)/$(USER_ENV)/$(FOLDER)
	@test -f $(DEFAULT_USER_CONF) || ln -s $(TARGET_CONF) $(DEFAULT_USER_CONF)

completion:
	@test -e ~/.bash/tmuxinator.bash || ln -s $(topdir)/tools/tmuxinator/completion/tmuxinator.bash ~/.bash/tmuxinator.bash
	@test -e ~/.zsh/tmuxinator.zsh || ln -s $(topdir)/tools/tmuxinator/completion/tmuxinator.zsh ~/.zsh/tmuxinator.zsh

clean:
	@cd $(topdir)/$(USER_ENV) && rm -rf $(FOLDER)

notes:
	@echo "* ======================== TMUX NOTE ======================== *";
	@echo "1 | Customize ~/.tmux/user.conf to override settings";
	@echo "";

.PHONY: all prepare clean copy_files notes completion
