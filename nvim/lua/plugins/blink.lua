return {
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      -- Replace LazyVim default { "lsp", "path", "snippets", "buffer" }; opts_extend would merge arrays.
      opts.sources.default = { "lsp", "buffer" }

      opts.completion = opts.completion or {}
      -- Delay uses context.timestamp so each keystroke resets the wait (debounced idle).
      opts.completion.menu = vim.tbl_deep_extend("force", opts.completion.menu or {}, {
        auto_show = function(_, items)
          return #items > 0
        end,
        auto_show_delay_ms = 250,
      })

      return opts
    end,
  },
}
