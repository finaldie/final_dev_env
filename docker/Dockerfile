# Based on ubuntu 18.04 image
FROM ubuntu:18.04

VOLUME /workspace
WORKDIR /workspace

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install all base dependencies
RUN set -ex; \
    deps=' \
        git \
        tmux \
        lsof \
        strace \
        ltrace \
        pstack \
        telnet \
        iproute2 \
        netcat-openbsd \
        expect \
        net-tools \
        psmisc \
        curl \
        wget \
        exuberant-ctags \
        cscope \
        build-essential \
        gdb \
        bear \
        valgrind \
        autoconf \
        automake \
        libtool \
        ncurses-dev \
        libyaml-dev \
        cmake \
        tree \
        less \
        dnsutils \
        fonts-powerline \
        python3-dev \
        python3-pip \
        python3-setuptools \
        python3-wheel \
    ';\
    apt-get update && apt-get install -y --no-install-recommends \
        $deps \
    && rm -rf /var/lib/apt/lists/* \
    && pip3 install \
        pylint \
        PyYAML \
        pympler \
        WebOb \
        dnslib \
    # Create Building folder
    && mkdir /build

## Install Clang/LLVM pre-built toolchains:
#  - Install bin: clang-7, clangd, clang-tidy, clang-format, lld -> /usr/local/bin/
#  - Install includes: lib/clang -> /usr/local/lib/clang
#  - Install libs: libclang.so.7 -> /usr/local/lib/
#  - Install share: clang-format.py -> /usr/local/share/clang/
# Notes, the pre-built bin/lib/includes should be already downloaded
# Create symbol links
COPY ./docker/clang7-prebuilt/bin/* /usr/local/bin/
COPY ./docker/clang7-prebuilt/lib/clang /usr/local/lib/clang/
COPY ./docker/clang7-prebuilt/lib/libclang.so.7 /usr/local/lib/
COPY ./docker/clang7-prebuilt/share/clang/* /usr/local/share/clang/

# Create symbol links
RUN set -ex; \
    cd /usr/local/bin \
    && ln -s clang-7 clang \
    && ln -s clang clang++ \
    && ln -s lld ld.lld \
    && ln -s lld ld64.lld \
    && ln -s lld lld-link \
    && ln -s lld wasm-ld \
    && cd /usr/local/lib \
    && ln -s libclang.so.7 libclang.so \
    \
    # Verification
    && ls -l /usr/local/bin \
    && ls -l /usr/local/lib \
    && ls -l /usr/local/share

# Compile and Install latest jemalloc
RUN set -ex; \
    git clone --branch 5.1.0 --depth 1 --recurse-submodules -j8 \
        git://github.com/jemalloc/jemalloc.git /build/jemalloc \
    && cd /build/jemalloc \
    && ./autogen.sh \
    && make -j8 \
    && make install_bin install_include install_lib \
    && cd \
    && rm -rf /build/jemalloc

# Compile and Install protobuf
RUN set -ex; \
    git clone --branch v3.6.1 --depth 1 --recurse-submodules -j8 \
        git://github.com/protocolbuffers/protobuf.git /build/protobuf \
    # Build c++ protobuf
    && cd /build/protobuf \
    && ./autogen.sh \
    && ./configure --enable-static=no \
    && make -j8 \
    \
    # Build python protobuf
    && cd /build/protobuf/python \
    && export LD_LIBRARY_PATH=../src/.libs \
    && python3 setup.py build --cpp_implementation \
    \
    # Install c++ protobuf
    && cd /build/protobuf \
    && make install \
    && (ldconfig || true) \
    \
    # Install python protobuf
    && cd /build/protobuf/python \
    && export LD_LIBRARY_PATH=../src/.libs \
    && python3 setup.py install --cpp_implementation \
    \
    # Clean up
    && cd \
    && rm -rf /build/protobuf

# Install vim
RUN set -ex; \
    git clone --depth 1 --recurse-submodules -j8 git://github.com/vim/vim.git /build/vim \
    && cd /build/vim \
    && ./configure --enable-python3interp=yes \
                   --with-python3-config-dir=`python3-config --configdir` \
                   --with-features=huge \
    && make -j8 \
    && make install \
    && cd \
    && rm -rf /build/vim

# Install neovim
RUN set -ex; \
    deps=' \
        ninja-build \
        gettext \
        libtool-bin \
        automake \
        pkg-config \
        unzip \
    ';\
    apt-get update && apt-get install -y --no-install-recommends \
        $deps \
    && rm -rf /var/lib/apt/lists/* \
    && git clone --branch v0.3.1 --depth 1 --recurse-submodules -j8 \
        git://github.com/neovim/neovim.git /build/neovim \
    && cd /build/neovim \
    && make CMAKE_BUILD_TYPE=Release -j8 \
    && make install \
    && cd \
    && rm -rf /build/neovim \
    && apt-get purge -y --auto-remove $deps

# Copy files and fix bashrcs
COPY ./docker/bash_profile /root/.bash_profile
COPY ./user_env /build/user_env

# Fix bash variables
RUN set -ex; \
    cat /root/.bash_profile >> /root/.bashrc \
    && sed -i 's:export FENV_HOME=.*:export FENV_HOME=/build/user_env:' /build/user_env/bash/env_home.bashrc \
    && sed -i 's:export FENV_GIT=.*:export FENV_GIT=/build:' /build/user_env/bash/env_home.bashrc \
    && sed -i 's:export XDG_CONFIG_HOME=.*:export XDG_CONFIG_HOME=/build/user_env:' /build/user_env/bash/export_xdg_home.bashrc \
    && cat /build/user_env/all.bashrc | sed '/^$/d' | awk -F '/' '{print $NF}' | awk '{printf "source /build/user_env/bash/%s\n", $1}' > /build/user_env/all.bashrc.new \
    && mv /build/user_env/all.bashrc.new /build/user_env/all.bashrc

#  Install Language Servers
## Install YouCompleteMe
RUN set -ex; \
    python3 /build/user_env/vim/plugged/YouCompleteMe/install.py --clang-completer

## Install LanguageClient-neovim
RUN set -ex; \
    cd /build/user_env/vim/plugged/LanguageClient-neovim \
    && bash ./install.sh

## Install fzf command line tool
RUN set -ex; \
    git clone --branch 0.17.5 --depth 1 --recurse-submodules -j8 \
        git://github.com/junegunn/fzf.git /build/fzf \
    && cd /build/fzf \
    && ./install --all

## Install cquery
RUN set -ex; \
    git clone --depth 1 --recurse-submodules -j8 \
        git://github.com/cquery-project/cquery.git /build/cquery \
    && cd /build/cquery \
    && mkdir build \
    && cd build \
    && cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=release \
    && cmake --build . \
    && cmake --build . --target install \
    # Install cquery into usr local
    && cp /build/cquery/build/release/bin/cquery /usr/local/bin \
    # Remove cquery build folder
    && cd / \
    && rm -rf /build/cquery

## Install ccls
RUN set -ex; \
    deps=' \
        zlib1g-dev \
    ';\
    apt-get update && apt-get install -y --no-install-recommends \
        $deps \
    && rm -rf /var/lib/apt/lists/* \
    && git clone --depth 1 --recurse-submodules -j8 \
        git://github.com/MaskRay/ccls.git /build/ccls \
    && cd /build/ccls \
    && cmake -H. -BRelease -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_LINKER=/usr/local/bin/lld \
    # Hack cmake internal clang path
    && sed -i 's|Clang_EXECUTABLE:FILEPATH=.*|Clang_EXECUTABLE:FILEPATH=/usr/local/bin/clang|' Release/CMakeCache.txt \
    && cmake --build Release \
    && cp /build/ccls/Release/ccls /usr/local/bin \
    && cd / \
    && rm -rf /build/ccls \
    && apt-get purge -y --auto-remove $deps

# Install linters and fixers/formatters
RUN set -ex; \
    deps=' \
        # Install node.js package manager
        npm \
        # Install shell linter
        shellcheck \
    ';\
    apt-get update && apt-get install -y --no-install-recommends \
        $deps \
    '; \
    # Install js pkg manager yarn
    npm install yarn --global \
    yarn global add prettier \
    rm -rf /var/lib/apt/lists/*

# Install python3 vim/neovim plugin/dependencies
RUN set -ex; \
    pip3 install \
        # Plugin dependencies
        ## pynvim is part of neovim/vim8 deoplete.nvim plugin as neovim py client
        pynvim \
        \
        # Language Servers
        ## Python lang server
        python-language-server \
        yapf \
        rope \
        \
        # Linters
        ## python linters
        flake8 \
        pylint \
        \
        ## yaml linter
        yamllint

# Post-Install
RUN set -ex; \
    # Finish the last step of deoplete.nvim for neovim if needed
    nvim +UpdateRemotePlugins +qall

# Entrypoint
CMD ["/bin/bash"]

