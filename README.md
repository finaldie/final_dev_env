# Fenv
The project is Basic Development Environment, including bashrc, vimrc/plugins, gitconfig, etc.
This environment is very simple, clean and very easy to manage.

# How to Install
----------------

## Step 1 - Clone and Deploy
First click `Fork` Button, then clone the code from your own repository and install it
```c
git clone git@github.com:$yourname/final_dev_env.git fenv
cd fenv
make
```

## Step 2 - Link Bashrc
* After `make`, you will see the following text:

    ```bash
    f [ -f /path/to/fenv/user_env/all.bashrc ]; then
        . /path/to/fenv/user_env/all.bashrc
    fi
    ```

* Copy this into your own ~/.bash_profile
* Restart Bash

## Step 3 - Install Vim Plugins
All the vim plugins is managed by [Vundle][1], so you need to install them for the first time

* Run `vim +BundleInstall +qall`

## Step 4 - Special Plugin
For who also install the [YouCompleteMe][2], to complete this plugin's installation step:
* go to its folder `$FENV_HOME/vim/YouCompleteMe`
* Run `./install.sh --clang-completer`

**NOTE:** If you are a Mac User, please download the lastest [MacVim][3].

[1]: https://github.com/gmarik/vundle
[2]: https://github.com/Valloric/YouCompleteMe?source=cc
[3]: https://github.com/b4winckler/macvim/releases
