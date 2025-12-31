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

  -- JavaScript
  quick_lint_js = {},

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
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
      },
    },
  },

  -- Rust
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true,
        },
        checkOnSave = {
          command = "clippy",
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

  -- Markdown
  marksman = {},

  -- Docker
  docker_language_server = {},
  docker_compose_language_service = {},
}
