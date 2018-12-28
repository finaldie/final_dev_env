
DOWNLOADS := downloads

CLANG7_VERSION  := 7.0.0
CLANG7_NAME     := clang+llvm-7.0.0-x86_64-linux-gnu-ubuntu-16.04
CLANG7_TAR      := $(CLANG7_NAME).tar.xz
CLANG7_URL      := http://releases.llvm.org/7.0.0/$(CLANG7_TAR)

CLANG7_DOWNLOAD := $(DOWNLOADS)/clang7-download
CLANG7_PREBUILT := clang7-prebuilt

clang7: clang7-install

clang7-download:
	test -d $(CLANG7_DOWNLOAD) || ( \
	    mkdir -p $(CLANG7_DOWNLOAD) \
	    && cd $(CLANG7_DOWNLOAD)
	    && wget $(CLANG7_URL) \
	    && tar -xf $(CLANG7_TAR) \
	    );

clang7-install: clang7-download
	test -d $(CLANG7_PREBUILT) || ( \
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
	    && cp -R $(CLANG7_DOWNLOAD)/$(CLANG7_NAME)/share/clang/clang-format.py $(CLANG7_PREBUILT)/share/clang \
	    );

