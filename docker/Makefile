
DOWNLOADS := downloads

# plantuml

PLANTUML_VERSION := 1.2019.6
PLANTUML_NAME    := plantuml.$(PLANTUML_VERSION).jar
PLANTUML_URL     := https://downloads.sourceforge.net/project/plantuml/$(PLANTUML_VERSION)/plantuml.$(PLANTUML_VERSION).jar
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
DOCKER_CCLS_NAME   := finaldie/dev-ccls

docker-deps: plantuml docker-base

docker-base:
	@docker build --rm -t $(DOCKER_BASE_NAME) -f ./Dockerfile.base ../
