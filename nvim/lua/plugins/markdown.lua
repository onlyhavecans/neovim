return {
  { "MeanderingProgrammer/render-markdown.nvim", enable = false },
  { "SidOfc/mkdx", ft = "markdown" },
  {
    "folke/twilight.nvim",
    lazy = true,
    opts = {
      dimming = {
        alpha = 0.25, -- amount of dimming
        -- we try to get the foreground from the highlight groups or fallback color
        color = { "Normal", "#ffffff" },
        term_bg = "#000000", -- if guibg=NONE, this will be used to calculate text color
        inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
      },
      context = 4, -- amount of lines we will try to show around the current line
    },
  },

  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    keys = {
      { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode Toggle" },
    },
    opts = {
      window = {
        backdrop = 0.75, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
        width = 100,
        height = 1,
        options = {
          signcolumn = "no", -- disable signcolumn
          number = false, -- disable number column
          relativenumber = false, -- disable relative numbers
          -- cursorline = false, -- disable cursorline
          cursorcolumn = false, -- disable cursor column
          foldcolumn = "0", -- disable fold column
          list = false, -- disable whitespace characters
        },
      },
      plugins = {
        options = {
          enabled = true,
          ruler = false,
          showcmd = false,
          laststatus = 0,
        },
        tmux = { enabled = true },
        wezterm = {
          enabled = true,
          -- can be either an absolute font size or the number of incremental steps
          font = "+2",
        },
      },
    },
  },
}
