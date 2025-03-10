return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "gofumpt",
        "goimports",
        "prettier",
        "stylua",
        "yamlfmt",
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        json = { "prettier" },
        lua = { "stylua" },
        markdown = { "prettier" },
        ruby = { "rubocop" },
        yaml = { "yamlfmt" },
        zsh = { "shfmt" },
      },
      formatters = {
        -- shfmt use spaces adn indent switches
        shfmt = {
          prepend_args = { "-i", "2", "-ci" },
        },
        -- Chef uses old rubocop
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
    },
  },
}
