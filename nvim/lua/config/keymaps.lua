-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- The F-Keys
-- Toggle line numbers
vim.keymap.set("n", "<F2>", ":set number!<CR>", { desc = "Toggle Line Numbers" })
-- Toggle Tree
vim.keymap.set("n", "<F3>", ":Neotree<CR>")
-- cd to the current file
vim.keymap.set("n", "<F4>", ":cd %:p:h<CR>:pwd<CR>", { desc = "cd to curret file dir" })
-- rename
vim.keymap.set("n", "<F6>", vim.lsp.buf.rename)

-- Quick open a bottom terminal for commands
vim.keymap.set("n", "<Leader>o", ":botright 20split +term<CR>i", { desc = "Quick Terminal" })

-- Using merge
vim.keymap.set("n", "<Leader>gS", ":silent !smerge %:p:h<CR>", { desc = "Sublime Merge" })
