return {
  {
    "folke/snacks.nvim",
    opts = {
      indent = { enabled = false },
      statuscolumn = { right = { "git" } },
      picker = {
        sources = {
          explorer = {
            jump = { close = true },
          },
        },
      },
    },
  },
}
