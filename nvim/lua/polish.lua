-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Navigate between splits using Option-HJKL (Alt/Option key on Mac)
-- instead of Control-HJKL
vim.keymap.set("n", "<M-h>", "<C-w>h", { desc = "Navigate to left split" })
vim.keymap.set("n", "<M-j>", "<C-w>j", { desc = "Navigate to bottom split" })
vim.keymap.set("n", "<M-k>", "<C-w>k", { desc = "Navigate to top split" })
vim.keymap.set("n", "<M-l>", "<C-w>l", { desc = "Navigate to right split" })

-- Also work in terminal mode
vim.keymap.set("t", "<M-h>", [[<C-\><C-n><C-w>h]], { desc = "Navigate to left split" })
vim.keymap.set("t", "<M-j>", [[<C-\><C-n><C-w>j]], { desc = "Navigate to bottom split" })
vim.keymap.set("t", "<M-k>", [[<C-\><C-n><C-w>k]], { desc = "Navigate to top split" })
vim.keymap.set("t", "<M-l>", [[<C-\><C-n><C-w>l]], { desc = "Navigate to right split" })

-- Also work in insert mode
vim.keymap.set("i", "<M-h>", "<Esc><C-w>h", { desc = "Navigate to left split" })
vim.keymap.set("i", "<M-j>", "<Esc><C-w>j", { desc = "Navigate to bottom split" })
vim.keymap.set("i", "<M-k>", "<Esc><C-w>k", { desc = "Navigate to top split" })
vim.keymap.set("i", "<M-l>", "<Esc><C-w>l", { desc = "Navigate to right split" })
