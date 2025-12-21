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
        function()
          if vim.g.disable_autoformat then
            vim.g.disable_autoformat = false
            vim.notify("Autoformat enabled", vim.log.levels.INFO)
          else
            vim.g.disable_autoformat = true
            vim.notify("Autoformat disabled", vim.log.levels.INFO)
          end
        end,
        desc = "Toggle autoformat",
      },
    },
    opts = {
      formatters_by_ft = {
        go = { "goimports", "gofmt" },
        lua = { "stylua" },
        nix = { "nixfmt" },
        ruby = { "rubocop" },
        yaml = { "yamlfmt" },
        zsh = { "shfmt" },
        sh = { "shfmt" },
        bash = { "shfmt" },
        json = { "jq" },
        python = { "ruff_format", "ruff_organize_imports" },
        terraform = { "terraform_fmt" },
        tf = { "terraform_fmt" },
        ["terraform-vars"] = { "terraform_fmt" },
        markdown = { "prettier" },
        ["_"] = { "trim_whitespace" },
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

        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return nil
        end

        return {
          timeout_ms = 3000,
          lsp_format = "fallback",
        }
      end,
    },
    init = function()
      -- Create commands to toggle autoformat
      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, { desc = "Disable autoformat-on-save", bang = true })

      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, { desc = "Re-enable autoformat-on-save" })
    end,
  },
}
