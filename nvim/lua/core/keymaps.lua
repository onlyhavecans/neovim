-- Core keymaps (non-plugin specific)

local map = vim.keymap.set

-- Better escape
map("i", "jj", "<Esc>", { desc = "Escape" })

-- Don't yank on paste in visual mode
map("v", "p", "P", { desc = "Paste without yanking" })

-- Quit all without saving
map("n", "XX", ":qall!<CR>", { desc = "Quit all without saving" })

-- cd to the current file's directory
map("n", "<Leader>.", ":cd %:p:h<CR>:pwd<CR>", { desc = "cd to current file dir" })

-- Better movement on wrapped lines
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = "Down" })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = "Up" })

-- Better indenting (stay in visual mode)
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Quickfix navigation
map("n", "[q", "<cmd>cprev<cr>", { desc = "Prev quickfix" })
map("n", "]q", "<cmd>cnext<cr>", { desc = "Next quickfix" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Open quickfix" })

-- Location list navigation
map("n", "[l", "<cmd>lprev<cr>", { desc = "Prev loclist" })
map("n", "]l", "<cmd>lnext<cr>", { desc = "Next loclist" })
map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Open loclist" })

-- Diagnostics list
map("n", "<leader>xd", vim.diagnostic.setloclist, { desc = "Buffer Diagnostics (loclist)" })
map("n", "<leader>xD", vim.diagnostic.setqflist, { desc = "Workspace Diagnostics (qflist)" })

-- Diagnostic navigation
map("n", "[d", function()
  vim.diagnostic.jump({ count = -1 })
end, { desc = "Prev diagnostic" })
map("n", "]d", function()
  vim.diagnostic.jump({ count = 1 })
end, { desc = "Next diagnostic" })
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostics" })

-- Save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- New file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New file" })

-- Terminal escape
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Add undo break-points
map("i", ",", ",<c-g>u", { desc = "Undo break-point" })
map("i", ".", ".<c-g>u", { desc = "Undo break-point" })
map("i", ";", ";<c-g>u", { desc = "Undo break-point" })

-- Entire buffer textobject (ag/ig)
map({ "x", "o" }, "ag", function()
  vim.cmd("normal! ggVG")
end, { desc = "Entire buffer" })
map({ "x", "o" }, "ig", function()
  vim.cmd("normal! ggVG")
end, { desc = "Entire buffer" })

-- Toggle wrap mode
map("n", "<leader>uw", "<cmd>Wrap<cr>", { desc = "Enable wrap mode" })

-- Straighten quotes
map("n", "<leader>cq", "<cmd>StraightenQuotes<cr>", { desc = "Straighten quotes" })

-- Neovim meta commands (<leader>n)
map("n", "<leader>nl", "<cmd>Lazy<cr>", { desc = "Lazy" })
map("n", "<leader>nn", "<cmd>messages<cr>", { desc = "Messages" })
map("n", "<leader>nc", "<cmd>checkhealth<cr>", { desc = "Checkhealth" })
map("n", "<leader>ne", function()
  require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Edit config" })
map("n", "<leader>np", "<cmd>Lazy profile<cr>", { desc = "Startup profile" })

-- Sort with motion
map("n", "gS", function()
  vim.o.operatorfunc = "v:lua._sort_motion"
  return "g@"
end, { expr = true, desc = "Sort with motion" })
map("v", "gS", ":sort<cr>", { desc = "Sort selection" })

function _G._sort_motion(type)
  local start_line = vim.fn.line("'[")
  local end_line = vim.fn.line("']")
  vim.cmd(start_line .. "," .. end_line .. "sort")
end
