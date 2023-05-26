local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    name = "prettierd",
    filetypes = { "markdown" }
  },
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  {
    name = "vale",
    filetypes = { "markdown", "text" }
  },
}
