return {
  -- add more treesitter parsers
  -- We extend to get all the LazyVim and Extras
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "css",
        "diff",
        "erlang",
        "git_config",
        "gitcommit",
        "graphql",
        "julia",
        "make",
        "sql",
      })
    end,
  },
}
