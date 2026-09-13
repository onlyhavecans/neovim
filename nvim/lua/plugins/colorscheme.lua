-- Colorscheme configuration

return {
  "RRethy/base16-nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("matugen")
  end,
}
