return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "golangci-lint",
        "hadolint",
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
        psql = { "sqlfluff" },
        sh = { "shellcheck" },
        yaml = { "yamllint" },
        zsh = { "zsh" },
      },
    },
  },
}
