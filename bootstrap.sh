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
ln -s ~/git/dotfiles/zsh/tyson.zsh-theme ~/.oh-my-zsh/themes/tyson.zsh-theme

banner "Installing Go"

mkdir ~/go
brew install go

baner "Installing Ruby"

brew install rbenv ruby-build
rbenv install 2.4.1
rbenv global 2.4.1

banner "Installing NeoVim"

brew install neovim

banner "Configuring NeoVim"

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

mkdir -p ~/.config/nvim/
ln -s ~/git/dotfiles/vim/init.vim ~/.config/nvim/
ln -s ~/git/dotfiles/vim/snippets ~/.config/nvim/

banner "Installing extras"

brew install awscli cscope ctags jq parallel pcre postgresql redis sqlite the_silver_searcher fzf

banner "Configuring fzf"

$(brew --prefix)/opt/fzf/install
