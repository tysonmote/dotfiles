-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.clipboard = ""
vim.opt.list = false

-- Never hide syntax characters (markdown `*`, `_`, link brackets, etc.).
vim.opt.conceallevel = 0

vim.opt.foldenable = false
vim.opt.foldcolumn = "0"
vim.opt.foldmethod = "manual"

-- Avoid "N fewer lines" / similar messages (Noice shows them as notifications)
vim.opt.report = 10000
