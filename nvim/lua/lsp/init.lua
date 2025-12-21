-- LSP Setup using native API

local M = {}

-- Configure diagnostics display
vim.diagnostic.config({
  underline = true,
  update_in_insert = false,
  virtual_text = {
    spacing = 2,
    source = "if_many",
    prefix = "●",
  },
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
    },
  },
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = true,
  },
})

-- Shared on_attach function for all LSP servers
local function on_attach(client, bufnr)
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end

  -- LSP keymaps
  map("n", "K", vim.lsp.buf.hover, "Hover")
  map("n", "gK", vim.lsp.buf.signature_help, "Signature Help")
  map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature Help")
  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")
  map("n", "<leader>cr", vim.lsp.buf.rename, "Rename")
  map("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")

  -- Inlay hints (enabled by default)
  if client:supports_method("textDocument/inlayHint") then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    map("n", "<leader>uh", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
    end, "Toggle Inlay Hints")
  end

  -- CodeLens
  if client:supports_method("textDocument/codeLens") then
    vim.lsp.codelens.refresh({ bufnr = bufnr })
    vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
      buffer = bufnr,
      callback = function()
        vim.lsp.codelens.refresh({ bufnr = bufnr })
      end,
    })
    map("n", "<leader>cl", vim.lsp.codelens.run, "Run CodeLens")
  end

  -- Document highlight on cursor hold
  if client:supports_method("textDocument/documentHighlight") then
    local highlight_augroup = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = highlight_augroup,
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      group = highlight_augroup,
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
    vim.api.nvim_create_autocmd("LspDetach", {
      group = vim.api.nvim_create_augroup("lsp_document_highlight_detach", { clear = true }),
      callback = function(ev)
        vim.lsp.buf.clear_references()
        vim.api.nvim_clear_autocmds({ group = "lsp_document_highlight", buffer = ev.buf })
      end,
    })
  end
end

-- Get capabilities with completion support
local function get_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  -- Add folding range capability
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  -- Try to get blink.cmp capabilities
  local has_blink, blink = pcall(require, "blink.cmp")
  if has_blink then
    capabilities = blink.get_lsp_capabilities(capabilities)
  end

  return capabilities
end

-- Setup all servers
function M.setup_all()
  local servers = require("lsp.servers")
  local capabilities = get_capabilities()

  -- Create LspAttach autocommand for keymaps
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp_attach_keymaps", { clear = true }),
    callback = function(event)
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client then
        on_attach(client, event.buf)
      end
    end,
  })

  -- Configure and enable each server
  for server_name, config in pairs(servers) do
    local server_config = vim.tbl_deep_extend("force", {
      capabilities = capabilities,
    }, config or {})

    vim.lsp.config(server_name, server_config)
    vim.lsp.enable(server_name)
  end
end

return M
