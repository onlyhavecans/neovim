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
  { "williamboman/mason.nvim", enabled = false }, -- Not compatible with Nix
  { "williamboman/mason-lspconfig.nvim", enabled = false }, -- Not compatible with Nix
}
