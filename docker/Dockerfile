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
        exuberant-ctags \
        cscope \
        build-essential \
        gdb \
        valgrind \
        autoconf \
        ncurses-dev \
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
        dnslib

# Compile and Install latest jemalloc
RUN set -ex; \
    git clone --branch 5.1.0 --depth 1 --recurse-submodules -j8 \
    git://github.com/jemalloc/jemalloc.git /jemalloc \
    && cd /jemalloc \
    && ./autogen.sh \
    && make -j8 \
    && make install_bin install_include install_lib \
    && cd \
    && rm -rf /jemalloc

# Install vim
RUN set -ex; \
    git clone --depth 1 --recurse-submodules -j8 git://github.com/vim/vim.git /vim \
    && cd /vim \
    && ./configure --enable-python3interp=yes \
                   --with-python3-config-dir=`python3-config --configdir` \
                   --with-features=huge \
    && make -j8 \
    && make install \
    && cd \
    && rm -rf /vim

# Install neovim
RUN set -ex; \
    deps=' \
        ninja-build \
        gettext \
        libtool \
        libtool-bin \
        automake \
        pkg-config \
        unzip \
    ';\
    apt-get update && apt-get install -y --no-install-recommends \
        $deps \
    && rm -rf /var/lib/apt/lists/* \
    && git clone --branch v0.3.1 --depth 1 --recurse-submodules -j8 git://github.com/neovim/neovim.git /neovim \
    && cd /neovim \
    && make CMAKE_BUILD_TYPE=Release -j8 \
    && make install \
    && cd \
    && rm -rf /neovim \
    && apt-get purge -y --auto-remove $deps

# Install vim/neovim plugin/dependencies
RUN set -ex; \
    pip3 install \
        # pynvim is part of neovim/vim8 deoplete.nvim plugin
        pynvim \
        # python linters
        flake8 \
        pylint

# Copy files and fix bashrcs
COPY ./docker/bash_profile /root/.bash_profile
COPY ./ /build

RUN set -ex; \
    cat /root/.bash_profile >> /root/.bashrc \
    && sed -i 's:export FENV_HOME=.*:export FENV_HOME=/build/user_env:' /build/user_env/bash/env_home.bashrc \
    && sed -i 's:export FENV_GIT=.*:export FENV_GIT=/build:' /build/user_env/bash/env_home.bashrc \
    && sed -i 's:export XDG_CONFIG_HOME=.*:export XDG_CONFIG_HOME=/build/user_env:' /build/user_env/bash/export_xdg_home.bashrc \
    && cat /build/user_env/all.bashrc | sed '/^$/d' | awk -F '/' '{print $NF}' | awk '{printf "source /build/user_env/bash/%s\n", $1}' > /build/user_env/all.bashrc.new \
    && mv /build/user_env/all.bashrc.new /build/user_env/all.bashrc

# Install YouCompleteMe
RUN set -ex; \
    python3 /build/user_env/vim/YouCompleteMe/install.py --clang-completer

# Install LanguageClient-neovim
RUN set -ex; \
    cd /build/user_env/vim/LanguageClient-neovim \
    && bash ./install.sh

# Entrypoint
CMD ["/bin/bash"]

