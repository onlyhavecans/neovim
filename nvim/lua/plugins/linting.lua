return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "golangci-lint",
        "hadolint",
        "markdownlint",
        "shellcheck",
        "sqlfluff",
        "yamllint",
      })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        go = { "golangcilint" },
        sh = { "shellcheck" },
        psql = { "sqlfluff" },
        yaml = { "yamllint" },
        zsh = { "zsh" },
      },
    },
  },
}
