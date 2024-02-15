-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- cd to the current file
map("n", "<Leader>p", ":cd %:p:h<CR>:pwd<CR>", { desc = "cd to current file dir" })

-- Using merge
map("n", "<Leader>gS", ":silent !smerge %:p:h<CR>", { desc = "Sublime Merge" })
