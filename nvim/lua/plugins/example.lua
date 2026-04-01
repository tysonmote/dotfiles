return {
  -- If you enable LazyVim `lang.markdown` (render-markdown.nvim), keep link URLs visible while rendered.
  {
    "MeanderingProgrammer/render-markdown.nvim",
    optional = true,
    opts = {
      win_options = {
        conceallevel = {
          rendered = 0,
        },
      },
    },
  },

  {
    "folke/snacks.nvim",
    opts = {
      indent = { enabled = false },
      statuscolumn = { right = { "git" } },
      picker = {
        sources = {
          explorer = {
            -- Close the explorer when opening a file (LazyVim default keeps it open)
            jump = { close = true },
          },
        },
      },
    },
  },

  {
    "zenbones-theme/zenbones.nvim",
    -- Optionally install Lush. Allows for more configuration or extending the colorscheme
    -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
    -- In Vim, compat mode is turned on as Lush only works in Neovim.
    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
    -- you can set set configuration options here
    -- config = function()
    --     vim.g.zenbones_darken_comments = 45
    --     vim.cmd.colorscheme('zenbones')
    -- end
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "nordbones",
    },
  },

  { "tpope/vim-surround", event = "VeryLazy" },

  -- change some telescope options and a keymap to browse plugin files
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
    },
    -- change some options
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },

  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      folds = { enable = false },
      ensure_installed = {
        "bash",
        "go",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "query",
        "regex",
        "rust",
        "typescript",
        "vim",
        "yaml",
        "zig",
      },
    },
  },
}
