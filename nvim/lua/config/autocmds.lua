-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local au = vim.api.nvim_create_autocmd

--
-- Set filetypes
--

local ft = function(pattern, command)
  au({ "BufNewFile", "BufRead" }, { pattern = pattern, command = "setf " .. command })
end

-- direnv files
ft(".envrc", "bash")
-- Omni Automation Files
ft("*.omnijs", "javascript")
ft("*.omnifocusjs", "javascript")
ft("*.omnioutlinerjs", "javascript")
-- Markdown config
ft(".markdownlintrc", "json")
-- Ansible
ft("site.ya?ml", "yaml.ansible")
ft("playbook.ya?ml", "yaml.ansible")
ft("*/group_vars/*.ya?ml", "yaml.ansible")
ft("*/host_vars/*.ya?ml", "yaml.ansible")
ft("*/playbooks/*.ya?ml", "yaml.ansible")
ft("*/roles/*/tasks/*.ya?ml", "yaml.ansible")
ft("*/roles/*/handlers/*.ya?ml", "yaml.ansible")

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
  command = "%s/\\s\\+$//e",
})

--
-- Sneak in all my user commands here
--

local uc = vim.api.nvim_create_user_command

-- Grep Auto Open
uc("Rg", ":silent grep <args> | copen", { nargs = "+", desc = "Grep and open matches w/o autojump" })

-- GUI Git app
uc("SMerge", ":silent !smerge %:p:h", { desc = "Open current file dir in sublime merge" })

-- My personalized Wrap
local wrap = function()
  vim.opt.wrap = true
  vim.opt.linebreak = true
  vim.opt.list = false
  vim.opt.showbreak = "…"
end
uc("Wrap", wrap, { bang = true, desc = "Enable Preferred Line Wrap" })
