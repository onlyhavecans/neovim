return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "gofumpt",
        "goimports",
        "prettier",
        "shfmt",
        "isort",
        "black",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        markdown = { "prettier" },
        json = { "prettier" },
        sh = { "shfmt" },
        python = { "isort", "black" },
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
