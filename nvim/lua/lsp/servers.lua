-- LSP Server configurations
-- Add new servers here - they will be automatically set up

return {
  basedpyright = {},
  ty = {},
  ruff = {
    on_attach = function(client, _)
      client.server_capabilities.hoverProvider = false
    end,
  },

  -- TypeScript / JavaScript
  vtsls = {
    settings = {
      vtsls = {
        autoUseWorkspaceTsdk = true,
      },
      typescript = {
        updateImportsOnFileMove = { enabled = "always" },
        inlayHints = {
          parameterNames = { enabled = "all" },
          parameterTypes = { enabled = true },
          variableTypes = { enabled = true },
          propertyDeclarationTypes = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
          enumMemberValues = { enabled = true },
        },
        suggest = {
          completeFunctionCalls = true,
        },
        preferences = {
          includePackageJsonAutoImports = "auto",
        },
      },
      javascript = {
        updateImportsOnFileMove = { enabled = "always" },
        inlayHints = {
          parameterNames = { enabled = "all" },
          parameterTypes = { enabled = true },
          variableTypes = { enabled = true },
          propertyDeclarationTypes = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
          enumMemberValues = { enabled = true },
        },
        suggest = {
          completeFunctionCalls = true,
        },
      },
    },
    capabilities = {
      general = {
        positionEncodings = { "utf-16" },
      },
    },
  },

  -- Nix
  nixd = {},
  nil_ls = {},

  -- TOML
  tombi = {},

  -- Lua (for Neovim config)
  lua_ls = {
    settings = {
      Lua = {
        workspace = {
          checkThirdParty = false,
        },
        codeLens = {
          enable = true,
        },
        completion = {
          callSnippet = "Replace",
        },
        diagnostics = {
          globals = { "vim" },
        },
        telemetry = {
          enable = false,
        },
      },
    },
  },

  -- Go
  gopls = {
    settings = {
      gopls = {
        gofumpt = true,
        staticcheck = true,
        usePlaceholders = true,
        completeUnimported = true,
        directoryFilters = { "-.git", "-node_modules", "-.idea", "-.vscode" },
        codelenses = {
          gc_details = false,
          generate = true,
          regenerate_cgo = true,
          run_govulncheck = true,
          test = true,
          tidy = true,
          upgrade_dependency = true,
          vendor = true,
        },
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
        analyses = {
          unusedparams = true,
          nilness = true,
          unusedwrite = true,
          useany = true,
        },
      },
    },
  },

  -- Rust
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true,
          loadOutDirsFromCheck = true,
          buildScripts = {
            enable = true,
          },
        },
        check = {
          command = "clippy",
        },
        procMacro = {
          enable = true,
        },
        files = {
          excludeDirs = { ".git", "target", "node_modules", ".direnv", ".flatpak-builder" },
        },
      },
    },
  },

  -- Terraform
  terraformls = {},

  -- YAML
  yamlls = {
    settings = {
      yaml = {
        schemaStore = {
          enable = false,
          url = "",
        },
        schemas = require("schemastore").yaml.schemas(),
      },
    },
  },

  -- JSON
  jsonls = {
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  },

  -- Bash
  bashls = {},

  -- Fish
  fish_lsp = {},

  -- Markdown
  marksman = {},

  -- Docker
  docker_language_server = {},
  docker_compose_language_service = {},
}
