return {
  "folke/snacks.nvim",
  opts = {
    indent = { enabled = false },
    scroll = { enabled = false },
    terminal = {
      win = {
        position = "float",
        width = 0.8,
        height = 0.8,
        border = "rounded",
        backdrop = 60,
        relative = "editor",
        zindex = 50,
      },
    },
  },
}
