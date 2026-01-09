-- Formatting configuration

return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = { "n", "v" },
        desc = "Format buffer",
      },
      {
        "<leader>uf",
        "<cmd>FormatToggle<cr>",
        desc = "Toggle autoformat",
      },
    },
    opts = {
      formatters_by_ft = {
        ["*"] = { "trim_whitespace", "trim_newlines" },
        bash = { "shfmt" },
        go = { "golangci-lint" },
        hcl = { "hcl" },
        json = { "fixjson" },
        just = { "just" },
        lua = { "stylua" },
        markdown = { "markdownlint-cli2" },
        nix = { "nixfmt" },
        nomad = { "nomad_fmt" },
        python = { "ruff_format", "ruff_organize_imports" },
        ruby = { "rubocop" },
        sh = { "shfmt" },
        terraform = { "terraform_fmt" },
        tf = { "terraform_fmt" },
        toml = { "tombi" },
        yaml = { "yamlfmt" },
        fish = { "fish_indent" },
      },

      formatters = {
        shfmt = {
          prepend_args = { "-i", "2", "-ci" },
        },
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

      format_on_save = function(bufnr)
        -- Disable autoformat for certain filetypes
        local disable_filetypes = { markdown = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        end

        if vim.b[bufnr].disable_autoformat then
          return nil
        end

        return {
          timeout_ms = 1500,
          lsp_format = "fallback",
        }
      end,
    },
    init = function()
      vim.api.nvim_create_user_command("FormatDisable", function()
        vim.b.disable_autoformat = true
      end, { desc = "Disable autoformat for buffer" })

      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
      end, { desc = "Enable autoformat for buffer" })

      vim.api.nvim_create_user_command("FormatToggle", function()
        vim.b.disable_autoformat = not vim.b.disable_autoformat
        local status = vim.b.disable_autoformat and "disabled" or "enabled"
        vim.notify("Autoformat " .. status, vim.log.levels.INFO)
      end, { desc = "Toggle autoformat for buffer" })
    end,
  },
}
