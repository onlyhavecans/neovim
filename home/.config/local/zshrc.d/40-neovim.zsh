#shellcheck shell=sh

# NeoVim over Vim where available
if builtin whence nvim &> /dev/null; then
  alias vim=nvim
  export EDITOR=nvim
fi
