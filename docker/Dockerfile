# Based on ubuntu 16.04 image
#FROM ubuntu:16.04
FROM ubuntu:17.10

VOLUME /workspace
WORKDIR /workspace

# Install all the dependencies
RUN set -ex; \
    deps=' \
        git \
        lsof \
        strace \
        ltrace \
        telnet \
        netcat-openbsd \
        expect \
        net-tools \
        psmisc \
        curl \
        exuberant-ctags \
        cscope \
        build-essential \
        libclang-dev \
        gdb \
        valgrind \
        autoconf \
        ncurses-dev \
        cmake \
        python-dev \
        python3-dev \
    ';\
    apt-get update && apt-get install -y --no-install-recommends \
        $deps \
    && rm -rf /var/lib/apt/lists/*

# Install vim
RUN set -ex; \
    git clone git://github.com/vim/vim.git /vim \
    && cd /vim \
    && ./configure --enable-python3interp=yes \
                   --with-python3-config-dir=`python3-config --configdir` \
    && make \
    && make install \
    && cd \
    && rm -rf /vim

COPY ./docker/bash_profile /root/.bash_profile
COPY ./ /build

RUN set -ex; \
    cat /root/.bash_profile >> /root/.bashrc \
    && sed -i 's:export FENV_HOME=.*:export FENV_HOME=/build/user_env:' /build/user_env/bash/env_home.bashrc \
    && sed -i 's:export FENV_GIT=.*:export FENV_GIT=/build:' /build/user_env/bash/env_home.bashrc \
    && sed -i 's:export XDG_CONFIG_HOME=.*:export XDG_CONFIG_HOME=/build/user_env:' /build/user_env/bash/export_xdg_home.bashrc \
    && cat /build/user_env/all.bashrc | sed '/^$/d' | awk -F '/' '{print $NF}' | awk '{printf "source /build/user_env/bash/%s\n", $1}' > /build/user_env/all.bashrc.new \
    && mv /build/user_env/all.bashrc.new /build/user_env/all.bashrc

RUN set -ex; \
    python3 /build/user_env/vim/YouCompleteMe/install.py --clang-completer --system-libclang

# Entrypoint
CMD ["/bin/bash"]

