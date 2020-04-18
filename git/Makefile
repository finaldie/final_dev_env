include $(topdir)/common/Makefile.common

git_folder := git

bashrcs := git.bashrc
zshrcs := git.zsh
git_config := config

GIT_CONF := $(topdir)/$(USER_ENV)/$(git_folder)/$(git_config)
DEFAULT_USER_CONF := ~/.gitconfig

all: copy_files

copy_files:
	test -d $(topdir)/$(USER_ENV)/$(git_folder) || mkdir $(topdir)/$(USER_ENV)/$(git_folder)
	cp $(bashrcs) $(topdir)/$(USER_ENV)/$(BASH_OUT)
	cp $(zshrcs) $(topdir)/$(USER_ENV)/$(ZSH_OUT)/rcs
	cp $(git_config) $(topdir)/$(USER_ENV)/$(git_folder)
	test -f ~/.gitconfig || ln -s $(GIT_CONF) $(DEFAULT_USER_CONF)

clean:
	cd $(topdir)/$(USER_ENV) && rm -rf $(git_folder)
	cd $(topdir)/$(USER_ENV)/$(BASH_OUT) && rm -f $(bashrcs)

notes:
	echo "=======================GIT NOTE==========================";
	echo "If your git DOES NOT support to use XDG_CONFIG_HOME env variable";
	echo "you need to copy $(topdir)/$(USER_ENV)/$(git_folder)/$(git_config) to $(HOME)/.gitconfig";
	echo "or create a link point to $(topdir)/$(USER_ENV)/$(git_folder)/$(git_config)";
	echo "";

.PHONY: all clean copy_files notes
