return {
  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      sync_install = true,
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
        "vimdoc",
        "yaml",
      },
    },
  },
}
