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

if [ -e $HOME/.segment ] ; then
  ln -s $HOME/dev/src/github.com/tysonmote/dotfiles/git/gitignore $HOME/.gitignore
  ln -s $HOME/dev/src/github.com/tysonmote/dotfiles/git/gitconfig.segment $HOME/.gitconfig
else
  ln -s $HOME/git/dotfiles/git/gitignore $HOME/.gitignore
  ln -s $HOME/git/dotfiles/git/gitconfig $HOME/.gitconfig
fi

banner "Installing oh-my-zsh"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

banner "Linking zsh config"

ln -s $HOME/git/dotfiles/zsh/zshrc $HOME/.zshrc
ln -s $HOME/git/dotfiles/zsh/zshenv $HOME/.zshenv

banner "Installing Go"

if [ -e $HOME/.segment ] ; then
  mkdir $HOME/dev
else
  mkdir $HOME/go
fi
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

curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

mkdir -p $HOME/.config/nvim/
ln -s $HOME/git/dotfiles/vim/init.vim $HOME/.config/nvim/
ln -s $HOME/git/dotfiles/vim/snippets $HOME/.config/nvim/
nvim +PlugInstall +qall
nvim +GoUpdateBinaries +qall

banner "Installing extras"

brew install awscli cscope ctags jq parallel pcre postgresql redis sqlite the_silver_searcher fzf fd bat htop diff-so-fancy tldr

