return {
  -- Git blame lines
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
    },
  },

  -- Opening git blame
  {
    "dlvhdr/gh-blame.nvim",
    event = "BufRead",
    dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
    keys = {
      { "<leader>gb", "<cmd>GhBlameCurrentLine<cr>", desc = "GitHub Blame Current Line" },
    },
  },
}
