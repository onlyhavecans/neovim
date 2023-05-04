return {
  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      sync_install = true,
      ensure_installed = {
        "bash",
        "comment",
        "css",
        "diff",
        "dockerfile",
        "gitcommit",
        "git_config",
        "go",
        "gomod",
        "gosum",
        "graphql",
        "javascript",
        "json",
        "jsonc", -- Used by neoconf
        "julia",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "python",
        "regex", -- used by noice
        "ruby",
        "rust",
        "sql",
        "terraform",
        "toml",
        "vim",
        "vimdoc",
        "yaml",
      },
    },
  },
}
