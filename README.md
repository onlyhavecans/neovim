## Squirrel NeoVim

## Homeshick Repo

This repo is designed for use with [homeshick](https://github.com/andsens/homeshick) and contains all my NeoVim configurations and associated hooks.

I have this separate from my general dotfiles since I don't need all this, or even all of NeoVim on all machines I touch. Sometimes a bit of vi works fine.

Instead of linking all the various files, I use a homeshick trick where I make homeshick link the `nvim` directory in the root of this repo to `~/.config/nvim` by creating the `./home/.config/nvim` symlink inside this repo to `../../nvim`.

## Apps

I do have a few small apps that I use with NeoVim installed in `home/bin`.
Highlights are:

- neovenv: a tool to build & upgrade my python venv I use for the neovim python host.

## ZSH integration

- I use a custom zsh include to set up NeoVim as my editor. This file is in `home/.config/local/zshrc.d/`.

## Base Configuration

My configurations is based around [LazyVim](https://www.lazyvim.org) because I appreciate an opinionated IDE.

I like batteries included and a nice preconfigured setup to kick off of so I don't need to spend weeks customizing.
NeoVim w/ LazyVim strikes the perfect balance of modern treesitter/LSP native integration, community support, and speed/clean interface.

## Major Tweaks to Note
