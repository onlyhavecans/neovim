#shellcheck shell=zsh

# NeoVim over Vim where available
if builtin whence nvim &> /dev/null; then
  alias v=nvim
  export EDITOR=nvim
fi
