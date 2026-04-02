-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("markdown_show_urls", { clear = true }),
  pattern = { "markdown", "markdown.mdx" },
  callback = function()
    vim.opt_local.conceallevel = 0
    -- LazyVim's global formatexpr uses Conform/Prettier; that path is not Vim-style paragraph
    -- reflow. Clear it so gq/gqq use the built-in formatter with markdown ftplugin rules
    -- (lists, blockquotes, formatlistpat).
    vim.opt_local.formatexpr = ""
    vim.opt_local.textwidth = 80
  end,
})

-- With `list`, trail in 'listchars' draws a character on trailing spaces (e.g. "-"), which is noisy while typing.
local hide_trail_in_insert = vim.api.nvim_create_augroup("hide_trail_listchars_insert", { clear = true })

vim.api.nvim_create_autocmd({ "InsertEnter" }, {
  group = hide_trail_in_insert,
  callback = function()
    if vim.w.listchars_full == nil then
      vim.w.listchars_full = vim.opt_local.listchars:get()
    end
    local lc = vim.deepcopy(vim.w.listchars_full)
    lc.trail = nil
    vim.opt_local.listchars = lc
  end,
})

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  group = hide_trail_in_insert,
  callback = function()
    local full = vim.w.listchars_full
    if full then
      vim.opt_local.listchars = full
    end
  end,
})
