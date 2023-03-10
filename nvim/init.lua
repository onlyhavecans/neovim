-- [[ Preamble Disable things ]]
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.python3_host_prog = '~/.local/nvim/venv/bin/python3'

-- [[ Packer ]]
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'

  -- Managing Mason
  use {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    requires = { 'williamboman/mason.nvim' },
  }

  -- LSP Configuration & Plugins
  use {
    'neovim/nvim-lspconfig',
    requires = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      'j-hui/fidget.nvim',

      -- Additional lua configuration, makes nvim stuff amazing
      'folke/neodev.nvim',
    },
  }

  -- linters and formatters by ls
  use 'jose-elias-alvarez/null-ls.nvim'

  -- Additional Language tools
  use 'danihodovic/vim-ansible-vault'
  use 'simrat39/rust-tools.nvim'
  use 'LokiChaos/vim-tintin'
  use 'dougireton/vim-chef'
  use 'fladson/vim-kitty'
  use 'direnv/direnv.vim'
  use 'rizzatti/dash.vim'

  -- Cargo.toml experiance
  use {
    'saecki/crates.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } },
  }

  -- Autocompletion
  use {
    'hrsh7th/nvim-cmp',
    requires = { 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-path', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  }

  -- Highlight, edit, and navigate code
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  }

  -- Additional text objects via treesitter
  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }

  -- Git related plugins
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'lewis6991/gitsigns.nvim'

  use 'tanvirtin/monokai.nvim'
  use 'navarasu/onedark.nvim' -- Theme inspired by Atom
  use 'nvim-lualine/lualine.nvim' -- Fancier statusline
  use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
  use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically
  use 'tpope/vim-eunuch' -- First class unix commands
  use 'tpope/vim-obsession' -- Session management

  use { 'kylechui/nvim-surround', tag = '*' }
  use { 'junegunn/vim-easy-align', on = { '<Plug>(EasyAlign)' } }

  -- Navigation
  use 'christoomey/vim-tmux-navigator'
  use 'jremmen/vim-ripgrep'
  use {
    'nvim-tree/nvim-tree.lua',
    tag = 'nightly', -- optional, updated every week. (see issue #1193)
  }

  -- Fuzzy Finder (files, lsp, etc)
  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }

  -- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
  local has_plugins, plugins = pcall(require, 'custom.plugins')
  if has_plugins then
    plugins(use)
  end

  if is_bootstrap then
    require('packer').sync()
  end
end)

-- [[ Bootstrapping ]]
-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | silent! LspStop | silent! LspStart | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})

-- [[ Setting options ]]
-- See `:help vim.o`

-- macOS clipboard
vim.opt.clipboard:append 'unnamedplus'

-- No wrapping by default
vim.opt.wrap = false

-- Set highlight on search
vim.opt.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.opt.mouse = 'a'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Always keep my cursor centered and highlighted
vim.opt.scrolloff = 5
vim.opt.cursorline = true

-- Strict default whitespace settings
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true

-- Decrease update time
vim.opt.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set completeopt to have a better completion experience
vim.opt.completeopt = 'menuone,noselect'

-- Terminal settings
vim.opt.shell = 'zsh --login'
vim.api.nvim_create_autocmd('TermOpen', { pattern = '*', command = 'setlocal nonumber norelativenumber' })

-- Set colorscheme
vim.opt.termguicolors = true
require('monokai').setup { palette = require('monokai').pro }

-- [[ GUI settings ]]
vim.opt.guifont = { 'PragmataPro_Mono_Liga_Regular:h16' }
if vim.g.neovide then
  vim.opt.guifont = { 'PragmataPro_Mono_Liga:h16' }
  vim.g.neovide_hide_mouse_when_typing = true
end

-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- quick close
vim.keymap.set('n', 'XX', ':qall!<CR>')

-- a shortcut to make saving less annoying
vim.keymap.set('n', 's', ':w<CR>')

-- Faster splits
vim.keymap.set('n', '|', ':vsplit<CR>')
vim.keymap.set('n', '_', ':split<CR>')

