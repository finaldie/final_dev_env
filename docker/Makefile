
DOWNLOADS := downloads

CLANG7_VERSION  := 7.0.0
CLANG7_NAME     := clang+llvm-7.0.0-x86_64-linux-gnu-ubuntu-16.04
CLANG7_TAR      := $(CLANG7_NAME).tar.xz
CLANG7_URL      := http://releases.llvm.org/7.0.0/$(CLANG7_TAR)

CLANG7_DOWNLOAD := $(DOWNLOADS)/clang7-download
CLANG7_PREBUILT := clang7-prebuilt

clang7: clang7-install

clang7-download:
	if [ ! -d $(CLANG7_DOWNLOAD) ]; then \
	    mkdir -p $(CLANG7_DOWNLOAD) && \
	    cd $(CLANG7_DOWNLOAD) && \
	    wget $(CLANG7_URL) && \
	    tar -xf $(CLANG7_TAR); \
	fi

clang7-install: clang7-download
	if [ ! -d $(CLANG7_PREBUILT) ]; then \
	    mkdir -p $(CLANG7_PREBUILT)/bin \
	    && mkdir -p $(CLANG7_PREBUILT)/lib \
	    && mkdir -p $(CLANG7_PREBUILT)/share/clang \
	    && cp -R $(CLANG7_DOWNLOAD)/$(CLANG7_NAME)/bin/clang-7 $(CLANG7_PREBUILT)/bin \
	    && cp -R $(CLANG7_DOWNLOAD)/$(CLANG7_NAME)/bin/clangd $(CLANG7_PREBUILT)/bin \
	    && cp -R $(CLANG7_DOWNLOAD)/$(CLANG7_NAME)/bin/clang-tidy $(CLANG7_PREBUILT)/bin \
	    && cp -R $(CLANG7_DOWNLOAD)/$(CLANG7_NAME)/bin/clang-format $(CLANG7_PREBUILT)/bin \
	    && cp -R $(CLANG7_DOWNLOAD)/$(CLANG7_NAME)/bin/lld $(CLANG7_PREBUILT)/bin \
	    && cp -R $(CLANG7_DOWNLOAD)/$(CLANG7_NAME)/lib/clang $(CLANG7_PREBUILT)/lib/clang \
	    && cp -R $(CLANG7_DOWNLOAD)/$(CLANG7_NAME)/lib/libclang.so.7 $(CLANG7_PREBUILT)/lib \
	    && cp -R $(CLANG7_DOWNLOAD)/$(CLANG7_NAME)/lib/libomp.so $(CLANG7_PREBUILT)/lib \
	    && cp -R $(CLANG7_DOWNLOAD)/$(CLANG7_NAME)/share/clang/clang-format.py $(CLANG7_PREBUILT)/share/clang \
	    ; \
	fi

# plantuml

PLANTUML_VERSION := 1.2018.14
PLANTUML_NAME    := plantuml.$(PLANTUML_VERSION).jar
PLANTUML_URL     := https://downloads.sourceforge.net/project/plantuml/$(PLANTUML_VERSION)/plantuml.1.2018.14.jar
PLANTUML_DOWNLOAD := $(DOWNLOADS)/plantuml
PLANTUML_PREBUILT := plantuml-prebuilt

plantuml: plantuml-install

plantuml-download:
	if [ ! -d $(PLANTUML_DOWNLOAD) ]; then \
	    mkdir -p $(PLANTUML_DOWNLOAD) && \
	    cd $(PLANTUML_DOWNLOAD) && \
	    wget $(PLANTUML_URL) \
	    ; \
	fi

plantuml-install: plantuml-download
	if [ ! -d $(PLANTUML_PREBUILT) ]; then \
	    mkdir -p $(PLANTUML_PREBUILT) && \
	    cp -R $(PLANTUML_DOWNLOAD)/$(PLANTUML_NAME) $(PLANTUML_PREBUILT) \
	    ; \
	fi

# Docker base images
DOCKER_BASE_NAME   := finaldie/dev-base
DOCKER_CLANG_NAME  := finaldie/dev-clang
DOCKER_CQUERY_NAME := finaldie/dev-cquery
DOCKER_CCLS_NAME   := finaldie/dev-ccls
DOCKER_JAVA_NAME   := finaldie/dev-java

docker-deps: docker-base docker-clang docker-cquery docker-ccls docker-java

docker-base:
	@docker build --rm -t $(DOCKER_BASE_NAME) -f ./Dockerfile.base ../

docker-clang: docker-base
	@docker build --rm -t $(DOCKER_CLANG_NAME) -f ./Dockerfile.clang ../

docker-cquery: docker-base
	@docker build --rm -t $(DOCKER_CQUERY_NAME) -f ./Dockerfile.cquery ../

docker-ccls: docker-clang
	@docker build --rm -t $(DOCKER_CCLS_NAME) -f ./Dockerfile.ccls ../

docker-java:
	@docker build --rm -t $(DOCKER_JAVA_NAME) -f ./Dockerfile.javaimg ../
