return {
  -- add pyright to lspconfig
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
        gopls = {
          gopls = {
            staticcheck = true,
            gofumpt = true,
          },
        },
      },
    },
  },
  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
      },
    },
  },

  -- null-ls
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    opts = function()
      local nls = require("null-ls")
      local ufmt = {
        method = nls.methods.FORMATTING,
        filetypes = { "python" },
        generator = nls.formatter({
          command = "ufmt",
          args = { "format", "-" },
          to_stdin = true,
        }),
      }
      nls.register(ufmt)
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
          nls.builtins.formatting.prettier,
          nls.builtins.formatting.shfmt,
          nls.builtins.formatting.stylua,
        },
      }
    end,
  },
}
