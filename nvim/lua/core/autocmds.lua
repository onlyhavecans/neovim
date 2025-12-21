-- Autocommands and user commands

local au = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

--
-- Filetype-specific settings
--

--
-- Terminal settings
--
au("TermOpen", {
  group = augroup("terminal_settings", { clear = true }),
  desc = "Terminal without line numbers",
  pattern = "*",
  command = "setlocal nonumber norelativenumber",
})

--
-- Highlight on yank
--
au("TextYankPost", {
  group = augroup("highlight_yank", { clear = true }),
  desc = "Highlight when yanking text",
  callback = function()
    vim.hl.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})

--
-- Resize splits on window resize
--
au("VimResized", {
  group = augroup("resize_splits", { clear = true }),
  desc = "Resize splits when window resizes",
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

--
-- Go to last location when opening a buffer
--
au("BufReadPost", {
  group = augroup("last_location", { clear = true }),
  desc = "Go to last location when opening a buffer",
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

--
-- Close certain filetypes with q
--
au("FileType", {
  group = augroup("close_with_q", { clear = true }),
  pattern = {
    "help",
    "lspinfo",
    "notify",
    "qf",
    "checkhealth",
    "man",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

--
-- Auto create directories when saving a file
--
au("BufWritePre", {
  group = augroup("auto_create_dir", { clear = true }),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

--
-- User Commands
--
local uc = vim.api.nvim_create_user_command

-- Grep and open quickfix
uc("Rg", ":silent grep <args> | copen", { nargs = "+", desc = "Grep and open matches" })

-- Preferred line wrap
local wrap = function()
  vim.opt.wrap = true
  vim.opt.linebreak = true
  vim.opt.list = false
  vim.opt.showbreak = "…"
end
uc("Wrap", wrap, { bang = true, desc = "Enable Preferred Line Wrap" })

-- Straighten quotes - convert curly quotes to ASCII
local straightenQuotes = function()
  local cursor_pos = vim.fn.getpos(".")

  local replacements = {
    ["\226\128\156"] = '"', -- Left double quote
    ["\226\128\157"] = '"', -- Right double quote
    ["\226\128\158"] = '"', -- Double low-9 quote
    ["\226\128\152"] = "'", -- Left single quote
    ["\226\128\153"] = "'", -- Right single quote
    ["\226\128\154"] = "'", -- Single low-9 quote
    ["\226\128\148"] = "-", -- Em dash
    ["\226\128\147"] = "-", -- En dash
    ["\226\128\166"] = "...", -- Ellipsis
    ["\226\128\162"] = "*", -- Bullet
    ["\194\169"] = "(c)", -- Copyright
    ["\194\174"] = "(r)", -- Registered
    ["\226\132\162"] = "(tm)", -- Trademark
    ["\194\171"] = "<<", -- Left double angle quotes
    ["\194\187"] = ">>", -- Right double angle quotes
    ["\226\128\185"] = "<", -- Left single angle quote
    ["\226\128\186"] = ">", -- Right single angle quote
    ["\226\136\146"] = "-", -- Minus sign
    ["\195\151"] = "x", -- Multiplication sign
    ["\195\183"] = "/", -- Division sign
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
