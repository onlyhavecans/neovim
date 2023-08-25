-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Set up my providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.python3_host_prog = "~/.local/nvim/venv/bin/python3"

local opt = vim.opt

-- Strict default whitespace settings
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.smarttab = true
opt.expandtab = true
opt.smartindent = true

-- Terminal settings
opt.shell = "zsh --login"

-- Local .nvim.lua configs
opt.exrc = true

-- Undo Lazyvim settings I don't care for
opt.conceallevel = 0 -- Don't hide characters
opt.relativenumber = false -- Absolute Numbers
