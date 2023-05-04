-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Set up my providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.python3_host_prog = "~/.local/nvim/venv/bin/python3"

-- All my numbers are absolute
vim.opt.relativenumber = false

-- Strict default whitespace settings
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

-- Terminal settings
vim.opt.shell = "zsh --login"

-- Local .nvim.lua configs
vim.opt.exrc = true
