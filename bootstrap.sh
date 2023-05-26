#!/bin/bash

set -e

DOTFILES=$HOME/dev/src/github.com/tysonmote/dotfiles

function banner() {
  echo "***"
  echo "*** $1"
  echo "***"
}

banner "Installing some basics"

xcode-select --install
sudo /usr/sbin/DevToolsSecurity -enable
sudo dscl . append /Groups/_developer GroupMembership $(whoami)

brew install git lua openssl python

banner "Linking git config"

ln -s $DOTFILES/git/gitignore $HOME/.gitignore
ln -s $DOTFILES/git/gitconfig $HOME/.gitconfig

banner "Installing oh-my-zsh"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

banner "Linking zsh config"

ln -s $DOTFILES/zsh/zshrc $HOME/.zshrc
ln -s $DOTFILES/zsh/zshenv $HOME/.zshenv
ln -s $DOTFILES/zsh/tyson.zsh-theme $HOME/.oh-my-zsh/themes/

banner "Installing Go"

brew install go delve

banner "Installing Node.js"

brew install n
n latest

banner "Configuring NeoVim / LunarVim"

brew install neovim
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
ln -s $DOTFILES/lvim $HOME/.config/lvim

banner "Installing extras"

brew install awscli cscope ctags jq parallel pcre sqlite the_silver_searcher fzf fd bat htop diff-so-fancy tldr wget

$(brew --prefix)/opt/fzf/install

banner "Linking configs"

ln -s $DOTFILEs/vale/.vale.ini $HOME/.vale.ini
