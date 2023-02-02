#shellcheck shell=zsh

# NeoVim over Vim where available
if builtin whence nvim &> /dev/null; then
  alias n=nvim
  export EDITOR=nvim
fi
