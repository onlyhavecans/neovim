#shellcheck shell=zsh

# NeoVim over Vim where available
if builtin whence nvim &> /dev/null; then
  alias n=nvim
  alias v=vim
  alias vim=nvim
  export EDITOR=nvim
fi
