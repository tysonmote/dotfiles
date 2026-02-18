---@type LazySpec
return {
  {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      opts.options = opts.options or {}
      opts.options.opt = opts.options.opt or {}
      opts.options.opt.ruler = false
      opts.options.opt.showcmd = false
      opts.options.opt.laststatus = 0
      opts.options.opt.foldcolumn = "0"
      opts.options.opt.numberwidth = 2
    end,
  },
}
