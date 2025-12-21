-- Ansible language support

return {
  -- Ansible YAML support
  {
    "mfussenegger/nvim-ansible",
    ft = "yaml.ansible",
  },

  -- Ansible vault support (inline encryption)
  {
    "arouene/vim-ansible-vault",
    ft = "yaml.ansible",
    keys = {
      { "<leader>ad", "<cmd>AnsibleDecryptFile<cr>", ft = "yaml.ansible", desc = "Decrypt Ansible Vault" },
      { "<leader>ae", "<cmd>AnsibleEncryptFile<cr>", ft = "yaml.ansible", desc = "Encrypt Ansible Vault" },
    },
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
