return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        ansible = { "ansible_lint" },
        go = { "goimports", "gofumpt", "golangcilint" },
        -- cookstyle custom rubocop
        ruby = { "rubocop" },
        sh = { "shellcheck" },
        bash = { "shellcheck" },
        psql = { "sqlfluff" },
        yaml = { "yamllint" },
        -- zsh
      },
    },
  },
}
