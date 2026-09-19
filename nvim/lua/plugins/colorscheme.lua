-- Colorscheme: Everforest Light Hard (see the dotfiles castle, docs/everforest.md)
return {
  {
    "sainnhe/everforest",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.everforest_background = "hard"
      vim.o.background = "light"
      vim.cmd.colorscheme("everforest")
    end,
  },
}
