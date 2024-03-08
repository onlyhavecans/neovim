return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "gofumpt",
        "goimports",
        "prettier",
        "shfmt",
        "stylua",
        "isort",
        "black",
        "yamlfmt",
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        markdown = { "prettier" },
        json = { "prettier" },
        yaml = { "yamlfmt" },
        sh = { "shfmt" },
        lua = { "stylua" },
        python = { "isort", "black" },
        zsh = { "shfmt" },
      },
      formatters = {
        -- shfmt use spaces adn indent switches
        shfmt = {
          prepend_args = { "-i", "2", "-ci" },
        },
      },
    },
  },
}
