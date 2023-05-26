local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  {
    name = "vale",
    filetypes = { "markdown", "text" }
  },
}