-- The F-Keys
-- Toggle line numbers
vim.keymap.set('n', '<F2>', ':set number!<CR>')
-- Toggle Tree
vim.keymap.set('n', '<F3>', ':NvimTreeToggle<CR>')
-- cd to the current file
vim.keymap.set('n', '<F4>', ':cd %:p:h<CR>:pwd<CR>')
-- rename
vim.keymap.set('n', '<F6>', vim.lsp.buf.rename)

-- EasyAlign settings Enter activation, and ga movement
vim.keymap.set('v', '<Enter>', '<Plug>(EasyAlign)', { remap = true })
vim.keymap.set({ 'x', 'n' }, 'ga', '<Plug>(EasyAlign)')

-- Dash for lookups
vim.keymap.set('n', '<Leader>d', '<Plug>DashSearch', { silent = true })

-- Quick open a bottom terminal for commands
vim.keymap.set('n', '<Leader>o', ':botright 20split +term<CR>i')

-- Tab Navigation Navigation
vim.keymap.set('n', '<Leader>]', ':tabnext<CR>')
vim.keymap.set('n', '<Leader>[', ':-tabnext<CR>')
vim.keymap.set('n', '<Leader>t', ':tabnew<CR>')
vim.keymap.set('n', '<Leader>w', ':tabclose<CR>')

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- Open settings
vim.keymap.set('n', '<leader>,', ':tabnew $MYVIMRC<CR>')

-- [[ Commands ]]
-- Automatically strip trailing spaces on save
vim.api.nvim_create_autocmd('BufWritePre', { pattern = '*', command = '%s/\\s\\+$//e' })

-- Quit all shorthand
vim.api.nvim_create_user_command('QUIT', 'qall', { bang = true })

-- My personalized Wrap
local wrap = function()
  vim.opt.wrap = true
  vim.opt.linebreak = true
  vim.opt.list = false
  vim.opt.showbreak = '???'
end
vim.api.nvim_create_user_command('Wrap', wrap, { bang = true, desc = 'Enable Preferred Line Wrap' })

vim.api.nvim_create_user_command('LG', ':silent !tmux new-window -a -c %:p:h lazygit', { desc = 'Open current file dir in lazygit' })
vim.api.nvim_create_user_command('SMERGE', ':silent !smerge %:p:h', { desc = 'Open current file dir in sublime merge' })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank { timeout = 3000 }
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Statusline ]]
-- Set lualine as statusline
-- See `:help lualine.txt`
require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'auto',
    component_separators = { left = '???', right = '???' },
    section_separators = { left = '???', right = '???' },
  },
}

-- [[ Comment.vim ]]
-- Enable Comment.nvim
require('Comment').setup()

-- [[ Gitsigns ]]
-- See `:help gitsigns.txt`
require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '???' },
    changedelete = { text = '~' },
  },
  attach_to_untracked = false,
}

