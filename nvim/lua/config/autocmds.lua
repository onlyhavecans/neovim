-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local au = vim.api.nvim_create_autocmd

--
-- Set filetypes
--

vim.filetype.add({
  extension = {
    ["nsp"] = "json",
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

-- Straighten quotes
local straightenQuotes = function()
  local cursor_pos = vim.fn.getpos(".")

  local replacements = {
    -- Smart/curly quotes - using escape sequences to represent UTF-8 characters
    ["\226\128\156"] = '"', -- Left double quote (")
    ["\226\128\157"] = '"', -- Right double quote (")
    ["\226\128\158"] = '"', -- Double low-9 quote („)
    ["\226\128\152"] = "'", -- Left single quote (')
    ["\226\128\153"] = "'", -- Right single quote (')
    ["\226\128\154"] = "'", -- Single low-9 quote (‚)

    -- Other punctuation
    ["\226\128\148"] = "-", -- Em dash (—)
    ["\226\128\147"] = "-", -- En dash (–)
    ["\226\128\166"] = "...", -- Ellipsis (…)
    ["\226\128\162"] = "*", -- Bullet (•)
    ["\194\169"] = "(c)", -- Copyright (©)
    ["\194\174"] = "(r)", -- Registered (®)
    ["\226\132\162"] = "(tm)", -- Trademark (™)
    ["\194\171"] = "<<", -- Left double angle quotes («)
    ["\194\187"] = ">>", -- Right double angle quotes (»)
    ["\226\128\185"] = "<", -- Left single angle quote (‹)
    ["\226\128\186"] = ">", -- Right single angle quote (›)
    ["\226\136\146"] = "-", -- Minus sign (−)
    ["\195\151"] = "x", -- Multiplication sign (×)
    ["\195\183"] = "/", -- Division sign (÷)

    -- Non-breaking space
    ["\194\160"] = " ", -- Non-breaking space
  }

  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  for i, line in ipairs(lines) do
    for non_ascii, ascii in pairs(replacements) do
      line = line:gsub(non_ascii, ascii)
    end
    lines[i] = line
  end

  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)

  vim.fn.setpos(".", cursor_pos)

  -- Provide feedback
  local count = 0
  for _, line in ipairs(lines) do
    for non_ascii, _ in pairs(replacements) do
      count = count + select(2, line:gsub(non_ascii, ""))
    end
  end

  vim.api.nvim_echo({ { string.format("Straightened %d quotes and punctuation marks", count), "Normal" } }, false, {})
end

uc(
  "StraightenQuotes",
  straightenQuotes,
  { desc = "Convert curly quotes and non-ASCII punctuation to ASCII equivalents" }
)
