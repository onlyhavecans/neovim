return {
  -- add all my LSPs in one go.
  -- I try to stick to defaults
  --
  -- rust-analyzer is added by rust tools, not configured here
  -- gopls is added by the go extras
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        bashls = {},
        jsonls = {},
        pyright = {},
        quick_lint_js = {},
      },
    },
  },

  -- add any tools you want to have installed below
  -- I install most of my tools with brew at the moment so this is short
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "isort",
        "black",
        "rust-analyzer",
        "stylua",
      },
    },
  },

  -- null-ls
  {
    "jose-elias-alvarez/null-ls.nvim",
    -- Add my ufmt for python
    opts = function()
      local nls = require("null-ls")
      return {
        root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
        sources = {
          nls.builtins.diagnostics.ansiblelint,
          nls.builtins.diagnostics.golangci_lint,
          nls.builtins.diagnostics.markdownlint,
          nls.builtins.diagnostics.rubocop,
          nls.builtins.diagnostics.ruff,
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
