# Fenv
The project is Basic Development Environment, including:
* bashrc
* vimrc, plugins
* gitconfig
* ...

This environment is very simple, clean and easy to manage.

# How to Install

## Step 1 - Clone and Deploy
First click `Fork` Button, then clone the code from your own repository and install it
```c
git clone git@github.com:$yourname/final_dev_env.git fenv
cd fenv
git submodule update --init
make
```

## Step 2 - Link Bashrc
* After `make`, you will see the following text:

    ```bash
    if [ -f /path/to/fenv/user_env/all.bashrc ]; then
        . /path/to/fenv/user_env/all.bashrc
    fi
    ```

* Copy this into your own ~/.bash_profile
* Restart Bash

**NOTE:** After that, the two global environment variables already there:
* FENV_HOME - All the bashrcs, git config and vim plugins here
* FENV_GIT - the place of this repository in your computer

## Step 3 - Install Vim Plugins
All the vim plugins is managed by [Vundle][1], so you need to install them for the first time

* Run `vim +PluginInstall +qall`

**NOTE:** You also can open vim and run `:PluginInstall` for the first time<br>
**NOTE:** For updating plugins, you can run `:PluginUpdate` to update all your plugins

## Step 4 - Special Plugin
For who also install the [YouCompleteMe][2], to complete this plugin's installation step:
* go to its folder `$FENV_HOME/vim/YouCompleteMe`
* Run `./install.sh --clang-completer`

### Using System Clang
If you are using Mac, use system clang will be a better solution<br>
* go to its folder `$FENV_HOME/vim/YouCompleteMe`
* Run `./install.sh --clang-completer --system-libclang`

**NOTE:** If you are a Mac User, please download the lastest [MacVim][3].

## Step 5 - Enjoy
Now, your development environment is ready, any question/problem please file an issue here. If you also like it, please `Star` it.

## Furture Read
### Update Vim Plugins
If you only want to update your vim plugins, just run the following in your shell:
```
bash$ vim +PluginInstall +qall
```

### Update all scripts/configs
```
make
```

**NOTES:** This won't break your vim plugins, only re-deploy your scripts/configs

# Contribution
If you have more suggestions or recommendations, it's great to send a pull request.

# References
## Vim Plugins
The following are the total plugins in here:
* [NERDTree][4]
* [powerline][5]
* [taglist][6]
* [YouCompleteMe][2]
* [easymotion][8]
* [CtrlP][9]

[1]: https://github.com/gmarik/vundle
[2]: https://github.com/Valloric/YouCompleteMe?source=cc
[3]: https://github.com/b4winckler/macvim/releases
[4]: https://github.com/scrooloose/nerdtree
[5]: https://github.com/Lokaltog/powerline
[6]: https://github.com/vim-scripts/taglist.vim
[8]: https://github.com/Lokaltog/vim-easymotion
[9]: https://github.com/kien/ctrlp.vim
[10]: https://github.com/altercation/solarized
