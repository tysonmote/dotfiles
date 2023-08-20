lvim.plugins = {
  { "arcticicestudio/nord-vim" },
  { "github/copilot.vim" },
  { "ruanyl/vim-gh-line" },
  { "tpope/vim-surround" },
  { "kyoh86/vim-go-coverage" },
  { "hashivim/vim-terraform" },
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = "markdown",
    config = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 0
    end,
  },
  {
  "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function()
      require("lsp_signature").on_attach({
        bind = true,
        hint_enable = false,
      })
    end,
  },
  {
    "rmagatti/goto-preview",
    config = function()
      require('goto-preview').setup({
        width = 120; -- Width of the floating window
        height = 25; -- Height of the floating window
        default_mappings = true; -- Bind default mappings
      })
    end
  },
  {
    "romgrk/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup{
        throttle = true,
        patterns = {
          default = {
            'class',
            'function',
            'method',
          },
        },
      }
    end
  },
}

-- todo clean up
lvim.builtin.project.active = false -- don't need 'projects'
lvim.builtin.luasnip.active = false

-- preferred formatting options, w.r.t. comments especially
vim.cmd [[set textwidth=80]]
vim.cmd [[set formatoptions=tcro/qnjp]]
lvim.lsp.buffer_options.formatexpr = "" -- don't use LSP for `gq`
lvim.format_on_save.enabled = true

-- basics
lvim.colorscheme = "nord"
lvim.leader = "space"
vim.opt.cmdheight = 1
vim.opt.clipboard = "" -- don't yank to system clipboard

-- Toggle floating terminal, fixes a regression added in https://github.com/LunarVim/LunarVim/commit/a4c2dc4d0b638a50c3219f247b09e6238a44ec50
lvim.builtin.terminal.open_mapping = [[<c-t>]]

-- Move between windows
lvim.keys.normal_mode["<M-h>"] = "<C-w>h"
lvim.keys.normal_mode["<M-j>"] = "<C-w>j"
lvim.keys.normal_mode["<M-k>"] = "<C-w>k"
lvim.keys.normal_mode["<M-l>"] = "<C-w>l"

-- Move between buffers
lvim.keys.normal_mode["<Tab>"] = "<cmd>bnext<CR>"
lvim.keys.normal_mode["<S-Tab>"] = "<cmd>bprevious<CR>"

-- Redo
lvim.keys.normal_mode["U"] = "<C-r>"

-- Restore join lines command
lvim.keys.visual_mode["J"] = false

-- Yank-free pasting/deleting
lvim.keys.visual_mode["r"] = "\"_dP`]"
lvim.keys.visual_mode["D"] = "\"_d`]"

-- Move cursor to end of pasted text
lvim.keys.visual_mode["p"] = "p`]"
lvim.keys.visual_mode["P"] = "P`]"
lvim.keys.normal_mode["p"] = "p`]"
lvim.keys.normal_mode["P"] = "P`]"

-- language servers
vim.api.nvim_set_keymap('n', '<space>r', '<cmd>lua vim.lsp.buf.rename()<CR>', {})
vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', {})
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {})
vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', {})
vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', {})

-- Autocommands (https://neovim.io/doc/user/autocmd.html)

-- Spell check
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text", "gitcommit", "org" },
  command = ":setlocal spell",
})

-- Only show indentation lines for certain filetypes
lvim.builtin.indentlines.options.enabled = false
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "json", "yaml", "toml" },
  command = ":IndentBlanklineEnable",
})

-- Add missing imports on write
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.go" },
  callback = function() OrgImports(3000) end
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

-- Make copilot and cmp play nice
vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap('i', '<Plug>(vimrc:copilot-dummy-map)', 'copilot#Accept("<Tab>")', { expr = true })
vim.api.nvim_set_keymap('i', '<C-g>', '<Esc>:Copilot<cr>', {})

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"

lvim.builtin.nvimtree.setup.actions.open_file.quit_on_open = true
lvim.builtin.nvimtree.setup.renderer.indent_markers.enable = true
lvim.builtin.nvimtree.setup.view.side = "left"

lvim.builtin.treesitter.highlight.disable = true
lvim.builtin.treesitter.ignore_install = { "haskell" }

lvim.builtin.telescope.defaults.layout_strategy = "horizontal"
lvim.builtin.telescope.defaults.layout_config = {
  height = 0.7,
  preview_cutoff = 120,
  prompt_position = "bottom",
  width = 0.7
}
lvim.builtin.telescope.defaults.border = true
lvim.builtin.telescope.defaults.borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
lvim.builtin.telescope.defaults.path_display = { "truncate" }
lvim.builtin.telescope.defaults.dynamic_preview_title = true

local cmp = require('cmp')
lvim.builtin.cmp.completion.autocomplete = false -- Show on <C-space> only
lvim.builtin.cmp.experimental.ghost_text = false -- Don't conflict with Copilot
lvim.builtin.cmp.mapping['<Tab>'] = cmp.mapping(function(fallback)
  vim.api.nvim_feedkeys(vim.fn['copilot#Accept'](vim.api.nvim_replace_termcodes('<Tab>', true, true, true)), 'n', true)
end)

lvim.builtin.cmp.formatting.kind_icons.Class = 'class'
lvim.builtin.cmp.formatting.kind_icons.Constant = 'const'
lvim.builtin.cmp.formatting.kind_icons.Enum = 'enum'
lvim.builtin.cmp.formatting.kind_icons.Field = '.'
lvim.builtin.cmp.formatting.kind_icons.Function = '󰊕()'
lvim.builtin.cmp.formatting.kind_icons.Interface = 'iface'
lvim.builtin.cmp.formatting.kind_icons.Module = ''
lvim.builtin.cmp.formatting.kind_icons.Keyword = ' '
lvim.builtin.cmp.formatting.kind_icons.Method = '󰊕()'
lvim.builtin.cmp.formatting.kind_icons.Variable = 'var'
lvim.builtin.cmp.formatting.kind_icons.Snippet = '...'
lvim.builtin.cmp.formatting.kind_icons.Struct = 'struct'

-- lvim.builtin.cmp.formatting.source_names.buffer = ''
-- lvim.builtin.cmp.formatting.source_names.luasnip = ' '
-- lvim.builtin.cmp.formatting.source_names.nvim_lsp = '󱐋'
-- lvim.builtin.cmp.formatting.source_names.vsnip = ' '

local components                                 = require "lvim.core.lualine.components"
lvim.builtin.lualine.style                       = 'default'
lvim.builtin.lualine.extensions                  = {}
lvim.builtin.lualine.options.disabled_filetypes  = { "alpha", "NvimTree", "Outline" }
lvim.builtin.lualine.options.globalstatus        = false
lvim.builtin.lualine.options.icons_enabled       = true
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

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "terraform-ls" }) --- terraform-ls is hopelessly broken
lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
  return server ~= "java_language_server" and server ~= "golangci_lint_ls" and server ~= "docker_compose_language_service"
end, lvim.lsp.automatic_configuration.skipped_servers)
lvim.lsp.installer.setup.automatic_installation = false

-- use eslint for formatting javascript
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    exe = "eslint_d",
    filetypes = { "javascript", "javascriptreact" },
    args = { "--stdin", "--stdin-filename", "$FILENAME", "--fix-to-stdout" },
    stdin = true,
  },
}
