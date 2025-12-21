# Squirrel Neovim

Hi! I'm a squirrel and I use Neovim all day so I have quite the setup squirreled away here.

## Philosophy

- Speed is more important than features
- UX/UI is important
- Explicit is better than implicit, put documentation inline
- The less configuration the better
- Make the configuration & code easy to navigate & read
- Use the most out of builtin before using plugins

## Goals

- Fast startup, navigation, and editing
- All keymaps registered with Which-Key for discoverability
- Polished UI: statusline, bufferline, dashboard, navigation tree
- Full Treesitter & LSP coverage for languages I use
- Complete git integration
- Formatters and linters where needed

## Non-Goals

- Supporting previous Neovim versions
- IDE-level features (heavy refactoring tools, project managers)
- Plugin managers that auto-update without review
- Managing external tooling (LSPs, formatters, linters) inside Neovim

## Requirements

- Neovim 0.11+
- External tools (not managed by Neovim):
  - LSP servers: lua\_ls, gopls, rust\_analyzer, basedpyright, ruff, etc.
  - Formatters: stylua, gofmt, prettier, shfmt, etc.
  - Linters: shellcheck, golangci-lint, yamllint, etc.
  - Debug adapters: delve, debugpy, codelldb
  - Utilities: ripgrep, fzf, fd

## Structure

```text
nvim/
├── init.lua                 # Entry point
├── lua/
│   ├── core/                # Options, keymaps, autocmds, filetypes
│   ├── lsp/                 # LSP setup and server configurations
│   └── plugins/             # Plugin specs (lazy.nvim)
│       └── lang/            # Language-specific plugins
├── after/ftplugin/          # Filetype-specific settings
└── snippets/                # Custom snippets

home/bin/                    # Helper scripts
```

## Helper Scripts

Small utilities in `home/bin/` that complement this setup:

| Script    | Purpose                                        |
| ---       | ---                                            |
| neovenv   | Build & upgrade Neovim's dedicated Python venv |
| ngchanged | Open all uncommitted changed files             |
| ngreview  | Open all changed files in current branch       |

## Homeshick

This repo is designed for use with [homeshick](https://github.com/andsens/homeshick).

Instead of linking individual files, this repo uses a homeshick trick: the `./home/.config/nvim` symlink points to `../../nvim`, causing homeshick to link `~/.config/nvim` directly to the `nvim/` directory in this repo.
