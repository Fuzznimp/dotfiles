# Platform detected once, from zsh's built-in $OSTYPE (no subprocess).
# Referenced as $OS by .zprofile and .zshrc so OS branches stay one-liners.
case "$OSTYPE" in
  darwin*) export OS=macos ;;
  linux*)  export OS=linux ;;
esac

[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"
