#!/usr/bin/env bash

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

banner() {
  echo "***"
  echo "*** $1"
  echo "***"
}

have() {
  command -v "$1" >/dev/null 2>&1
}

link_path() {
  local source_path="$1"
  local target_path="$2"
  mkdir -p "$(dirname "$target_path")"
  ln -sfn "$source_path" "$target_path"
}

ensure_xcode_clt() {
  banner "Installing Xcode Command Line Tools"
  if xcode-select -p >/dev/null 2>&1; then
    echo "Xcode Command Line Tools already installed."
    return
  fi
  xcode-select --install || true
  echo "Complete the Xcode Command Line Tools UI installer, then rerun this script."
  exit 1
}

ensure_homebrew() {
  banner "Ensuring Homebrew is installed"
  if have brew; then
    echo "Homebrew already installed."
  else
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  else
    echo "Homebrew install completed but brew was not found on PATH."
    exit 1
  fi
}

install_formulae() {
  local formulae=("$@")
  local missing=()
  local f
  for f in "${formulae[@]}"; do
    if ! brew list --formula "$f" >/dev/null 2>&1; then
      missing+=("$f")
    fi
  done
  if [ "${#missing[@]}" -gt 0 ]; then
    brew install "${missing[@]}"
  fi
}

install_casks() {
  local casks=("$@")
  local missing=()
  local c
  for c in "${casks[@]}"; do
    if ! brew list --cask "$c" >/dev/null 2>&1; then
      missing+=("$c")
    fi
  done
  if [ "${#missing[@]}" -gt 0 ]; then
    brew install --cask "${missing[@]}"
  fi
}

ensure_oh_my_zsh() {
  banner "Installing oh-my-zsh"
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  else
    echo "oh-my-zsh already installed."
  fi
}

ensure_powerlevel10k() {
  local p10k_dir="$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
  if [ ! -d "$p10k_dir" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$p10k_dir"
  else
    echo "powerlevel10k already installed."
  fi
}

configure_fzf() {
  local fzf_install
  fzf_install="$(brew --prefix)/opt/fzf/install"
  if [ -x "$fzf_install" ]; then
    "$fzf_install" --all --no-bash --no-fish
  fi
}

ensure_xcode_clt
ensure_homebrew

banner "Installing base packages"
install_formulae git lua openssl python neovim go delve

banner "Installing extras"
install_formulae awscli bat btop ca-certificates cscope ctags diff-so-fancy fd fzf gh gnupg htop jq lazygit parallel pcre2 sqlite tree-sitter wget zellij direnv ripgrep
install_casks ghostty
configure_fzf

ensure_oh_my_zsh
banner "Installing powerlevel10k theme"
ensure_powerlevel10k

banner "Linking git config"
link_path "$DOTFILES/git/gitignore" "$HOME/.gitignore"
link_path "$DOTFILES/git/gitconfig" "$HOME/.gitconfig"

banner "Linking zsh config"
link_path "$DOTFILES/zsh/zshrc" "$HOME/.zshrc"
link_path "$DOTFILES/zsh/zshenv" "$HOME/.zshenv"

banner "Linking app configs"
link_path "$DOTFILES/ghostty" "$HOME/.config/ghostty"
link_path "$DOTFILES/nvim" "$HOME/.config/nvim"
link_path "$DOTFILES/zellij" "$HOME/.config/zellij"

echo "Bootstrap complete."
