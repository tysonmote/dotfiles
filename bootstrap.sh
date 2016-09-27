#!/bin/bash

set -e

function banner() {
  echo "***"
  echo "*** $1"
  echo "***"
}

banner "Linking git config"

ln -s ~/git/dotfiles/git/gitignore ~/.gitignore
ln -s ~/git/dotfiles/git/gitconfig ~/.gitconfig

banner "Installing oh-my-zsh"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

banner "Linking zsh config"

ln -s ~/git/dotfiles/zsh/zshrc ~/.zshrc
ln -s ~/git/dotfiles/zsh/zshenv ~/.zshenv
ln -s ~/git/dotfiles/zsh/tyson.zsh-theme ~/.oh-my-zsh/themes/tyson.zsh-theme

banner "Installing Go"

mkdir ~/go
brew install go

baner "Installing Ruby"

brew install rbenv ruby-build
rbenv install 2.3.1
rbenv global 2.3.1

banner "Installing MacVim"

brew install macvim --override-system-vim
brew linkapps macvim

banner "Installing Janus"

curl -L https://bit.ly/janus-bootstrap | bash

banner "Configuring Vim"

ln -s ~/git/dotfiles/vim/vimrc.before ~/.vimrc.before
ln -s ~/git/dotfiles/vim/vimrc.after ~/.vimrc.after
ln -s ~/git/dotfiles/vim/gvimrc.after ~/.gvimrc.after
mkdir -p ~/.janus
ln -s ~/git/dotfiles/vim/mysnippets ~/.janus/mysnippets
ln -s ~/git/dotfiles/vim/update_all.sh ~/.janus/update_all.sh
ln -s ~/git/dotfiles/vim/fetch_all_plugins.sh ~/.janus/fetch_all_plugins.sh

