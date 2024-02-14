return {
  -- I used to specify parsers manually
  -- But why not just automatically install on use?
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      auto_install = true,
    },
  },
}
