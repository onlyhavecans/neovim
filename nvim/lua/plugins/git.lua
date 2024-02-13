return {
  -- inline git blame
  {
    "hougesen/blame-me.nvim",
    event = "BufRead",
    opts = { signs = false },
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
