-- Quck lang plugins. maybe refactor later
return {
  { "tpope/vim-eunuch", event = { "BufReadPost", "BufNewFile" } }, -- First class unix commands
  { "direnv/direnv.vim", event = "VeryLazy" },

  { "arouene/vim-ansible-vault", ft = "yaml" },
  { "LokiChaos/vim-tintin", event = "BufReadPre *.tin" },
  { "dougireton/vim-chef", ft = "ruby" },

  {
    "aserowy/tmux.nvim",
    event = "VeryLazy",
    opts = {
      copy_sync = {
        enable = false,
      },
    },
  },

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
