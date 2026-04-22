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

-- Toggle the floating terminal. When invoked from inside a terminal buffer we
-- close the window instead of calling Snacks.terminal() again: Snacks keys
-- terminals by cwd, and `cd`-ing inside the shell triggers an OSC 7 update
-- that renames the term:// buffer, which would make LazyVim.root() resolve a
-- different path and spawn a brand-new terminal.
vim.keymap.set({ "n", "i", "t" }, "<C-'>", function()
  if vim.bo.buftype == "terminal" then
    vim.cmd.close()
    return
  end
  Snacks.terminal(nil, { cwd = LazyVim.root(), win = { position = "float" } })
end, { desc = "Toggle Floating Terminal (Root Dir)" })
