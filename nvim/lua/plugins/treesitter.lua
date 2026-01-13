-- Treesitter configuration (new API for nvim-treesitter main branch)
-- Note: nvim-treesitter does not support lazy loading

local ensure_installed = {
  -- Shell & Config
  "bash",
  "vim",
  "vimdoc",
  "regex",
  "diff",

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

  -- Data formats
  "json",
  "json5",
  "yaml",
  "toml",
  "xml",

  -- Programming languages
  "lua",
  "luadoc",
  "python",
  "go",
  "gomod",
  "gosum",
  "gowork",
  "rust",

  -- Infrastructure
  "hcl",
  "terraform",
  "nix",
  "dockerfile",

  -- Other
  "markdown",
  "markdown_inline",
  "sql",
  "just",
  "ninja",
  "query", -- treesitter query language
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false, -- treesitter does not support lazy loading
    config = function()
      -- Install ensure_installed parsers if missing
      local installed = require("nvim-treesitter.config").get_installed()
      local to_install = vim.tbl_filter(function(lang)
        return not vim.tbl_contains(installed, lang)
      end, ensure_installed)

      if #to_install > 0 then
        require("nvim-treesitter").install(to_install)
      end

      -- Auto-install parsers on demand when opening files
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter_auto_install", { clear = true }),
        callback = function(ev)
          local lang = vim.treesitter.language.get_lang(ev.match)
          if not lang then
            return
          end

          -- Check if parser is already installed
          local ok = pcall(vim.treesitter.language.add, lang)
          if not ok then
            -- Parser not installed, install it
            require("nvim-treesitter").install(lang)
          end
        end,
      })
    end,
  },

  -- Treesitter textobjects
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      -- Set up textobject keymaps on FileType
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter_textobjects", { clear = true }),
        callback = function(ev)
          local lang = vim.treesitter.language.get_lang(ev.match)
          if not lang then
            return
          end

          -- Check if we have textobjects query for this language
          local ok = pcall(vim.treesitter.query.get, lang, "textobjects")
          if not ok then
            return
          end

          local buf = ev.buf
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc, silent = true })
          end

          -- Selection textobjects
          local select_ok, select = pcall(require, "nvim-treesitter-textobjects.select")
          if select_ok then
            map({ "x", "o" }, "af", function()
              select.select_textobject("@function.outer", "textobjects")
            end, "outer function")
            map({ "x", "o" }, "if", function()
              select.select_textobject("@function.inner", "textobjects")
            end, "inner function")
            map({ "x", "o" }, "ac", function()
              select.select_textobject("@class.outer", "textobjects")
            end, "outer class")
            map({ "x", "o" }, "ic", function()
              select.select_textobject("@class.inner", "textobjects")
            end, "inner class")
            map({ "x", "o" }, "aa", function()
              select.select_textobject("@parameter.outer", "textobjects")
            end, "outer parameter")
            map({ "x", "o" }, "ia", function()
              select.select_textobject("@parameter.inner", "textobjects")
            end, "inner parameter")
            map({ "x", "o" }, "ao", function()
              select.select_textobject("@block.outer", "textobjects")
            end, "outer block")
            map({ "x", "o" }, "io", function()
              select.select_textobject("@block.inner", "textobjects")
            end, "inner block")
          end

          -- Move textobjects
          local move_ok, move = pcall(require, "nvim-treesitter-textobjects.move")
          if move_ok then
            map({ "n", "x", "o" }, "]f", function()
              move.goto_next_start("@function.outer", "textobjects")
            end, "Next function start")
            map({ "n", "x", "o" }, "]F", function()
              move.goto_next_end("@function.outer", "textobjects")
            end, "Next function end")
            map({ "n", "x", "o" }, "[f", function()
              move.goto_previous_start("@function.outer", "textobjects")
            end, "Prev function start")
            map({ "n", "x", "o" }, "[F", function()
              move.goto_previous_end("@function.outer", "textobjects")
            end, "Prev function end")
            map({ "n", "x", "o" }, "]c", function()
              move.goto_next_start("@class.outer", "textobjects")
            end, "Next class start")
            map({ "n", "x", "o" }, "[c", function()
              move.goto_previous_start("@class.outer", "textobjects")
            end, "Prev class start")
          end

          -- Swap textobjects
          local swap_ok, swap = pcall(require, "nvim-treesitter-textobjects.swap")
          if swap_ok then
            map("n", "<leader>cs", function()
              swap.swap_next("@parameter.inner", "textobjects")
            end, "Swap next parameter")
            map("n", "<leader>cS", function()
              swap.swap_previous("@parameter.inner", "textobjects")
            end, "Swap prev parameter")
          end
        end,
      })
    end,
  },
}
