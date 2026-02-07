-- Dashboard with startup screen

return {
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      theme = "hyper",
      shortcut_type = "number",
      config = {
        header = {
          "",
          " ███████╗ ██████╗ ██╗   ██╗██╗██████╗ ██████╗ ███████╗██╗     ",
          " ██╔════╝██╔═══██╗██║   ██║██║██╔══██╗██╔══██╗██╔════╝██║     ",
          " ███████╗██║   ██║██║   ██║██║██████╔╝██████╔╝█████╗  ██║     ",
          " ╚════██║██║▄▄ ██║██║   ██║██║██╔══██╗██╔══██╗██╔══╝  ██║     ",
          " ███████║╚██████╔╝╚██████╔╝██║██║  ██║██║  ██║███████╗███████╗",
          " ╚══════╝ ╚══▀▀═╝  ╚═════╝ ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚══════╝",
          "                        N E O V I M                          ",
          "",
        },
        shortcut = {
          { desc = "󰝒 New", group = "String", action = "enew", key = "n" },
          { desc = "󰋚 Recent", group = "DiagnosticHint", action = "FzfLua oldfiles", key = "r" },
          { desc = "󰱼 Files", group = "DiagnosticInfo", action = "FzfLua files", key = "f" },
          { desc = "󰈬 Search", group = "DiagnosticWarn", action = "FzfLua live_grep", key = "s" },
          { desc = "󰙅 Tree", group = "String", action = "Neotree", key = "t" },
          { desc = "󰒲 Lazy", group = "Number", action = "Lazy", key = "l" },
          { desc = "󰩈 Quit", group = "DiagnosticError", action = "qa", key = "q" },
        },
        project = { enable = false },
        mru = { limit = 10, cwd_only = true },
        footer = {},
      },
    },
  },
}
