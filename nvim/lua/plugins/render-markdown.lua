-- With LazyVim `lang.markdown`, keep link URLs visible while rendered.
return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    optional = true,
    opts = {
      win_options = {
        conceallevel = {
          rendered = 0,
        },
      },
    },
  },
}
