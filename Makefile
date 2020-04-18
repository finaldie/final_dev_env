include common/Makefile.common

topdir := $(shell pwd)

DOCKER_NAME := finaldie/dev

all: prepare install bash zsh notes

prepare:
	@test -d $(USER_ENV) || mkdir $(USER_ENV);

install:
	@for module in $(MODULES); \
	do \
		echo "[$$module] Installing..."; \
		$(MAKE) -s -C $$module topdir=$(topdir); \
	done;

bash:
	@cd bash && make topdir=$(topdir)

zsh:
	@cd zsh && make topdir=$(topdir)

notes:
	@echo "=========================================================";
	@echo "*   Install Complete, Please Read The Following Notes   *";
	@echo "=========================================================";
	@echo "";
	@cd bash && make topdir=$(topdir) notes --no-print-directory
	@cd zsh && make topdir=$(topdir) notes --no-print-directory
	@for module in $(MODULES); \
	do \
		$(MAKE) -s -C $$module topdir=$(topdir) notes; \
	done;
	@echo ""
	@echo "========================LAST NOTE========================";
	@echo "Install commands tools to make the life eaiser"
	@echo "Recommend tools: fzf, plantuml"
	@echo ""
	@echo "Have fun :)"
	@echo ""

dist-update:
	@cd vim/vim/vim-plug && git checkout master && git pull
	@cd zsh/theme/powerlevel10k && git checkout master && git pull

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

