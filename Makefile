include common/Makefile.common

topdir := $(shell pwd)
xdg_home := $(topdir)/$(USER_ENV)

all: prepare install bash zsh

prepare:
	@test -d $(USER_ENV) || mkdir $(USER_ENV);
	@test -d $(BACKUP) || mkdir $(BACKUP);

install:
	@for module in $(MODULES); \
	do \
		echo "[$$module] Backing up old files..."; \
		$(MAKE) -s -C $$module topdir=$(topdir) XDG_HOME=$(xdg_home) backup; \
		echo "[$$module] Installing..."; \
		$(MAKE) -s -C $$module topdir=$(topdir) XDG_HOME=$(xdg_home); \
	done;

bash:
	@cd $(topdir)/$(USER_ENV) && cat *.$(BASH_SUFFIX) > all.$(BASH_SUFFIX);
	@echo "=========================================================";
	@echo "*   Install Complete, Please Read the Following Notes   *";
	@echo "=========================================================";
	@echo "";
	@echo "=========================================================";
	@echo "If you are using bash as your default shell";
	@echo "1. Add the following into $(HOME)/.bash_profile";
	@echo "2. Run bash or re-login";
	@echo "=========================================================";
	@echo "if [ -f $(topdir)/$(USER_ENV)/all.$(BASH_SUFFIX) ]; then";
	@echo "    . $(topdir)/$(USER_ENV)/all.$(BASH_SUFFIX)";
	@echo "fi";

zsh:

revert:
	@for module in $(MODULES); \
	do \
		echo "[$$module] Reverting...";
		$(MAKE) -s -C $$module topdir=$(topdir) XDG_HOME=$(xdg_home) revert; \
	done;

clean:
	@for module in $(MODULES); \
	do \
		echo "[$$module] Clean..."; \
		$(MAKE) -s -C $$module topdir=$(topdir) XDG_HOME=$(xdg_home) clean; \
	done;
	@rm -rf $(USER_ENV) $(BACKUP);

.PHONY: all clean install bash zsh revert
