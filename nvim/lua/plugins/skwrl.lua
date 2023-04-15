-- Quck lang plugins. maybe refactor later
return {
  { "christoomey/vim-tmux-navigator" },

  { "tpope/vim-eunuch", event = { "BufReadPost", "BufNewFile" } }, -- First class unix commands
  { "direnv/direnv.vim" },

  { "danihodovic/vim-ansible-vault", ft = "yaml.ansible" },
  { "LokiChaos/vim-tintin", event = "BufReadPre *.tin" },
  { "dougireton/vim-chef", ft = "ruby" },

  {
    "junegunn/vim-easy-align",
    lazy = true,
    keys = {
      { "ga", "<Plug>(EasyAlign)", desc = "EasyAlign", mode = { "x", "n" } },
    },
  },

  {
    "rizzatti/dash.vim",
    lazy = true,
    keys = {
      { "<Leader>d", "<cmd>Dash<CR>", desc = "Search in Dash" },
    },
  },
}
