return {
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