-- [[ Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

vim.keymap.set('n', '<leader>p', function()
  require('telescope.builtin').find_files { follow = true, hidden = true }
end, { desc = '[S]earch [F]iles' })

vim.keymap.set('n', '<leader>sf', function()
  require('telescope.builtin').find_files { follow = true, hidden = true }
end, { desc = '[S]earch [F]iles' })

vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- [[ Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = {
    'bash',
    'css',
    'diff',
    'dockerfile',
    'go',
    'gosum',
    'help',
    'javascript',
    'json',
    'lua',
    'make',
    'markdown',
    'python',
    'ruby',
    'rust',
    'toml',
    'vim',
    'yaml',
  },
  highlight = { enable = true },
  indent = { enable = true, disable = { 'python' } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<c-backspace>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

-- [[ LSP Shared ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<Leader>k', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')
end

-- Turn on lsp status information
require('fidget').setup()

-- [[ LSP Mason ]]
-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  bashls = {},
  jsonls = {},
  pyright = {},
  quick_lint_js = {},
  solargraph = {},
  yamlls = {},
  gopls = {
    gopls = {
      staticcheck = true,
      gofumpt = true,
    },
  },
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup {
  pip = { upgrade_pip = true },
}

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

-- Automatically keep LSP tools up to date
require('mason-tool-installer').setup {
  ensure_installed = {
    'bash-language-server',
    'json-lsp',
    'yaml-language-server',
    'gopls',
    'pyright',
    'rust-analyzer',
  },
  auto_update = true,
  run_on_start = true,
  start_delay = 3000, -- 3 second delay
  debounce_hours = 24, -- at least 24 hours between attempts to install/update
}

-- Notify when tools are being updated
vim.api.nvim_create_autocmd('User', {
  pattern = 'MasonToolsStartingInstall',
  callback = function()
    vim.schedule(function()
      print 'mason-tool-installer is starting'
    end)
  end,
})
vim.api.nvim_create_autocmd('User', {
  pattern = 'MasonToolsUpdateCompleted',
  callback = function()
    vim.schedule(function()
      print 'mason-tool-installer has finished'
    end)
  end,
})

-- [[ LSP Rust-tools ]]
-- Setup Rust tools
local rt = require 'rust-tools'
rt.setup {
  tools = {
    on_initialized = function()
      vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufEnter', 'CursorHold', 'InsertLeave' }, {
        pattern = { '*.rs' },
        callback = function()
          vim.lsp.codelens.refresh()
        end,
      })
    end,
    hover_actions = {
      auto_focus = true,
    },
  },
  server = {
    standalone = false,
    -- Use Mason's on attach for all my keymaps
    on_attach = on_attach,
    -- I really want to port this custom hover action
    --   function(_, bufnr)
    --   vim.keymap.set('n', 'K', rt.hover_actions.hover_actions, { buffer = bufnr })
    -- end,
    ['rust-analyzer'] = {
      lens = {
        enable = true,
      },
      checkOnSave = {
        command = 'clippy',
      },
    },
  },
}

require('crates').setup {
  null_ls = {
    enabled = true,
    name = 'crates.nvim',
  },
}

-- [[ LSP Null-ls ]]
local null_ls = require 'null-ls'

null_ls.setup {
  sources = {
    null_ls.builtins.diagnostics.ansiblelint,
    null_ls.builtins.diagnostics.dotenv_linter,
    null_ls.builtins.diagnostics.golangci_lint,
    null_ls.builtins.diagnostics.markdownlint,
    null_ls.builtins.diagnostics.rubocop,
    null_ls.builtins.diagnostics.ruff,
    null_ls.builtins.diagnostics.sqlfluff,
    null_ls.builtins.diagnostics.tidy,
    null_ls.builtins.diagnostics.todo_comments,
    null_ls.builtins.diagnostics.yamllint,
    null_ls.builtins.diagnostics.zsh,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.stylua,
  },
}

local ufmt = {
  method = null_ls.methods.FORMATTING,
  filetypes = { 'python' },
  generator = null_ls.formatter {
    command = 'ufmt',
    args = { 'format', '-' },
    to_stdin = true,
  },
}
null_ls.register(ufmt)

-- [[ LSP formatting ]]
-- Set up this so it can be shared between all the lsps
local format_sync_grp = vim.api.nvim_create_augroup('LspFormat', {})
local do_format = function()
  vim.lsp.buf.format { timeout_ms = 3000 }
end

-- Auto-format rust and go on save
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.rs', '*.go' },
  callback = do_format,
  group = format_sync_grp,
})

local auto_format = function(_)
  local bufnr = vim.nvim_get_current_buf
  vim.api.nvim_clear_autocmds { group = format_sync_grp, buffer = bufnr }
  vim.api.nvim_create_autocmd('BufWritePre', {
    group = format_sync_grp,
    buffer = bufnr,
    callback = do_format,
  })
end

-- Create a command `:Format` local to the LSP buffer
vim.api.nvim_create_user_command('Format', do_format, { desc = 'Format current buffer with LSP' })
-- Create a command `:AFormat` local to the LSP buffer
vim.api.nvim_create_user_command('AFormat', auto_format, { desc = 'Enable Format on Save for current buffer with LSP' })

-- [[ nvim-cmp setup ]]
local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
  },
}

-- [[ nvim-tree ]]
require('nvim-tree').setup {}

-- [[ Surround ]]
require('nvim-surround').setup()

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
