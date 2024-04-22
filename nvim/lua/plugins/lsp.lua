return {
  -- add all my LSPs in one go.
  -- I try to stick to defaults
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        quick_lint_js = {},
      },
    },
  },
}
