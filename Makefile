include common/Makefile.common

topdir := $(shell pwd)
xdg_home := $(topdir)/$(USER_ENV)

DOCKER_NAME := finaldie/dev

all: prepare install bash zsh notes

prepare:
	@test -d $(USER_ENV) || mkdir $(USER_ENV);
	@test -d $(USER_ENV)/$(BASH_OUT) || mkdir $(USER_ENV)/$(BASH_OUT);

install:
	@for module in $(MODULES); \
	do \
		echo "[$$module] Installing..."; \
		$(MAKE) -s -C $$module topdir=$(topdir) XDG_HOME=$(xdg_home); \
	done;

bash:
	@cd $(topdir)/$(USER_ENV) && echo "" > all.$(BASH_SUFFIX) && \
	    for bashrc in `ls $(BASH_OUT) | grep .$(BASH_SUFFIX)`; do \
		echo "source $(topdir)/$(USER_ENV)/$(BASH_OUT)/$$bashrc" >> all.$(BASH_SUFFIX); \
	    done;
	@echo "=========================================================";
	@echo "*   Install Complete, Please Read the Following Notes   *";
	@echo "=========================================================";
	@echo "";
	@echo "========================BASH NOTE========================";
	@echo "If you are using bash as your default shell";
	@echo "1. Add the following into $(HOME)/.bash_profile";
	@echo "2. Run bash or re-login";
	@echo "=========================================================";
	@echo "if [ -f $(topdir)/$(USER_ENV)/all.$(BASH_SUFFIX) ]; then";
	@echo "    . $(topdir)/$(USER_ENV)/all.$(BASH_SUFFIX)";
	@echo "fi";
	@echo "";

zsh:

notes:
	@for module in $(MODULES); \
	do \
		$(MAKE) -s -C $$module topdir=$(topdir) XDG_HOME=$(xdg_home) notes; \
	done;

docker:
	@docker build --rm -t $(DOCKER_NAME) -f ./docker/Dockerfile .

clean:
	@for module in $(MODULES); \
	do \
		echo "[$$module] Clean..."; \
		$(MAKE) -s -C $$module topdir=$(topdir) XDG_HOME=$(xdg_home) clean; \
	done;
	@rm -rf $(USER_ENV)

.PHONY: all clean install bash zsh docker

