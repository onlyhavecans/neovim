return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },

  -- Disabled Defaults
  { "folke/noice.nvim", enabled = false }, -- Noice popups are a no for me

  -- I like project management
  { import = "lazyvim.plugins.extras.util.project" },
}
