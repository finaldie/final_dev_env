FROM finaldie/dev-cquery as dev-cquery
FROM finaldie/dev-ccls as dev-ccls
FROM finaldie/dev-java as dev-java
FROM finaldie/dev-clang:latest

VOLUME /workspace
WORKDIR /workspace

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Package Versions
ENV FZF_VERION 0.18.0
ENV JEMALLOC_VERSION 5.2.0
ENV PROTOBUF_VERION v3.7.1
ENV NEOVIM_VERSION v0.3.5

ENV JAVA_PKG_VERSION jdk-11.0.1
ENV JAVA_HOME /usr/local/lib/jvm/${JAVA_PKG_VERSION}

ENV MAVEN_VERSION 3.6.0
ENV MAVEN_DOWNLOAD_URL http://apache.mirrors.hoobly.com/maven/maven-3/3.6.0/binaries/apache-maven-3.6.0-bin.tar.gz

ENV PLANTUML_VERSION 1.2019.5

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
#                          Install Compilers
# -----------------------------------------------------------------------------
# ------------------------ Nodejs ---------------------------------------------
RUN set -ex; \
    git clone --depth 1 --recurse-submodules -j8 git://github.com/tj/n.git /build/n \
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
    mkdir -p ${JAVA_HOME}

COPY --from=dev-java ${JAVA_HOME} ${JAVA_HOME}

# Create symbol links and Verification
RUN set -ex; \
    cd /usr/local/bin \
    && ln -s /usr/local/lib/jvm/${JAVA_PKG_VERSION}/bin/java java \
    && ln -s /usr/local/lib/jvm/${JAVA_PKG_VERSION}/bin/javac javac \
    \
    && echo $PATH \
    && ls -l /usr/local/lib/jvm \
    && ls -l /usr/local/lib/jvm/${JAVA_PKG_VERSION} \
    && ls -l /usr/local/lib/jvm/${JAVA_PKG_VERSION}/bin \
    && ls -l /usr/local/bin \
    # Verification
    && java --version \
    && javac --version


# ------------------------ APACHE MAVEN ---------------------------------------
RUN set -ex; \
    mkdir -p /build/maven \
    && cd /build/maven \
    && wget $MAVEN_DOWNLOAD_URL \
    && tar -zxf apache-maven-${MAVEN_VERSION}-bin.tar.gz \
    && rm -rf apache-maven-${MAVEN_VERSION}-bin.tar.gz

# -----------------------------------------------------------------------------
#                          Install Libraries/Tools
# -----------------------------------------------------------------------------
# ------------------------ command line tool: fzf -----------------------------
RUN set -ex; \
    git clone --branch $FZF_VERION --depth 1 --recurse-submodules -j8 \
        git://github.com/junegunn/fzf.git /build/fzf \
    && cd /build/fzf \
    && ./install --all

# ------------------------ command line tool: plantuml ------------------------
COPY ./docker/plantuml-prebuilt/plantuml.${PLANTUML_VERSION}.jar /usr/local/lib/plantuml.jar
COPY ./docker/tools/plantuml /usr/local/bin

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
    && ./configure \
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
    # Env
    which python3 \
    \
    # Build
    && git clone --depth 1 --recurse-submodules -j8 \
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
    # Env
    which python3 \
    \
    # Build
    && git clone --branch $NEOVIM_VERSION --depth 1 --recurse-submodules -j8 \
        git://github.com/neovim/neovim.git /build/neovim \
    && cd /build/neovim \
    && make CMAKE_BUILD_TYPE=Release -j8 \
    && make install \
    && cd \
    && rm -rf /build/neovim

# -----------------------------------------------------------------------------
#                          Post-Install/Fix Plugin Dependencies
# -----------------------------------------------------------------------------
## Post-Install LanguageClient-neovim
RUN set -ex; \
    cd /build/user_env/vim/plugged/LanguageClient-neovim \
    && bash ./install.sh

RUN set -ex; \
    nvim --headless +UpdateRemotePlugins +qall

# -----------------------------------------------------------------------------
#                          Install Language Servers
# -----------------------------------------------------------------------------
# ------------------------ cquery (C/C++) -------------------------------------
COPY --from=dev-cquery /usr/local/bin/cquery /usr/local/bin

# ------------------------ ccls (C/C++) ---------------------------------------
COPY --from=dev-ccls /usr/local/bin/ccls /usr/local/bin

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

