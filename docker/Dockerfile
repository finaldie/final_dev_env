FROM ubuntu:18.10

VOLUME /workspace
WORKDIR /workspace

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Package Versions
ENV FZF_VERION 0.17.5
ENV JEMALLOC_VERSION 5.1.0
ENV PROTOBUF_VERION v3.6.1
ENV NEOVIM_VERSION v0.3.1
ENV JAVA_VERSION openjdk-11-jdk
ENV CLANG_VERSION 7

# -----------------------------------------------------------------------------
#                          Install Base Dependencies
# -----------------------------------------------------------------------------
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
        ncurses-dev \
        libyaml-dev \
        tree \
        less \
        dnsutils \
    ';\
    apt-get update && apt-get install -y --no-install-recommends \
        $deps \
    && rm -rf /var/lib/apt/lists/*

# Create Building folder
RUN set -ex; \
    mkdir /build

# -----------------------------------------------------------------------------
#                          Install Compilers
# -----------------------------------------------------------------------------
# ------------------------ GCC and Build ToolChain ----------------------------
RUN set -ex; \
    deps=' \
        build-essential \
        gdb \
        bear \
        valgrind \
        autoconf \
        automake \
        libtool \
        cmake \
    ';\
    apt-get update && apt-get install -y --no-install-recommends \
        $deps \
    && rm -rf /var/lib/apt/lists/*

# ------------------------ Python3 --------------------------------------------
RUN set -ex; \
    deps=' \
        python3-dev \
        python3-pip \
        python3-setuptools \
        python3-wheel \
    ';\
    apt-get update && apt-get install -y --no-install-recommends \
        $deps \
    && rm -rf /var/lib/apt/lists/* \
    && pip3 install \
        PyYAML \
        pympler \
        WebOb \
        dnslib

# ------------------------ Clang/LLVM pre-built -------------------------------
#  - Install bin: clang-7, clangd, clang-tidy, clang-format, lld -> /usr/local/bin/
#  - Install includes: lib/clang -> /usr/local/lib/clang
#  - Install libs: libclang.so.7 -> /usr/local/lib/
#  - Install share: clang-format.py -> /usr/local/share/clang/
# Notes, the pre-built bin/lib/includes should be already downloaded
# Create symbol links
COPY ./docker/clang${CLANG_VERSION}-prebuilt/bin/* /usr/local/bin/
COPY ./docker/clang${CLANG_VERSION}-prebuilt/lib/clang /usr/local/lib/clang/
COPY ./docker/clang${CLANG_VERSION}-prebuilt/lib/libclang.so.${CLANG_VERSION} /usr/local/lib/
COPY ./docker/clang${CLANG_VERSION}-prebuilt/share/clang/* /usr/local/share/clang/

# Create symbol links
RUN set -ex; \
    cd /usr/local/bin \
    && ln -s clang-${CLANG_VERSION} clang \
    && ln -s clang clang++ \
    && ln -s lld ld.lld \
    && ln -s lld ld64.lld \
    && ln -s lld lld-link \
    && ln -s lld wasm-ld \
    && cd /usr/local/lib \
    && ln -s libclang.so.${CLANG_VERSION} libclang.so \
    \
    # Verification
    && ls -l /usr/local/bin \
    && ls -l /usr/local/lib \
    && ls -l /usr/local/share \
    && clang --version \
    && clang++ --version

# ------------------------ Nodejs ---------------------------------------------
RUN set -ex; \
    git clone git://github.com/tj/n.git /build/n \
    && cd /build/n \
    && make install \
    # Install node.js, npm and yarn
    && n lts \
    && curl -0 -L https://npmjs.com/install.sh | sh \
    && node -v \
    && npm -v \
    && npm install yarn --global \
    && rm -rf /build/n

# ------------------------ OpenJDK --------------------------------------------
RUN set -ex; \
    apt-get update && apt-get install -y --no-install-recommends \
        $JAVA_VERSION \
    && rm -rf /var/lib/apt/lists/* \
    && java --version \
    && javac --version

# -----------------------------------------------------------------------------
#                          Install Libraries/Tools
# -----------------------------------------------------------------------------
# ------------------------ command line tool: fzf -----------------------------
RUN set -ex; \
    git clone --branch $FZF_VERION --depth 1 --recurse-submodules -j8 \
        git://github.com/junegunn/fzf.git /build/fzf \
    && cd /build/fzf \
    && ./install --all

# ------------------------ Jemalloc -------------------------------------------
RUN set -ex; \
    git clone --branch $JEMALLOC_VERSION --depth 1 --recurse-submodules -j8 \
        git://github.com/jemalloc/jemalloc.git /build/jemalloc \
    && cd /build/jemalloc \
    && ./autogen.sh \
    && make -j8 \
    && make install_bin install_include install_lib \
    && cd \
    && rm -rf /build/jemalloc

# ------------------------ Protobuf -------------------------------------------
RUN set -ex; \
    git clone --branch $PROTOBUF_VERION --depth 1 --recurse-submodules -j8 \
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

# -----------------------------------------------------------------------------
#                          Install Editors
# -----------------------------------------------------------------------------
# ------------------------ VIM ------------------------------------------------
RUN set -ex; \
    git clone --depth 1 --recurse-submodules -j8 \
        git://github.com/vim/vim.git /build/vim \
    && cd /build/vim \
    && ./configure --enable-python3interp=yes \
                   --with-python3-config-dir=`python3-config --configdir` \
                   --with-features=huge \
    && make -j8 \
    && make install \
    && cd \
    && rm -rf /build/vim

# ------------------------ NEOVIM ---------------------------------------------
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
    && git clone --branch $NEOVIM_VERSION --depth 1 --recurse-submodules -j8 \
        git://github.com/neovim/neovim.git /build/neovim \
    && cd /build/neovim \
    && make CMAKE_BUILD_TYPE=Release -j8 \
    && make install \
    && cd \
    && rm -rf /build/neovim \
    && apt-get purge -y --auto-remove $deps


# -----------------------------------------------------------------------------
#                          Install Fenv Plugins
# -----------------------------------------------------------------------------
# Copy files and fix bashrcs
COPY ./docker/bash_profile /root/.bash_profile
COPY ./user_env /build/user_env

# Fix bash variables
RUN set -ex; \
    cat /root/.bash_profile >> /root/.bashrc \
    && sed -i 's:export FENV_HOME=.*:export FENV_HOME=/build/user_env:' \
        /build/user_env/bash/env_home.bashrc \
    && sed -i 's:export FENV_GIT=.*:export FENV_GIT=/build:' \
        /build/user_env/bash/env_home.bashrc \
    && sed -i 's:export XDG_CONFIG_HOME=.*:export XDG_CONFIG_HOME=/build/user_env:' \
        /build/user_env/bash/export_xdg_home.bashrc \
    && cat /build/user_env/all.bashrc | sed '/^$/d' | awk -F '/' '{print $NF}' \
        | awk '{printf "source /build/user_env/bash/%s\n", $1}' > /build/user_env/all.bashrc.new \
    && mv /build/user_env/all.bashrc.new /build/user_env/all.bashrc

# -----------------------------------------------------------------------------
#                          Post-Install/Fix Plugin Dependencies
# -----------------------------------------------------------------------------
## Post-Install LanguageClient-neovim
RUN set -ex; \
    cd /build/user_env/vim/plugged/LanguageClient-neovim \
    && bash ./install.sh

## Post-Install deoplete.nvim
RUN set -ex; \
    pip3 install \
        pynvim \
    # Finish the last step of deoplete.nvim for neovim if needed
    && nvim --headless +UpdateRemotePlugins +qall &> /dev/null

# -----------------------------------------------------------------------------
#                          Install Language Servers
# -----------------------------------------------------------------------------
# ------------------------ cquery (C/C++) -------------------------------------
RUN set -ex; \
    deps=' \
        libtinfo5 \
    ';\
    apt-get update && apt-get install -y --no-install-recommends \
        $deps \
    && rm -rf /var/lib/apt/lists/* \
    && git clone --depth 1 --recurse-submodules -j8 \
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

# ------------------------ ccls (C/C++) ---------------------------------------
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

# -------- YouCompleteMe: Enable C/C++, JavaScript/TypeScript and Java --------
RUN set -ex; \
    python3 /build/user_env/vim/plugged/YouCompleteMe/install.py \
        --clang-completer --ts-completer --java-completer

# ------------------------ Bash ---------------------------------------
RUN set -ex; \
    npm i -g --unsafe-perm bash-language-server

# ------------------------ Python (pyls) --------------------------------------
RUN set -ex; \
    pip3 install \
        python-language-server

# -----------------------------------------------------------------------------
#                          Install Language Linters
# -----------------------------------------------------------------------------
# ------------------------ Python3 --------------------------------------------
RUN set -ex; \
    pip3 install \
        flake8 \
        pylint

# ------------------------ Bash -----------------------------------------------
RUN set -ex; \
    deps=' \
        shellcheck \
    ';\
    apt-get update && apt-get install -y --no-install-recommends \
        $deps \
    && rm -rf /var/lib/apt/lists/*

# ------------------------ YAML -----------------------------------------------
RUN set -ex; \
    pip3 install \
        yamllint

# ------------------------ MarkDown -------------------------------------------
RUN set -ex; \
    npm install --global write-good \
    && npm install --global alex

# ------------------------ JSON -----------------------------------------------
RUN set -ex; \
    yarn global add jsonlint

# ------------------------ XML ------------------------------------------------
RUN set -ex; \
    deps=' \
        libxml2-utils \
    ';\
    apt-get update && apt-get install -y --no-install-recommends \
        $deps \
    && rm -rf /var/lib/apt/lists/*

# ------------------------ HTML -----------------------------------------------
RUN set -ex; \
    # natural language
    npm install --global write-good \
    && npm install --global alex \
    \
    # html syntax lint
    && npm install --global htmlhint

# ------------------------ JavaScript -----------------------------------------
RUN set -ex; \
    npm install --global eslint

# -----------------------------------------------------------------------------
#                          Install Language Fixers/Formatters
# -----------------------------------------------------------------------------
# ------------------------ Python3 --------------------------------------------
RUN set -ex; \
    pip3 install \
        # code formatting (preferred over autopep8)
        yapf \
        # Completions and renaming
        rope

# ------------------------ YAML -----------------------------------------------
RUN set -ex; \
    yarn global add prettier

# ------------------------ MarkDown -------------------------------------------
RUN set -ex; \
    yarn global add prettier

# ------------------------ JSON -----------------------------------------------
RUN set -ex; \
    deps=' \
        # Install json formatter
        jq \
    ';\
    apt-get update && apt-get install -y --no-install-recommends \
        $deps \
    && rm -rf /var/lib/apt/lists/* \
    \
    && yarn global add prettier

# ------------------------ XML ------------------------------------------------
RUN set -ex; \
    deps=' \
        libxml2-utils \
    ';\
    apt-get update && apt-get install -y --no-install-recommends \
        $deps \
    && rm -rf /var/lib/apt/lists/*

# ------------------------ HTML -----------------------------------------------
RUN set -ex; \
    yarn global add prettier

# ------------------------ JavaScript -----------------------------------------
RUN set -ex; \
    yarn global add prettier \
    && npm install --global eslint


# Entrypoint
CMD ["/bin/bash"]

