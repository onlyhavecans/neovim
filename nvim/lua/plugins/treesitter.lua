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
        "jsonc", -- Used by neoconf
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "python",
        "regex", -- used by noice
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
