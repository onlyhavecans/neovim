return {
  -- add more treesitter parsers
  -- We extend to get all the LazyVim and Extras
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "comment",
        "css",
        "diff",
        "dockerfile",
        "git_config",
        "gitcommit",
        "graphql",
        "julia",
        "make",
        "ruby",
        "rust",
        "sql",
        "terraform",
        "toml",
      })
    end,
  },
}
