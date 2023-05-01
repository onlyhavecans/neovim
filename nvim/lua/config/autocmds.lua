-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- My cool term
vim.api.nvim_create_autocmd("TermOpen", { pattern = "*", command = "setlocal nonumber norelativenumber" })

-- Automatically strip trailing spaces on save
vim.api.nvim_create_autocmd("BufWritePre", { pattern = "*", command = "%s/\\s\\+$//e" })

-- GUI Git app
vim.api.nvim_create_user_command("SMerge", ":silent !smerge %:p:h", { desc = "Open current file dir in sublime merge" })

-- My personalized Wrap
local wrap = function()
  vim.opt.wrap = true
  vim.opt.linebreak = true
  vim.opt.list = false
  vim.opt.showbreak = "…"
end
vim.api.nvim_create_user_command("Wrap", wrap, { bang = true, desc = "Enable Preferred Line Wrap" })
