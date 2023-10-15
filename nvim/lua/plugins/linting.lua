return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "ansible-lint",
        "golangci-lint",
        "shellcheck",
        "shellcheck",
        "sqlfluff",
        "yamllint",
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        ansible = { "ansible_lint" },
        go = { "goimports", "gofumpt", "golangcilint" },
        -- cookstyle custom rubocop
        ruby = { "rubocop" },
        sh = { "shellcheck" },
        psql = { "sqlfluff" },
        yaml = { "yamllint" },
        -- zsh
      },
    },
  },
}
