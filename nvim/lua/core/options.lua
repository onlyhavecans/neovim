-- Core Neovim options
-- Must be loaded BEFORE lazy.nvim

-- Leader keys (must be set before lazy)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Disable unused providers (speeds up startup, removes healthcheck warnings)
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = false
opt.signcolumn = "yes" -- Always show sign column to prevent text shifting
opt.cursorline = true -- Highlight current line
opt.showmode = false -- Don't show mode in cmdline (lualine shows it)
opt.laststatus = 3 -- Global statusline (single line for all splits)
opt.cmdheight = 1 -- Command line height
opt.pumheight = 10 -- Max items in popup menu
opt.smoothscroll = true -- Smooth scrolling with ctrl-d/u

-- Indentation
opt.tabstop = 2 -- Tab character width
opt.shiftwidth = 2 -- Indent width
opt.softtabstop = 2 -- Tab key inserts this many spaces
opt.smarttab = true -- Tab at line start uses shiftwidth
opt.expandtab = true -- Convert tabs to spaces
opt.smartindent = true -- Auto-indent new lines
opt.shiftround = true -- Round indent to multiple of shiftwidth

-- Search
opt.ignorecase = true -- Case-insensitive search
opt.smartcase = true -- Case-sensitive if uppercase in pattern
opt.hlsearch = true -- Highlight search matches
opt.incsearch = true -- Show matches as you type

-- Editing
opt.clipboard = "unnamedplus" -- Use system clipboard
opt.undofile = true -- Persistent undo history
opt.undolevels = 10000 -- Maximum undo steps
opt.swapfile = false -- No swap files (rely on undo)
opt.backup = false -- No backup files
opt.writebackup = false -- No backup before overwriting
opt.confirm = true -- Confirm before closing unsaved buffers

-- Windows and splits
opt.splitright = true -- New vertical splits open right
opt.splitbelow = true -- New horizontal splits open below
opt.splitkeep = "screen" -- Keep screen position when splitting

-- Scrolling
opt.scrolloff = 8 -- Lines to keep above/below cursor
opt.sidescrolloff = 1 -- Columns to keep left/right of cursor

-- Folding disabled
opt.foldenable = false

-- Timing
opt.updatetime = 200 -- Faster CursorHold events (default 4000)
opt.timeoutlen = 300 -- Faster key sequence completion

-- Mouse
opt.mouse = "a" -- Enable mouse in all modes

-- Completion
opt.completeopt = "menu,menuone,noselect" -- Completion menu behavior

-- Wrapping
opt.wrap = false -- No soft wrap by default
opt.linebreak = true -- Wrap at word boundaries when wrap enabled
opt.breakindent = true -- Preserve indentation in wrapped lines

-- List chars (visible whitespace when list=true)
opt.list = true -- Show whitespace characters
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Grep program
opt.grepprg = "rg --vimgrep --smart-case"
opt.grepformat = "%f:%l:%c:%m"

-- Local config files
opt.exrc = true -- Read .nvim.lua, .nvimrc, .exrc in cwd
vim.g.editorconfig = true -- Respect .editorconfig files

-- Fill chars
opt.fillchars = { eob = " " } -- Hide ~ on empty lines

-- Wildmenu (command-line completion)
opt.wildmode = "longest:full,full" -- Complete longest common, then cycle
opt.wildignore:append({ "*.o", "*.obj", "*.pyc", "*.class", ".git", "node_modules" })
