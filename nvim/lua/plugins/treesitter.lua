-- Treesitter configuration (master branch for nvim 0.11 compat)

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          -- Shell
          "bash",
          "vim",
          "vimdoc",
          "regex",
          "diff",
          "fish",

          -- Git
          "git_config",
          "git_rebase",
          "gitattributes",
          "gitcommit",
          "gitignore",

          -- Web
          "html",
          "css",
          "javascript",
          "typescript",
          "tsx",

          -- Data & Config
          "desktop",
          "json",
          "json5",
          "toml",
          "xml",
          "yaml",

          -- Programming languages
          "c",
          "cpp",
          "lua",
          "python",
          "go",
          "gomod",
          "gosum",
          "gowork",
          "rust",
          "jinja",

          -- Infrastructure
          "hcl",
          "terraform",
          "nix",
          "dockerfile",
          "make",
          "ssh_config",

          -- Other
          "markdown",
          "markdown_inline",
          "sql",
          "just",
          "ninja",
          "query",
        },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- Treesitter textobjects
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "master",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter.configs").setup({
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = { query = "@function.outer", desc = "outer function" },
              ["if"] = { query = "@function.inner", desc = "inner function" },
              ["ac"] = { query = "@class.outer", desc = "outer class" },
              ["ic"] = { query = "@class.inner", desc = "inner class" },
              ["aa"] = { query = "@parameter.outer", desc = "outer argument" },
              ["ia"] = { query = "@parameter.inner", desc = "inner argument" },
              ["ao"] = { query = "@block.outer", desc = "outer block" },
              ["io"] = { query = "@block.inner", desc = "inner block" },
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]f"] = { query = "@function.outer", desc = "Next function" },
            },
            goto_next_end = {
              ["]F"] = { query = "@function.outer", desc = "Next function end" },
            },
            goto_previous_start = {
              ["[f"] = { query = "@function.outer", desc = "Prev function" },
            },
            goto_previous_end = {
              ["[F"] = { query = "@function.outer", desc = "Prev function end" },
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>cs"] = { query = "@parameter.inner", desc = "Swap next param" },
            },
            swap_previous = {
              ["<leader>cS"] = { query = "@parameter.inner", desc = "Swap prev param" },
            },
          },
        },
      })
    end,
  },
}
