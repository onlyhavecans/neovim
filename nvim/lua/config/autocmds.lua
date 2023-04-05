-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- My cool term
vim.api.nvim_create_autocmd("TermOpen", { pattern = "*", command = "setlocal nonumber norelativenumber" })

-- Automatically strip trailing spaces on save
vim.api.nvim_create_autocmd("BufWritePre", { pattern = "*", command = "%s/\\s\\+$//e" })

-- [[ LSP formatting ]]
-- Set up this so it can be shared between all the lsps
local format_sync_grp = vim.api.nvim_create_augroup("LspFormat", {})
local do_format = function()
  vim.lsp.buf.format({ timeout_ms = 3000 })
end

-- Auto-format rust and go on save
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = { "*.rs", "*.go" },
--   callback = do_format,
--   group = format_sync_grp,
-- })

local auto_format = function(_)
  local bufnr = vim.nvim_get_current_buf
  vim.api.nvim_clear_autocmds({ group = format_sync_grp, buffer = bufnr })
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = format_sync_grp,
    buffer = bufnr,
    callback = do_format,
  })
end

-- Create a command `:Format` local to the LSP buffer
vim.api.nvim_create_user_command("Format", do_format, { desc = "Format current buffer with LSP" })
-- Create a command `:AFormat` local to the LSP buffer
vim.api.nvim_create_user_command("AFormat", auto_format, { desc = "Enable Format on Save for current buffer with LSP" })
