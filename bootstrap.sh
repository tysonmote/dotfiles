#!/bin/bash

set -e

function banner() {
  echo "***"
  echo "*** $1"
  echo "***"
}

banner "Installing basics"

brew install git lua mercurial openssl python python3 subversion

banner "Linking git config"

ln -s ~/git/dotfiles/git/gitignore ~/.gitignore
ln -s ~/git/dotfiles/git/gitconfig ~/.gitconfig

banner "Installing oh-my-zsh"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

banner "Linking zsh config"

ln -s ~/git/dotfiles/zsh/zshrc ~/.zshrc
ln -s ~/git/dotfiles/zsh/zshenv ~/.zshenv

banner "Installing Go"

mkdir ~/go
brew install go

banner "Installing Ruby"

brew install rbenv ruby-build
rbenv install 2.6.3
rbenv global 2.6.3

banner "Installing Node.js"

brew install n
n 12.3.1
npm -g install typescript

banner "Installing NeoVim"

brew install neovim
pip3 install neovim
npm install -g neovim

banner "Configuring NeoVim"

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

mkdir -p ~/.config/nvim/
ln -s ~/git/dotfiles/vim/init.vim ~/.config/nvim/
ln -s ~/git/dotfiles/vim/snippets ~/.config/nvim/

banner "Installing extras"

brew install awscli cscope ctags jq parallel pcre postgresql redis sqlite the_silver_searcher fzf fd bat htop diff-so-fancy tldr

banner "Configuring fzf"

$(brew --prefix)/opt/fzf/install
