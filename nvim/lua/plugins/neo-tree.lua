---@type LazySpec
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      {
        "s1n7ax/nvim-window-picker",
        opts = {
          filter_rules = {
            include_current_win = false,
            autoselect_one = true,
            bo = {
              filetype = { "neo-tree", "neo-tree-popup", "notify" },
              buftype = { "terminal", "quickfix" },
            },
          },
          highlights = {
            statusline = {
              focused = { fg = "#ECEFF4", bg = "#5E81AC", bold = true },
              unfocused = { fg = "#D8DEE9", bg = "#4C566A", bold = true },
            },
            winbar = {
              focused = { fg = "#ECEFF4", bg = "#5E81AC", bold = true },
              unfocused = { fg = "#D8DEE9", bg = "#4C566A", bold = true },
            },
          },
        },
      },
    },
    opts = function(_, opts)
      opts.filesystem = opts.filesystem or {}
      opts.filesystem.window = opts.filesystem.window or {}
      opts.filesystem.window.mappings = opts.filesystem.window.mappings or {}
      opts.filesystem.window.mappings["<cr>"] = "open_with_window_picker"

      opts.event_handlers = opts.event_handlers or {}
      table.insert(opts.event_handlers, {
        event = "file_opened",
        handler = function()
          require("neo-tree.command").execute { action = "close" }
        end,
      })
    end,
  },
}
