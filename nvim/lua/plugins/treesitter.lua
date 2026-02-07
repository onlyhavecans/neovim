-- Treesitter configuration (new API for nvim-treesitter main branch)
-- Note: nvim-treesitter does not support lazy loading

local ensure_installed = {
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
  "query", -- treesitter query language
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      local ts = require("nvim-treesitter")
      local ts_config = require("nvim-treesitter.config")

      -- Install missing parsers from ensure_installed
      local installed = ts_config.get_installed()
      local to_install = vim.iter(ensure_installed)
        :filter(function(lang)
          return not vim.list_contains(installed, lang)
        end)
        :totable()

      if #to_install > 0 then
        ts.install(to_install)
      end

      -- Auto-install and enable highlighting on FileType
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter_auto", { clear = true }),
        callback = function(ev)
          local lang = vim.treesitter.language.get_lang(ev.match)
          if not lang then
            return
          end

          -- Try to load parser, install if missing
          if not pcall(vim.treesitter.language.add, lang) then
            ts.install(lang, { on_success = function()
              pcall(vim.treesitter.start, ev.buf, lang)
            end })
          else
            pcall(vim.treesitter.start, ev.buf, lang)
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
      local select = require("nvim-treesitter-textobjects.select")
      local move = require("nvim-treesitter-textobjects.move")
      local swap = require("nvim-treesitter-textobjects.swap")

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter_textobjects", { clear = true }),
        callback = function(ev)
          local lang = vim.treesitter.language.get_lang(ev.match)
          if not lang or not pcall(vim.treesitter.query.get, lang, "textobjects") then
            return
          end

          local buf = ev.buf
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc, silent = true })
          end

          -- Select
          map({ "x", "o" }, "af", function() select.select_textobject("@function.outer", "textobjects") end, "outer function")
          map({ "x", "o" }, "if", function() select.select_textobject("@function.inner", "textobjects") end, "inner function")
          map({ "x", "o" }, "ac", function() select.select_textobject("@class.outer", "textobjects") end, "outer class")
          map({ "x", "o" }, "ic", function() select.select_textobject("@class.inner", "textobjects") end, "inner class")
          map({ "x", "o" }, "aa", function() select.select_textobject("@parameter.outer", "textobjects") end, "outer argument")
          map({ "x", "o" }, "ia", function() select.select_textobject("@parameter.inner", "textobjects") end, "inner argument")
          map({ "x", "o" }, "ao", function() select.select_textobject("@block.outer", "textobjects") end, "outer block")
          map({ "x", "o" }, "io", function() select.select_textobject("@block.inner", "textobjects") end, "inner block")

          -- Move
          map({ "n", "x", "o" }, "]f", function() move.goto_next_start("@function.outer", "textobjects") end, "Next function")
          map({ "n", "x", "o" }, "]F", function() move.goto_next_end("@function.outer", "textobjects") end, "Next function end")
          map({ "n", "x", "o" }, "[f", function() move.goto_previous_start("@function.outer", "textobjects") end, "Prev function")
          map({ "n", "x", "o" }, "[F", function() move.goto_previous_end("@function.outer", "textobjects") end, "Prev function end")
          map({ "n", "x", "o" }, "]c", function() move.goto_next_start("@class.outer", "textobjects") end, "Next class")
          map({ "n", "x", "o" }, "[c", function() move.goto_previous_start("@class.outer", "textobjects") end, "Prev class")

          -- Swap
          map("n", "<leader>cs", function() swap.swap_next("@parameter.inner", "textobjects") end, "Swap next param")
          map("n", "<leader>cS", function() swap.swap_previous("@parameter.inner", "textobjects") end, "Swap prev param")
        end,
      })
    end,
  },
}
