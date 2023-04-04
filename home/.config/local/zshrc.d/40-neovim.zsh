#shellcheck shell=zsh

# NeoVim over Vim where available
if builtin whence nvim &> /dev/null; then
  alias nv=nvim
  alias vim=nvim
  export EDITOR=nvim
fi
