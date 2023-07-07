return {
  -- add all my LSPs in one go.
  -- I try to stick to defaults
  --
  -- The following are added by LazyVim lang extras
  -- gopls
  -- jsonls
  -- pyright
  -- rust-analyzer
  -- solargraph
  -- terraformls
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
    opts = function()
      -- Chef cookstyle Support
      local function is_chef_directory()
        local utils = require("null-ls.utils").make_conditional_utils()
        return utils.root_has_file("cookbooks") or utils.root_has_file("kitchen.yml")
      end

      local function rubycop_command()
        if is_chef_directory() then
          return "cookstyle"
        else
          return "rubocop"
        end
      end

      local nls = require("null-ls")
      return {
        root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
        sources = {
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
        },
      }
    end,
  },
}
