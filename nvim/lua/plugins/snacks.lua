return {
  {
    "folke/snacks.nvim",
    opts = {
      indent = { enabled = false },
      words = { enabled = false },
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
