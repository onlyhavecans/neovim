return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "ansible-lint",
        "golangci-lint",
        "hadolint",
        "markdownlint",
        "shellcheck",
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
        ansible = { "ansible_lint" },
        go = { "golangcilint" },
        -- TODO: cookstyle custom rubocop
        ruby = { "rubocop" },
        sh = { "shellcheck" },
        psql = { "sqlfluff" },
        yaml = { "yamllint" },
        zsh = { "zsh" },
      },
    },
  },
}
