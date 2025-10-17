return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim", priority = 1000, config = true },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },

  -- disable pairs
  { "nvim-mini/mini.pairs", enabled=false},
}
