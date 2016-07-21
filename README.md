# dotfiles

This repo contains some of the common programs and configurations I use
when bootstrapping a new machine.

## Basics

1. Install [Xcode](https://itunes.apple.com/us/app/xcode/id497799835?mt=12)

2. `xcode-select --install`

3. Install [Homebrew](http://brew.sh)

4. `brew install git mercurial lua openssl redis postgres`

5. `mkdir ~/git && cd ~/git && git clone https://github.com/tysontate/dotfiles.git`

6. `cd dotfiles && ./bootstrap.sh`

7. Install [Input Mono](http://input.fontbureau.com)

8. Install vim plugins in to `~/.janus`:

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

## TODO

* Auto-install vim plugins
