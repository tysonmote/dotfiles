lvim.plugins = {
  { "arcticicestudio/nord-vim" },
  { "github/copilot.vim" },
  { "ruanyl/vim-gh-line" },
}

-- basics
lvim.leader = "space"
lvim.log.level = "warn"
lvim.format_on_save = true
vim.opt.cmdheight = 1
lvim.colorscheme = "nord"

-- move between windows
vim.api.nvim_set_keymap("n", "<M-h>", "<C-w>h", {})
vim.api.nvim_set_keymap("n", "<M-j>", "<C-w>j", {})
vim.api.nvim_set_keymap("n", "<M-k>", "<C-w>k", {})
vim.api.nvim_set_keymap("n", "<M-l>", "<C-w>l", {})

-- don't yank to system clipboard
vim.opt.clipboard = ""

-- redo
vim.api.nvim_set_keymap("n", "U", "<C-r>", {})

-- join lines
lvim.keys.visual_mode["J"] = false -- default to join lines

-- language servers
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {})
vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', {})
vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', {})
vim.api.nvim_set_keymap('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', {})
vim.api.nvim_set_keymap('n', '<space>r', '<cmd>lua vim.lsp.buf.rename()<CR>', {})
vim.api.nvim_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', {})
vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', {})

require('lspconfig').gopls.setup({
  settings = {
    gopls = {
      gofumpt = true
    }
  }
})

function OrgImports(wait_ms)
  local params = vim.lsp.util.make_range_params(nil, nil)
  params.context = { only = { "source.organizeImports" } }
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
lvim.autocommands.custom_groups = {
  -- Add missing imports on write
  { "BufWritePre", "*.go", "lua OrgImports(2000)" },
}

local cmp = require('cmp')
cmp.setup({
  completion = {
    -- Don't show completion menu automatically (only on <C-space>)
    autocomplete = false
  },
})

-- Display as much of path as possible
lvim.builtin.telescope.defaults.path_display = { "truncate" }

-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = false
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 1

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.disable = true

local components                                 = require "lvim.core.lualine.components"
lvim.builtin.lualine.style                       = 'default'
lvim.builtin.lualine.icons_enabled               = lvim.use_icons
lvim.builtin.lualine.extensions                  = { "nvim-tree" }
lvim.builtin.lualine.disabled_filetypes          = { "alpha", "NvimTree", "Outline" }
lvim.builtin.lualine.sections.lualine_a          = {}
lvim.builtin.lualine.sections.lualine_b          = { { 'filename', color = { gui = 'bold' }, cond = nil, path = 1 } }
lvim.builtin.lualine.sections.lualine_c          = { components.diff }
lvim.builtin.lualine.sections.lualine_x          = { components.diagnostics, components.filetype }
lvim.builtin.lualine.sections.lualine_y          = {}
lvim.builtin.lualine.sections.lualine_z          = { components.lsp }
lvim.builtin.lualine.inactive_sections.lualine_a = {}
lvim.builtin.lualine.inactive_sections.lualine_b = { { 'filename', color = {}, cond = nil, path = 1 } }
lvim.builtin.lualine.inactive_sections.lualine_c = {}
lvim.builtin.lualine.inactive_sections.lualine_x = {}
lvim.builtin.lualine.inactive_sections.lualine_y = {}
lvim.builtin.lualine.inactive_sections.lualine_z = {}


-- Make copilot and cmp play nice
vim.g["copilot_no_tab_map"] = true
vim.api.nvim_set_keymap('i', '<Plug>(vimrc:copilot-dummy-map)', 'copilot#Accept("<Tab>")', { expr = true })
cmp.setup {
  mapping = {
    ['<Tab>'] = cmp.mapping(function(fallback)
      vim.api.nvim_feedkeys(vim.fn['copilot#Accept'](vim.api.nvim_replace_termcodes('<Tab>', true, true, true)), 'n', true)
    end)
  },
  experimental = {
    ghost_text = false -- this feature conflict with copilot.vim's preview.
  }
}

-- imap <expr> <Plug>(vimrc:copilot-dummy-map) copilot#Accept("\<Tab>")


-- generic LSP settings

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skiipped for the current filetype
-- vim.tbl_map(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
lvim.lsp.on_attach_callback = function(client, bufnr)
  --Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "goimports", filetypes = { "go" } },

--   --   { command = "black", filetypes = { "python" } },
--   --   { command = "isort", filetypes = { "python" } },
--   --   {
--   --     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--   --     command = "prettier",
--   --     ---@usage arguments to pass to the formatter
--   --     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--   --     extra_args = { "--print-with", "100" },
--   --     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--   --     filetypes = { "typescript", "typescriptreact" },
--   --   },
-- }

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }
