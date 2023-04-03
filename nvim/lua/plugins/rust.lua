return {
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = {
      "neovim/nvim-lspconfig",
      -- Debugging
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      tools = {
        on_initialized = function()
          vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
            pattern = { "*.rs" },
            callback = function()
              vim.lsp.codelens.refresh()
            end,
          })
        end,
        hover_actions = {
          auto_focus = true,
        },
      },
      server = {
        standalone = false,
        ["rust-analyzer"] = {
          lens = {
            enable = true,
          },
          checkOnSave = {
            command = "clippy",
          },
          check = {
            command = "clippy",
          },
        },
      },
    },
  },

  {
    "saecki/crates.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
}
