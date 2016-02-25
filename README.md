# dotfiles

This repo contains some of the common programs and configurations I use when
bootstrapping a new machine.

## Basics

  * [Xcode](https://itunes.apple.com/us/app/xcode/id497799835?mt=12)
  * [Homebrew](http://brew.sh)
  * `brew install git mercurial lua openssl redis postgres`
  * `mkdir ~/git && cd ~/git && git clone https://github.com/tysontate/dotfiles.git`

## Terminal.app

In Terminal.app's preference window, select "Profiles" and then import the
`Terminal_app/Brown.terminal` profile.

## Git

(I use Kaleidoscope for mergetool and difftool.)

    ln -s ~/git/dotfiles/git/gitignore ~/.gitignore
    ln -s ~/git/dotfiles/git/gitconfig ~/.gitconfig

## ZSH

First, install [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh), then:

    ln -s ~/git/dotfiles/zsh/zshrc ~/.zshrc
    ln -s ~/git/dotfiles/zsh/zshenv ~/.zshenv
    ln -s ~/git/dotfiles/zsh/tyson.zsh-theme ~/.oh-my-zsh/themes/tyson.zsh-theme

## Go

    mkdir ~/go
    brew install go --with-cc-common

## Ruby

    brew install rbenv ruby-build
    rbenv install 2.2.2
    rbenv global 2.2.2

## Vim

1. Install MacVim:

        brew install macvim --override-system-vim
        brew linkapps macvim

2. Install [Input Mono](http://input.fontbureau.com)

3. Install [Janus](https://github.com/carlhuda/janus)

4. Link up vimrc files:

        ln -s ~/git/dotfiles/vim/vimrc.before ~/.vimrc.before
        ln -s ~/git/dotfiles/vim/vimrc.after ~/.vimrc.after
        ln -s ~/git/dotfiles/vim/gvimrc.after ~/.gvimrc.after
        mkdir -p ~/.janus
        ln -s ~/git/dotfiles/vim/mysnippets ~/.janus/mysnippets

5. Install plugins in to `~/.janus`:

        Dockerfile.vim
        bclose.vim
        vim-airline
        vim-expand-region
        vim-git
        vim-go
        vim-ragtag
        vim-sensible
        vim-terraform
        vim_cf3
