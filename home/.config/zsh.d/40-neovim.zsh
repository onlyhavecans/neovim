#shellcheck shell=zsh

if builtin whence nvim &>/dev/null; then
  alias n=nvim
  export EDITOR=nvim
fi
