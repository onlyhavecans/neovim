return {
  -- Debugger and test runner
  { import = "lazyvim.plugins.extras.dap.core" },
  { import = "lazyvim.plugins.extras.test.core" },

  -- All the native language plugins
  { import = "lazyvim.plugins.extras.lang.docker" },
  { import = "lazyvim.plugins.extras.lang.go" },
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.python" },
  { import = "lazyvim.plugins.extras.lang.ruby" },
  { import = "lazyvim.plugins.extras.lang.rust" },
  { import = "lazyvim.plugins.extras.lang.terraform" },
  { import = "lazyvim.plugins.extras.lang.yaml" },

  -- add all my LSPs in one go.
  -- I try to stick to defaults
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        ansiblels = {},
        bashls = {},
        quick_lint_js = {},
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      format = { timeout_ms = 1000 },
    },
  },

  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "ansible-lint",
        "black",
        "golangci-lint",
        "isort",
        "markdownlint",
        "prettier",
        "rust-analyzer",
        "shellcheck",
        "sqlfluff",
        "stylua",
        "yamllint",
      })
    end,
  },

  -- null-ls
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      -- Chef cookstyle Support
      local function rubycop_command()
        local utils = require("null-ls.utils").make_conditional_utils()
        if utils.root_has_file("cookbooks") or utils.root_has_file("kitchen.yml") then
          return "cookstyle"
        else
          return "rubocop"
        end
      end

      local nls = require("null-ls")
      vim.list_extend(opts.sources, {
        nls.builtins.diagnostics.ansiblelint,
        nls.builtins.diagnostics.golangci_lint,
        nls.builtins.diagnostics.markdownlint,
        nls.builtins.diagnostics.rubocop.with({ -- uses local rubocop still
          command = rubycop_command(),
        }),
        nls.builtins.diagnostics.shellcheck,
        nls.builtins.diagnostics.sqlfluff,
        nls.builtins.diagnostics.yamllint,
        nls.builtins.diagnostics.zsh,
        nls.builtins.formatting.prettier.with({
          filetypes = { "json", "markdown" },
        }),
        nls.builtins.formatting.isort,
        nls.builtins.formatting.black,
        nls.builtins.formatting.stylua,
      })
    end,
  },
}
