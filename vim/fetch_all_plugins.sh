#!/bin/bash

repos="
https://github.com/bling/vim-airline
https://github.com/gabesoft/vim-ags.git
https://github.com/godlygeek/tabular.git
https://github.com/junegunn/fzf.vim.git
https://github.com/rbgrouleff/bclose.vim.git
https://github.com/reedes/vim-pencil.git
https://github.com/reedes/vim-wordy.git
https://github.com/terryma/vim-expand-region.git
https://github.com/tpope/vim-git.git
https://github.com/tpope/vim-ragtag
https://github.com/tpope/vim-sensible.git
https://github.com/vim-airline/vim-airline-themes.git
"

for repo in $repos ; do
  git clone $repo
done
