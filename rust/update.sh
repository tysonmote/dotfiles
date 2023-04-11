#!/bin/bash -eux

which rustup || {
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

rustup update

# Update zsh completions
mkdir -p ~/.zfunc
rustup completions zsh > ~/.zfunc/_rustup

