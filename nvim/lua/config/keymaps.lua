-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- cd to the current file
map("n", "<Leader>p", ":cd %:p:h<CR>:pwd<CR>", { desc = "cd to current file dir" })

-- Quick open a bottom terminal for commands
map("n", "<Leader>o", ":botright 20split +term<CR>i", { desc = "Quick Terminal" })

-- Using merge
map("n", "<Leader>gS", ":silent !smerge %:p:h<CR>", { desc = "Sublime Merge" })

-- Tmux navigation must be set up manually
map("n", "<C-h>", "<cmd>lua require'tmux'.move_left()<cr>", { desc = "Go to left window" })
map("n", "<C-j>", "<cmd>lua require'tmux'.move_bottom()<cr>", { desc = "Go to lower window" })
map("n", "<C-k>", "<cmd>lua require'tmux'.move_top()<cr>", { desc = "Go to upper window" })
map("n", "<C-l>", "<cmd>lua require'tmux'.move_right()<cr>", { desc = "Go to right window" })
