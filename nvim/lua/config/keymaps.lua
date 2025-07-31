-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Toggle terminal with Ctrl-T
vim.keymap.set({ "n", "t" }, "<C-t>", function()
  require("snacks.terminal").toggle()
end, { desc = "Toggle Terminal" })

-- Window navigation with Alt+hjkl
vim.keymap.set("n", "<M-h>", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<M-j>", "<C-w>j", { desc = "Go to lower window" })
vim.keymap.set("n", "<M-k>", "<C-w>k", { desc = "Go to upper window" })
vim.keymap.set("n", "<M-l>", "<C-w>l", { desc = "Go to right window" })

-- Set 'u' for undo (default) and 'U' for redo
vim.keymap.set("n", "u", "u", { desc = "Undo" })
vim.keymap.set("n", "U", "<C-r>", { desc = "Redo" })

-- Buffer navigation with Tab and Shift-Tab, close with leader-c
vim.keymap.set("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>c", "<cmd>bdelete<cr>", { desc = "Close buffer" })
