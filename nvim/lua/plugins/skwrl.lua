-- Quck lang plugins. maybe refactor later
return {
  "danihodovic/vim-ansible-vault",
  "LokiChaos/vim-tintin",
  "dougireton/vim-chef",
  "rizzatti/dash.vim",

  "tpope/vim-eunuch", -- First class unix commands

  "direnv/direnv.vim",

  "junegunn/vim-easy-align",

  "christoomey/vim-tmux-navigator",
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },

  -- the gits
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
}
