return {
  -- add all my LSPs in one go.
  -- I try to stick to defaults
  -- rust-analyzer is added by rust tools, not configured here
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

  -- My python formaatter is SO SLOW
  {
    "neovim/nvim-lspconfig",
    opts = {
      format = {
        timeout_ms = 10000,
      },
    },
  },

  -- add jsonls and schemastore ans setup treesitter for json, json5 and jsonc
  { import = "lazyvim.plugins.extras.lang.json" },

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
        "shellcheck",
        "shfmt",
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
          nls.builtins.formatting.shfmt,
          nls.builtins.formatting.stylua,
        },
      }
    end,
  },

  -- Special rust tools
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = {
      "neovim/nvim-lspconfig",
      -- Debugging
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {},
  },

  -- Awesome crates.toml
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    init = function()
      require("crates").show()
    end,
  },
}
