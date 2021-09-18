include $(topdir)/common/Makefile.common

FOLDER := tmux
TMUX_CONF := ./tmux.conf
DEFAULT_USER_CONF := ~/.tmux.conf

TARGET_CONF := $(topdir)/$(USER_ENV)/$(FOLDER)/$(TMUX_CONF)

SSH_FOLDER := ~/.ssh
SSHRC := sshrc
USER_SSHRC := $(SSH_FOLDER)/rc

TARGET_SSHRC := $(topdir)/$(USER_ENV)/$(FOLDER)/$(SSHRC)
TARGET_TMUX_ATTACH := $(topdir)/$(USER_ENV)/$(FOLDER)/tmux_attach.sh
TARGET_REMOTE_HOSTNAME := $(topdir)/$(USER_ENV)/$(FOLDER)/remote_hostname.sh
TARGET_NW_TTL := $(topdir)/$(USER_ENV)/$(FOLDER)/nw_ttl.sh

all: prepare copy_files completion

prepare:
	@mkdir -p ~/.$(FOLDER)
	@mkdir -p $(SSH_FOLDER)

copy_files:
	@test -d $(topdir)/$(USER_ENV)/$(FOLDER) || mkdir -p $(topdir)/$(USER_ENV)/$(FOLDER)
	@cp $(TMUX_CONF) $(topdir)/$(USER_ENV)/$(FOLDER)
	@cp $(SSHRC) $(TARGET_SSHRC)
	@test -f $(DEFAULT_USER_CONF) || ln -s $(TARGET_CONF) $(DEFAULT_USER_CONF)
	@test -e $(USER_SSHRC) || ln -s $(TARGET_SSHRC) $(USER_SSHRC)
	@cp tmux_attach.sh $(topdir)/$(USER_ENV)/$(FOLDER)
	@test -e ~/.bash/tmux_attach.sh || ln -s $(TARGET_TMUX_ATTACH) ~/.bash/tmux_attach.sh
	@test -e ~/.zsh/tmux_attach.sh || ln -s $(TARGET_TMUX_ATTACH) ~/.zsh/tmux_attach.sh
	@cp remote_hostname.sh $(topdir)/$(USER_ENV)/$(FOLDER)
	@cp nw_ttl.sh $(topdir)/$(USER_ENV)/$(FOLDER)
	@test -e ~/.tmux/remote_hostname.sh || ln -s $(TARGET_REMOTE_HOSTNAME) ~/.tmux/remote_hostname.sh
	@test -e ~/.tmux/nw_ttl.sh || ln -s $(TARGET_NW_TTL) ~/.tmux/nw_ttl.sh

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
