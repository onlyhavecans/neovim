return {
  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "css",
        "diff",
        "dockerfile",
        "go",
        "gosum",
        "javascript",
        "json",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "python",
        "ruby",
        "rust",
        "toml",
        "vim",
        "yaml",
      },
    },
  },
}
