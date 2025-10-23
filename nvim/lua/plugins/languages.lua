return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      auto_install = true,
      ensure_installed = {
        "bash",
        "css",
        "diff",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "go",
        "gomod",
        "gosum",
        "gowork",
        "hcl",
        "html",
        "javascript",
        "json",
        "json5",
        "jsonc",
        "just",
        "lua",
        "markdown",
        "markdown_inline",
        "ninja",
        "nix",
        "python",
        "regex",
        "rust",
        "sql",
        "terraform",
        "toml",
        "vim",
        "yaml",
      },
    },
  },


  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        quick_lint_js = {},
        nixd = {},
        tombi = {},
        basedpyright = {},
        ruff = {},
      },
    },
  },

  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        ansible = { "ansible_lint" },
        go = { "golangcilint" },
        nix = { "statix" },
        psql = { "sqlfluff" },
        sh = { "shellcheck" },
        yaml = { "yamllint" },
        zsh = { "zsh" },
      },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        nix = { "nixfmt" },
        ruby = { "rubocop" },
        yaml = { "yamlfmt" },
        zsh = { "shfmt" },
        go = { "golangci-lint" },
      },
      formatters = {
        -- shfmt use spaces adn indent switches
        shfmt = {
          prepend_args = { "-i", "2", "-ci" },
        },
        -- Chef uses old rubocop
        rubocop = {
          inherit = false,
          command = "rubocop",
          args = {
            "-a",
            "-f",
            "quiet",
            "--stderr",
            "--stdin",
            "$FILENAME",
          },
        },
      },
    },
  },

  --
  -- Langs that need plugins
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
