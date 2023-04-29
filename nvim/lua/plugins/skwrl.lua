-- Quck lang plugins. maybe refactor later
return {
  { "tpope/vim-eunuch", event = { "BufReadPost", "BufNewFile" } }, -- First class unix commands
  { "direnv/direnv.vim", event = "VeryLazy" },

  { "arouene/vim-ansible-vault", ft = "yaml" },
  { "LokiChaos/vim-tintin", event = "BufReadPre *.tin" },
  { "dougireton/vim-chef", ft = "ruby" },

  {
    "alexghergh/nvim-tmux-navigation",
    keys = {
      { "<C-h>", "<cmd>lua require('nvim-tmux-navigation').NvimTmuxNavigateLeft()<cr>", desc = "Go to left window" },
      { "<C-j>", "<cmd>lua require('nvim-tmux-navigation').NvimTmuxNavigateDown()<cr>", desc = "Go to lower window" },
      { "<C-k>", "<cmd>lua require('nvim-tmux-navigation').NvimTmuxNavigateUp()<cr>", desc = "Go to upper window" },
      { "<C-l>", "<cmd>lua require('nvim-tmux-navigation').NvimTmuxNavigateRight()<cr>", desc = "Go to right window" },
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
