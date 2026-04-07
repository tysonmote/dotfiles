-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "U", "<cmd>redo<cr>", { desc = "Redo" })

for _, lhs in ipairs({ "<C-h>", "<C-j>", "<C-k>", "<C-l>" }) do
  pcall(vim.keymap.del, "n", lhs)
end
vim.keymap.set("n", "<M-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
vim.keymap.set("n", "<M-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
vim.keymap.set("n", "<M-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
vim.keymap.set("n", "<M-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

vim.keymap.set("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })

vim.keymap.set("x", "r", '"_dP', { desc = "Replace selection without yanking" })

vim.keymap.set({ "n", "i", "t" }, "<C-'>", function()
  Snacks.terminal(nil, { cwd = LazyVim.root(), win = { position = "float" } })
end, { desc = "Toggle Floating Terminal (Root Dir)" })
