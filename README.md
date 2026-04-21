# dotfiles

This repo contains some of the common programs and configurations I use when bootstrapping a new machine.

## Basics

1. Clone this repo:
   `mkdir -p ~/dev/src/github.com/tysonmote && cd "$_" && git clone https://github.com/tysonmote/dotfiles.git`

2. Run bootstrap:
   `cd dotfiles && ./bootstrap.sh`

3. Optional: install [Berkeley Mono](https://berkeleygraphics.com/typefaces/berkeley-mono/).

## What bootstrap does

- Installs Xcode Command Line Tools if needed (prompts via macOS UI).
- Installs Homebrew if missing.
- Installs common CLI tools and apps (including `nvim`, `gh`, `fzf`, `zellij`, `ghostty`).
- Installs Oh My Zsh and the `powerlevel10k` theme if missing.
- Creates symlinks for managed config files and directories:
  - `~/.gitconfig`, `~/.gitignore`
  - `~/.zshrc`, `~/.zshenv`
  - `~/.config/nvim`, `~/.config/ghostty`, `~/.config/zellij`

The script is intended to be idempotent and safe to rerun.

## Post-bootstrap checks

Open a new terminal, then verify key tools and config links:

- `echo $SHELL`
- `brew --version`
- `nvim --version`
- `gh --version`
- `zellij --version`
- `test -L ~/.zshrc && ls -l ~/.zshrc`
- `test -L ~/.config/nvim && ls -l ~/.config/nvim`

Optional auth/setup checks:

- `gh auth status`
- `gpg --list-secret-keys --keyid-format=long`
