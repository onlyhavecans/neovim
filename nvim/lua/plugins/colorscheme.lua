-- Colorscheme configuration

return {
  {
    "neanias/everforest-nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("everforest").setup({ background = "hard" })
      vim.o.background = "dark"
      vim.cmd.colorscheme("everforest")
    end,
  },
}
