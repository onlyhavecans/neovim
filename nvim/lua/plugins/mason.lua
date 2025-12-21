-- Mason: Package manager for LSP servers, DAP, linters, and formatters
--
-- Tools NOT in Mason (install externally):
--   LSP:
--     - nixd
--     - marksman
--   Linters:
--     - statix
--     - deadnix

return {
  {
    "mason-org/mason.nvim",
    lazy = false, -- Must load early to prepend PATH before linters/formatters need it
    keys = { { "<leader>nm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts_extend = { "ensure_installed" },
    opts = {
      ensure_installed = {
        -- LSP
        "basedpyright",
        "bash-language-server",
        "gopls",
        "json-lsp",
        "lua-language-server",
        "nil",
        "ruff",
        "rust-analyzer",
        "terraform-ls",
        "tombi",
        "ty",
        "yaml-language-server",

        -- Formatters
        "goimports",
        "jq",
        "nixfmt",
        "prettier",
        "shfmt",
        "stylua",
        "yamlfmt",

        -- Linters
        "ansible-lint",
        "dotenv-linter",
        "golangci-lint",
        "markdownlint-cli2",
        "quick-lint-js",
        "shellcheck",
        "sqlfluff",
        "yamllint",

        -- DAP
        "codelldb",
        "debugpy",
        "delve",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      mr:on("package:install:success", function()
        vim.defer_fn(function()
          -- trigger FileType event to possibly load this newly installed LSP server
          require("lazy.core.handler.event").trigger({
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)

      mr.refresh(function()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end)
    end,
  },

  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      automatic_installation = false,
    },
  },
}
