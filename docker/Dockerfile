FROM finaldie/dev-base

VOLUME /workspace
WORKDIR /workspace

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Package Versions
ENV PLANTUML_VERSION 1.2019.6

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
#                          Install Libraries/Tools
# -----------------------------------------------------------------------------

# ------------------------ command line tool: plantuml ------------------------
COPY ./docker/plantuml-prebuilt/plantuml.${PLANTUML_VERSION}.jar /usr/local/lib/plantuml.jar
COPY ./docker/tools/plantuml /usr/local/bin

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
# ------------------------ ccls (C/C++) ---------------------------------------
RUN set -ex; \
    git clone --depth 1 --recurse-submodules -j8 \
        git://github.com/MaskRay/ccls.git /build/ccls \
    && cd /build/ccls \
    && cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_CXX_COMPILER=clang++ \
    && cmake --build Release \
    && cp /build/ccls/Release/ccls /usr/local/bin \
    && cd / \
    && rm -rf /build/ccls

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

# ------------------------ HTML -----------------------------------------------
RUN set -ex; \
    yarn global add prettier

# ------------------------ JavaScript -----------------------------------------
RUN set -ex; \
    yarn global add prettier \
    && npm install --global eslint

# -----------------------------------------------------------------------------
#                          Create builder user
# -----------------------------------------------------------------------------
RUN useradd -m -g users -G wheel -s /bin/bash builder

#USER builder

# Entrypoint
CMD ["/bin/bash"]

