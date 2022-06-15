lvim.plugins = {
  { "arcticicestudio/nord-vim" },
  { "github/copilot.vim" },
  { "ruanyl/vim-gh-line" },
  { "tpope/vim-surround" },
  { "kyoh86/vim-go-coverage" },
  { "hashivim/vim-terraform" },
  { "akinsho/toggleterm.nvim" },
}

-- basics
lvim.leader = "space"
lvim.log.level = "warn"
lvim.format_on_save = true
vim.opt.cmdheight = 1
lvim.colorscheme = "nord"
vim.opt.clipboard = "" -- don't yank to system clipboard

-- move between windows
lvim.keys.normal_mode["<M-h>"] = "<C-w>h"
lvim.keys.normal_mode["<M-j>"] = "<C-w>j"
lvim.keys.normal_mode["<M-k>"] = "<C-w>k"
lvim.keys.normal_mode["<M-l>"] = "<C-w>l"

lvim.keys.normal_mode["U"] = "<C-r>" -- redo

lvim.keys.visual_mode["J"] = false -- default to join lines

-- Yank-free pasting/deleting
lvim.keys.visual_mode["r"] = "\"_dP`]"
lvim.keys.visual_mode["D"] = "\"_d`]"

-- Move cursor to end of pasted text
lvim.keys.visual_mode["p"] = "p`]"
lvim.keys.visual_mode["P"] = "P`]"
lvim.keys.normal_mode["p"] = "p`]"
lvim.keys.normal_mode["P"] = "P`]"

-- language servers
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {})
vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', {})
vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', {})
vim.api.nvim_set_keymap('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', {})
vim.api.nvim_set_keymap('n', '<space>r', '<cmd>lua vim.lsp.buf.rename()<CR>', {})
vim.api.nvim_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', {})
vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', {})

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

-- Add missing imports on write
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.go" },
  callback = function() OrgImports(3000) end
})

-- Make copilot and cmp play nice
vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap('i', '<Plug>(vimrc:copilot-dummy-map)', 'copilot#Accept("<Tab>")', { expr = true })
vim.api.nvim_set_keymap('i', '<C-g>', '<Esc>:Copilot<cr>', {})

-- Display as much of path as possible
lvim.builtin.telescope.defaults.path_display = { "truncate" }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.terminal.active = true
lvim.builtin.treesitter.highlight.disable = true
lvim.builtin.treesitter.ignore_install = { "haskell" }

local cmp = require('cmp')
lvim.builtin.cmp.completion.autocomplete = false -- Show on <C-space> only
lvim.builtin.cmp.experimental.ghost_text = false -- Don't conflict with Copilot
lvim.builtin.cmp.mapping['<Tab>'] = cmp.mapping(function(fallback)
  vim.api.nvim_feedkeys(vim.fn['copilot#Accept'](vim.api.nvim_replace_termcodes('<Tab>', true, true, true)), 'n', true)
end)

lvim.builtin.cmp.formatting.kind_icons.Constant = 'const'
lvim.builtin.cmp.formatting.kind_icons.Enum = 'enum'
lvim.builtin.cmp.formatting.kind_icons.Field = '.'
lvim.builtin.cmp.formatting.kind_icons.Function = '()'
lvim.builtin.cmp.formatting.kind_icons.Interface = '{}'
lvim.builtin.cmp.formatting.kind_icons.Module = 'pkg'
lvim.builtin.cmp.formatting.kind_icons.Keyword = ' '
lvim.builtin.cmp.formatting.kind_icons.Method = '()'
lvim.builtin.cmp.formatting.kind_icons.Variable = 'var'
lvim.builtin.cmp.formatting.kind_icons.Struct = 'struct'
lvim.builtin.cmp.formatting.kind_icons.TypeParameter = 'TYPE' -- TODO
lvim.builtin.cmp.formatting.kind_icons.Unit = 'UNIT' -- TODO

lvim.builtin.cmp.formatting.source_names.buffer = ''
lvim.builtin.cmp.formatting.source_names.luasnip = ' '
lvim.builtin.cmp.formatting.source_names.nvim_lsp = ''
lvim.builtin.cmp.formatting.source_names.vsnip = ' '

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
lvim.builtin.lualine.sections.lualine_z          = { 'location' }
lvim.builtin.lualine.inactive_sections.lualine_a = {}
lvim.builtin.lualine.inactive_sections.lualine_b = { { 'filename', color = {}, cond = nil, path = 1 } }
lvim.builtin.lualine.inactive_sections.lualine_c = {}
lvim.builtin.lualine.inactive_sections.lualine_x = {}
lvim.builtin.lualine.inactive_sections.lualine_y = {}
lvim.builtin.lualine.inactive_sections.lualine_z = {}

require('lspconfig').gopls.setup({
  settings = {
    gopls = {
      gofumpt = true
    }
  }
})
