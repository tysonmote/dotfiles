---@type LazySpec
return {
  {
    "akinsho/toggleterm.nvim",
    opts = function(_, opts)
      opts.direction = "float"
      opts.float_opts = vim.tbl_deep_extend("force", opts.float_opts or {}, {
        width = function() return math.floor(vim.o.columns * 0.9) end,
        height = function() return math.floor(vim.o.lines * 0.85) end,
      })
    end,
  },
}
