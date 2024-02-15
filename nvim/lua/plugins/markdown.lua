return {
  -- The header color scheme from Obsidian
  vim.cmd([[
    highlight Headline1 gui=bold guifg=#D52D00
    highlight Headline2 gui=bold guifg=#EF7627
    highlight Headline3 gui=bold guifg=#FF9A56
    highlight Headline4 gui=bold guifg=#D162A4
    highlight Headline5 gui=bold guifg=#B55690
    highlight Headline6 gui=bold guifg=#A30262
  ]]),

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
