include common/Makefile.common

topdir := $(shell pwd)

DOCKER_NAME := finaldie/dev

all: prepare install bash zsh notes

prepare:
	@test -d $(USER_ENV) || mkdir $(USER_ENV);
	@cd zsh && make prepare topdir=$(topdir) --no-print-directory;
	@cd bash && make prepare topdir=$(topdir) --no-print-directory;

install:
	@for module in $(MODULES); \
	do \
		echo "[$$module] Installing..."; \
		$(MAKE) -s -C $$module topdir=$(topdir); \
	done;

bash:
	@echo "[bash] Installing...";
	@cd bash && make topdir=$(topdir) --no-print-directory

zsh:
	@echo "[zsh] Installing...";
	@cd zsh && make topdir=$(topdir) --no-print-directory

notes:
	@echo ""
	@echo "* =========================================================== *";
	@echo "*    Install Complete, Please Read The Following Notes        *";
	@echo "* =========================================================== *";
	@echo "";
	@cd bash && make topdir=$(topdir) notes --no-print-directory
	@cd zsh && make topdir=$(topdir) notes --no-print-directory
	@for module in $(MODULES); \
	do \
		$(MAKE) -s -C $$module topdir=$(topdir) notes; \
	done;
	@echo "* =========================================================== *";
	@echo "*                          LAST NOTE                          *";
	@echo "* =========================================================== *";
	@echo "1 | Install commands tools to make the life eaiser"
	@echo "2 | Recommended tools: fzf, plantuml"
	@echo ""
	@echo "Have fun :)"
	@echo ""

dist-update:
	@echo "[dist upgrading]..."; \
	@cd vim/vim/vim-plug && git checkout master && git pull
	@cd zsh/theme/powerlevel10k && git checkout master && git pull
	@cd zsh/plugin/zsh-syntax-highlighting && git checkout master && git pull
	@cd zsh/plugin/zsh-autosuggestions && git checkout master && git pull
	@cd tools/fzf && git checkout master && git pull

clang-prebuilt:
	$(MAKE) -C docker clang7

plantuml:
	$(MAKE) -C docker plantuml

docker_deps:
	$(MAKE) -C docker docker-deps

docker: clang-prebuilt plantuml
	@docker build --rm -t $(DOCKER_NAME) -f ./docker/Dockerfile .

clean:
	@for module in $(MODULES); \
	do \
		echo "[$$module] Clean..."; \
		$(MAKE) -s -C $$module topdir=$(topdir) clean; \
	done;
	@rm -rf $(USER_ENV)

.PHONY: all clean install bash zsh docker

