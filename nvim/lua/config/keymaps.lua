-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- The F-Keys
-- Toggle line numbers
vim.keymap.set("n", "<F2>", ":set number!<CR>")
-- Toggle Tree
vim.keymap.set("n", "<F3>", ":Neotree<CR>")
-- cd to the current file
vim.keymap.set("n", "<F4>", ":cd %:p:h<CR>:pwd<CR>")
-- rename
vim.keymap.set("n", "<F6>", vim.lsp.buf.rename)

-- EasyAlign settings Enter activation, and ga movement
vim.keymap.set("v", "<Enter>", "<Plug>(EasyAlign)", { remap = true })
vim.keymap.set({ "x", "n" }, "ga", "<Plug>(EasyAlign)")

-- Dash for lookups
-- TODO make it fit under Lazy shortcuts more
vim.keymap.set("n", "<Leader>d", "<Plug>DashSearch", { silent = true })

-- Quick open a bottom terminal for commands
vim.keymap.set("n", "<Leader>o", ":botright 20split +term<CR>i")
