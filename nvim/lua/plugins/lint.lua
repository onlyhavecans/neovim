-- Linting configuration

return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        ansible = { "ansible_lint" },
        dockerfile = { "hadolint" },
        javascript = { "eslint" },
        javascriptreact = { "eslint" },
        typescript = { "eslint" },
        typescriptreact = { "eslint" },
        go = { "golangcilint" },
        markdown = { "markdownlint-cli2" },
        nix = { "statix", "deadnix" },
        psql = { "sqlfluff" },
        sh = { "shellcheck" },
        terraform = { "tflint" },
        tf = { "tflint" },
        yaml = { "yamllint" },
        fish = { "fish" },
      }

      -- Auto-lint on events
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("lint", { clear = true }),
        callback = function()
          lint.try_lint()
        end,
      })

      -- Manual lint command
      vim.keymap.set("n", "<leader>cL", function()
        lint.try_lint()
      end, { desc = "Trigger linting" })
    end,
  },
}
