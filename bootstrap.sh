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

brew install /
	awscli /
	bat /
	btop /
  ca-certificates /
	cscope /
	ctags /
	diff-so-fancy /
	fd /
	fzf /
  gh /
  gnupg /
	ghostty /
	htop /
	jq /
  lazygit /
	parallel /
	pcre /
	sqlite /
  tree-sitter /
	wget /
	zellij

$(brew --prefix)/opt/fzf/install

banner "Linking configs"

ln -s $DOTFILES/ghostty $HOME/.config/ghostty
ln -s $DOTFILES/nvim $HOME/.config/nvim
ln -s $DOTFILES/zellij $HOME/.config/zellij
