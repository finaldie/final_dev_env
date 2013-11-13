include $(topdir)/common/Makefile.common

git_folder := git

bashrcs := git.bashrc
git_config := config
xdg_bashrc := export_xdg_home.bashrc
rmfiles := git.bashrc $(git_folder) $(xdg_bashrc)

user_git_cfg := $(HOME)/.gitconfig
user_git_cfg_bak := $(topdir)/$(BACKUP)/gitconfig
user_git_cfg_exist := $(shell test -f $(user_git_cfg) && echo $$?)
user_git_cfg_bak_exist := $(shell test -f $(user_git_cfg_bak) && echo $$?)


all: copy_files expose_xdg4bash

backup:
ifeq ($(user_git_cfg_exist), 0)
	cp $(user_git_cfg) $(user_git_cfg_bak);
else
	echo "no need to backup $(git_config)";
endif

copy_files:
	test -d $(topdir)/$(USER_ENV)/$(git_folder) || mkdir $(topdir)/$(USER_ENV)/$(git_folder)
	cp $(bashrcs) $(topdir)/$(USER_ENV)
	cp $(git_config) $(user_git_cfg)

# for latest version
expose_xdg4bash:
	echo "export XDG_CONFIG_HOME=$(XDG_HOME)" > $(xdg_bashrc)
	mv $(xdg_bashrc) $(topdir)/$(USER_ENV)

revert:
ifeq ($(user_git_cfg_bak_exist), 0)
	cp $(user_git_cfg_bak) $(user_git_cfg)
endif

clean:
	cd $(topdir)/$(USER_ENV) && rm -rf $(rmfiles)

.PHONY: all clean copy_files backup export_xdg_home revert
