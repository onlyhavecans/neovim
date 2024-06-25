return {
  -- I don't like when plugins mutate underlying characters
  {
    "lukas-reineke/headlines.nvim",
    opts = {
      markdown = {
        fat_headlines = false,
        bullets = {},
      },
    },
  },
}
