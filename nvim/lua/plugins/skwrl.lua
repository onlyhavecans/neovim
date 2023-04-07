-- Quck lang plugins. maybe refactor later
return {
  { "christoomey/vim-tmux-navigator" },

  { "jremmen/vim-ripgrep", cmd = "Rg" },

  { "tpope/vim-eunuch", event = { "BufReadPost", "BufNewFile" } }, -- First class unix commands
  { "direnv/direnv.vim" },

  { "danihodovic/vim-ansible-vault", ft = "yaml.ansible" },
  { "LokiChaos/vim-tintin", event = "BufRead *.tin" },
  { "dougireton/vim-chef", ft = "ruby" },

  {
    "junegunn/vim-easy-align",
    lazy = true,
    keys = {
      { "<Enter>", "<Plug>(EasyAlign)", { remap = true, desc = "EasyAlign", mode = "v" } },
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
