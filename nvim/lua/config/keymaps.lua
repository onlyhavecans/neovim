-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- cd to the current file
vim.keymap.set("n", "<Leader>p", ":cd %:p:h<CR>:pwd<CR>", { desc = "cd to current file dir" })

-- Quick open a bottom terminal for commands
vim.keymap.set("n", "<Leader>o", ":botright 20split +term<CR>i", { desc = "Quick Terminal" })

-- Using merge
vim.keymap.set("n", "<Leader>gS", ":silent !smerge %:p:h<CR>", { desc = "Sublime Merge" })
