-- Navigation plugins: fuzzy finder, file explorer, tmux integration

return {
  -- fzf-lua (fuzzy finder)
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "FzfLua",
    ---@module "fzf-lua"
    ---@type fzf-lua.Config|{}
    ---@diagnostics disable: missing-fields
    opts = {
      -- Use profile with centered titles
      "default-title",
      files = {
        cwd_prompt = false,
      },
      -- Register as vim.ui.select handler
      ui_select = {},
      -- Keymaps inside fzf window
      keymap = {
        fzf = {
          ["ctrl-q"] = "select-all+accept", -- send all to quickfix
          ["ctrl-u"] = "half-page-up",
          ["ctrl-d"] = "half-page-down",
          ["ctrl-f"] = "preview-page-down",
          ["ctrl-b"] = "preview-page-up",
        },
      },
    },
    ---@diagnostics enable: missing-fields
    config = function(_, opts)
      require("fzf-lua").setup(opts)
    end,
    keys = {
      -- Global picker (files + buffers + symbols with prefix filtering)
      { "<leader><space>", "<cmd>FzfLua global<cr>", desc = "Global picker" },
      -- Files (f = file operations)
      { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find files" },
      { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent files" },
      { "<leader>,", "<cmd>FzfLua buffers<cr>", desc = "Switch buffer" },
      -- Search (s = search in content)
      { "<leader>/", "<cmd>FzfLua live_grep<cr>", desc = "Live grep" },
      { "<leader>sw", "<cmd>FzfLua grep_cword<cr>", desc = "Grep word" },
      { "<leader>sW", "<cmd>FzfLua grep_cWORD<cr>", desc = "Grep WORD" },
      { "<leader>ss", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "Document symbols" },
      { "<leader>sS", "<cmd>FzfLua lsp_workspace_symbols<cr>", desc = "Workspace symbols" },
      { "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Document diagnostics" },
      { "<leader>sD", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace diagnostics" },
      { "<leader>sh", "<cmd>FzfLua help_tags<cr>", desc = "Help tags" },
      { "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "Keymaps" },
      { "<leader>sm", "<cmd>FzfLua marks<cr>", desc = "Marks" },
      { "<leader>sR", "<cmd>FzfLua resume<cr>", desc = "Resume last search" },
      { "<leader>sc", "<cmd>FzfLua commands<cr>", desc = "Commands" },
      { "<leader>:", "<cmd>FzfLua command_history<cr>", desc = "Command history" },
      -- Jump (j = pickers over lists of locations)
      { "<leader>jj", "<cmd>FzfLua git_status<cr>", desc = "Modified & untracked files" },
      { "<leader>jf", "<cmd>FzfLua files<cr>", desc = "Files" },
      { "<leader>jg", "<cmd>FzfLua git_files<cr>", desc = "Git tracked files" },
      { "<leader>jr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent files" },
      { "<leader>jb", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
      { "<leader>jt", "<cmd>FzfLua tabs<cr>", desc = "Tabs" },
      { "<leader>jq", "<cmd>FzfLua quickfix<cr>", desc = "Quickfix list" },
      { "<leader>jl", "<cmd>FzfLua loclist<cr>", desc = "Location list" },
      { "<leader>jm", "<cmd>FzfLua marks<cr>", desc = "Marks" },
      { "<leader>ju", "<cmd>FzfLua jumps<cr>", desc = "Jumplist" },
      { "<leader>jc", "<cmd>FzfLua changes<cr>", desc = "Changelist" },
      { "<leader>jB", "<cmd>FzfLua git_branches<cr>", desc = "Git branches" },
      { "<leader>jL", "<cmd>FzfLua lines<cr>", desc = "Lines in open buffers" },
      -- Git
      { "<leader>gc", "<cmd>FzfLua git_commits<cr>", desc = "Git commits" },
      -- LSP go-to
      { "gd", "<cmd>FzfLua lsp_definitions<cr>", desc = "Go to definition" },
      { "gr", "<cmd>FzfLua lsp_references<cr>", desc = "References" },
      { "gI", "<cmd>FzfLua lsp_implementations<cr>", desc = "Go to implementation" },
      { "gy", "<cmd>FzfLua lsp_typedefs<cr>", desc = "Go to type definition" },
    },
  },

  -- yazi.nvim (file explorer with git integration)
  {
    "mikavilpas/yazi.nvim",
    version = "*",
    event = "VeryLazy",
    dependencies = {
      { "nvim-lua/plenary.nvim", lazy = true },
    },
    cmd = "Yazi",
    keys = {
      { "<leader>E", "<cmd>Yazi cwd<cr>", desc = "Open Yazi in CWD" },
      { "<leader>e", mode = { "n", "v" }, "<cmd>Yazi<cr>", desc = "Reveal in Yazi" },
      { "<c-up>", "<cmd>Yazi toggle<cr>", desc = "Resume last yazi session" },
    },
  },

  -- nvim-tmux-navigation
  {
    "alexghergh/nvim-tmux-navigation",
    event = "VeryLazy",
    opts = {
      disable_when_zoomed = true,
    },
    keys = {
      { "<C-h>", "<cmd>NvimTmuxNavigateLeft<cr>", desc = "Go to left window" },
      { "<C-j>", "<cmd>NvimTmuxNavigateDown<cr>", desc = "Go to lower window" },
      { "<C-k>", "<cmd>NvimTmuxNavigateUp<cr>", desc = "Go to upper window" },
      { "<C-l>", "<cmd>NvimTmuxNavigateRight<cr>", desc = "Go to right window" },
    },
  },
}
