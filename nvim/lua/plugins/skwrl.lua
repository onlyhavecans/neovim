-- Quck lang plugins. maybe refactor later
return {
  -- Make tmux and nvim smooth and native navigation
  {
    "alexghergh/nvim-tmux-navigation",
    opts = { disable_when_zoomed = true },
    keys = {
      { "<C-h>", "<cmd>lua require('nvim-tmux-navigation').NvimTmuxNavigateLeft()<cr>", desc = "Go to left window" },
      { "<C-j>", "<cmd>lua require('nvim-tmux-navigation').NvimTmuxNavigateDown()<cr>", desc = "Go to lower window" },
      { "<C-k>", "<cmd>lua require('nvim-tmux-navigation').NvimTmuxNavigateUp()<cr>", desc = "Go to upper window" },
      { "<C-l>", "<cmd>lua require('nvim-tmux-navigation').NvimTmuxNavigateRight()<cr>", desc = "Go to right window" },
    },
  },

  {
    "junegunn/vim-easy-align",
    keys = {
      { "ga", "<Plug>(EasyAlign)", desc = "EasyAlign", mode = { "x", "n" } },
    },
  },

  --
  -- Langs
  --
  { "LokiChaos/vim-tintin", event = "BufReadPre *.tin" },
  { "dougireton/vim-chef", ft = "ruby" },
  { "mfussenegger/nvim-ansible", ft = "yaml.ansible" },
  -- Ansible-vault support
  {
    "arouene/vim-ansible-vault", -- this only handles inline
    ft = "yaml.ansible",
    init = function()
      -- Set manual Ansible whole file commands
      vim.api.nvim_create_user_command(
        "AnsibleDecryptFile",
        "!ansible-vault decrypt %",
        { bang = true, desc = "Decrypt Ansible Vault" }
      )

      vim.api.nvim_create_user_command(
        "AnsibleEncryptFile",
        "!ansible-vault encrypt <args> %",
        { bang = true, nargs = "?", desc = "Encrypt Ansible Vault" }
      )
    end,
  },
}
