return {
  { "tpope/vim-eunuch", event = "VeryLazy" }, -- First class unix commands
  { "direnv/direnv.vim", event = "VeryLazy" },

  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      close_if_last_window = true,
      filesystem = { filtered_items = { visible = true } },
      follow_current_file = { enabled = true },
      window = {
        width = 30,
        mappings = {
          ["<space>"] = { "toggle_node", nowait = false },
        },
      },

      -- event_handlers = {
      --   {
      --     event = "file_opened",
      --     handler = function(file_path)
      --       -- auto close
      --       require("neo-tree.command").execute({ action = "close" })
      --     end,
      --   },
      -- },

      nesting_rules = {
        ["go"] = {
          pattern = "(.*)%.go$", -- <-- Lua pattern with capture
          files = { "%1_test.go" }, -- <-- glob pattern with capture
        },
        ["gomod"] = {
          pattern = "^go%.mod$",
          files = { "go.sum" },
        },
        ["docker"] = {
          pattern = "^dockerfile$",
          ignore_case = true,
          files = { ".dockerignore", "docker-compose.*", "dockerfile*" },
        },
        ["rustcargo"] = {
          pattern = "^Cargo%.toml$",
          files = { "Cargo.lock" },
        },
      },
    },
  },
}
