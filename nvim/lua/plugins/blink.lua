return {
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      -- Replace LazyVim default { "lsp", "path", "snippets", "buffer" }; opts_extend would merge arrays.
      opts.sources.default = { "lsp", "buffer" }

      opts.keymap = opts.keymap or {}
      opts.keymap["<C-space>"] = { "show" }

      opts.completion = opts.completion or {}
      opts.completion.menu = vim.tbl_deep_extend("force", opts.completion.menu or {}, {
        auto_show = false,
      })

      return opts
    end,
  },
}
