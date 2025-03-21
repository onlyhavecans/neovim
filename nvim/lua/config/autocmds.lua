-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local au = vim.api.nvim_create_autocmd

--
-- Set filetypes
--

vim.filetype.add({
  extension = {
    ["omnijs"] = "javascript",
    ["omnifocusjs"] = "javascript",
    ["omnioutlinerjs"] = "javascript",
  },
  filename = {
    [".envrc"] = "bash",
    [".markdownlintrc"] = "json",
  },
  pattern = {
    ["site%.ya?ml"] = "yaml.ansible",
    ["playbook%.ya?ml"] = "yaml.ansible",
    [".*/group_vars/.*%.ya?ml"] = "yaml.ansible",
    [".*/host_vars/.*%.ya?ml"] = "yaml.ansible",
    [".*/playbooks/.*%.ya?ml"] = "yaml.ansible",
    [".*/roles/.*/tasks/.*%.ya?ml"] = "yaml.ansible",
    [".*/roles/.*/handlers/.*%.ya?ml"] = "yaml.ansible",
    [".*/roles/.*/vars/.*%.ya?ml"] = "yaml.ansible",
  },
})

--
-- Tune filetypes
--
au("FileType", {
  pattern = { "fish" },
  command = "setlocal tabstop=4 shiftwidth=4 expandtab",
})

--
-- General Autocmds
--
au({ "FileType" }, {
  desc = "Disable autoformat for certain types",
  pattern = { "markdown" },
  callback = function()
    vim.b.autoformat = false
  end,
})

au("TermOpen", {
  desc = "My cool term",
  pattern = "*",
  command = "setlocal nonumber norelativenumber",
})

au("BufWritePre", {
  desc = "Strip trailing whitespace on save",
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

--
-- Sneak in all my user commands here
--

local uc = vim.api.nvim_create_user_command

-- Grep Auto Open
uc("Rg", ":silent grep <args> | copen", { nargs = "+", desc = "Grep and open matches w/o autojump" })

-- My personalized Wrap
local wrap = function()
  vim.opt.wrap = true
  vim.opt.linebreak = true
  vim.opt.list = false
  vim.opt.showbreak = "…"
end
uc("Wrap", wrap, { bang = true, desc = "Enable Preferred Line Wrap" })
