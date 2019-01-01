# Fenv

![fenv](https://github.com/finaldie/misc/blob/master/articals/fenv/fenv.gif)

The project is Basic Development Environment, including:

- bashrc
- vimrc, plugins
- gitconfig
- ...

This environment is a simple, clean and easy to manage.

## Vim Plugins

The following are the total plugins in here:

- Common Plugins
  - [scrooloose/NERDTree][4]
  - [easymotion/vim-easymotion][8]
  - [majutsushi/tagbar][14]
  - [ludovicchabant/vim-gutentags][13]
  - [ctrlpvim/ctrlp.vim][9]
  - [tpope/vim-surround][20]
- Status Bar
  - [vim-airline/vim-airline][11]
- Git
  - [tpope/vim-fugitive][12]
  - [airblade/vim-gitgutter][21]
- Coding
  - [Valloric/YouCompleteMe][2]
  - [autozimu/languageclient-neovim][15]
  - [honza/vim-snippets][17]
  - [w0rp/ale][18]
- Omnifunc Management
  - [Shougo/deoplete.nvim][16]

## Code Browsing/Completion

| Language   | Language Server                               |
| ---------- | --------------------------------------------- |
| C/C++      | YouCompleteMe(libclang), cquery, clangd, ccls |
| Python     | YouCompleteMe(jedi), pyls                     |
| Java       | YouCompleteMe(eclipse-jdt)                    |
| Javascript | YouCompleteMe(tsserver)                       |
| Bash       | bash-language-server                          |

## Code Linters

| Language   | Linter                     |
| ---------- | -------------------------- |
| C/C++      | clangtidy                  |
| Python     | flake8, pylint             |
| Bash       | shellcheck                 |
| YAML       | yamllint                   |
| Markdown   | alex, write-good           |
| Json       | jsonlint                   |
| XML        | xmllint                    |
| HTML       | htmllint, alex, write-good |
| Javascript | eslint                     |

## Code Fixers/Formatters

| Language   | Fixers/Formatters |
| ---------- | ----------------- |
| C/C++      | clang-format      |
| Python     | isort, yapf       |
| Bash       | N/A               |
| YAML       | prettier          |
| Markdown   | prettier          |
| Json       | jq, prettier      |
| XML        | xmllint           |
| HTML       | prettier          |
| Javascript | prettier, eslint  |

# All-in-one Docker Image

Besides go through the `Installation` steps, the eaisest way to use this environment is pulling the docker image, and start it directly:

## Pull Docker Image

```console
docker pull finaldie/dev
```

This docker image is based on `Ubuntu 18.10` release, and includes all basic build toolchains which work out of box.

## Start

From the project you want to jump in the dev environment, then type:

```console
docker run -it --rm -v `pwd`:/workspace finaldie/dev
```

Then, we enter the dev environment with all the scripts we want.

**Notes:** Configure above into `.bash_profile` would save a lot time in the future.

```console
alias dev='docker run -it --rm -v `pwd`:/workspace finaldie/dev'
```

# How to Install

If we want to build it from scratch, follow the step 1 to 4 :)

## Step 1 - Clone and Deploy

First click `Fork` Button, then clone the code from your own repository and install it

```c
git clone git@github.com:$yourname/final_dev_env.git fenv
cd fenv
git submodule update --init
make
```

## Step 2 - Link Bashrc

- After `make`, you will see the following text:

  ```bash
  if [ -f /path/to/fenv/user_env/all.bashrc ]; then
      . /path/to/fenv/user_env/all.bashrc
  fi
  ```

- Copy this into your own ~/.bash_profile
- Restart Bash

**NOTE:** After that, the two global environment variables already there:

- FENV_HOME - All the bashrcs, git config and vim plugins here
- FENV_GIT - the place of this repository in your computer

## Step 3 - Install Vim Plugins

All the vim plugins are managed by [vim-plug][22], so you need to install them for the first time

- Run `vim +PlugInstall +qall`

**NOTE:** You also can open vim and run `:PluginInstall` for the first time<br>
**NOTE:** For updating plugins, you can run `:PluginUpdate` to update all your plugins

## Step 4 - Special Plugin

For who also install the [YouCompleteMe][2], to complete this plugin's installation step:

- go to its folder `$FENV_HOME/vim/YouCompleteMe`
- Run `./install.py --clang-completer`

### Using System Clang

If in Mac, use system clang sometimes may be a solution, but not recommended<br>

- go to its folder `$FENV_HOME/vim/YouCompleteMe`
- Run `./install.py --clang-completer --system-libclang`

**NOTE:** If you are a Mac User, please download the lastest [MacVim][3].

## Enjoy

Now, your development environment is ready, any question/problem please file an issue here. If you also like it, please `Star` it.

## Furture Read

### Update Vim Plugins

If you only want to update your vim plugins, just run the following in your shell:

```
bash$ vim +PluginUpdate +qall
```

### Update all scripts/configs

```
make
```

**NOTES:** This won't break your vim plugins, only re-deploy your scripts/configs

### Install Powerline-Font

To give a better experience, install [SourceCodePro](19) font for the terminal. <br>
Download it and install it in the laptop, and configure it from the terminal settings.

# Contribution

If you have more suggestions or recommendations, it's great to send a pull request.

[1]: https://github.com/gmarik/vundle
[2]: https://github.com/Valloric/YouCompleteMe
[3]: https://github.com/b4winckler/macvim/releases
[4]: https://github.com/scrooloose/nerdtree
[5]: https://github.com/Lokaltog/powerline
[6]: https://github.com/vim-scripts/taglist.vim
[8]: https://github.com/easymotion/vim-easymotion
[9]: https://github.com/ctrlpvim/ctrlp.vim
[10]: https://github.com/altercation/solarized
[11]: https://github.com/vim-airline/vim-airline
[12]: https://github.com/tpope/vim-fugitive
[13]: https://github.com/ludovicchabant/vim-gutentags
[14]: https://github.com/majutsushi/tagbar
[15]: https://github.com/autozimu/languageclient-neovim
[16]: https://github.com/Shougo/deoplete.nvim
[17]: https://github.com/honza/vim-snippets
[18]: https://github.com/w0rp/ale
[19]: https://github.com/powerline/fonts/tree/master/SourceCodePro
[20]: https://github.com/tpope/vim-surround
[21]: https://github.com/airblade/vim-gitgutter
[22]: https://github.com/junegunn/vim-plug
