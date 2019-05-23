#!/bin/bash -eux

which rustup || {
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

rustup update
rustup component add rustfmt
rustup component add rls rust-analysis rust-src

cargo +nightly install racer

# Update zsh completions
mkdir -p ~/.zfunc
rustup completions zsh > ~/.zfunc/_rustup

