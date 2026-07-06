# Login-shell environment. Runs once per login shell (new terminals + tmux panes).
# PATH lives here, not .zshrc, so it does not re-prepend on nested interactive shells.

# Homebrew: puts brew's bin/sbin on PATH, sets MANPATH/INFOPATH.
if [[ $OS == macos ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ $OS == linux ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Collapse duplicate PATH entries.
typeset -U path PATH

# Homebrew's rustup is keg-only; its cargo/rustc shims live here.
[[ -d "$HOMEBREW_PREFIX/opt/rustup/bin" ]] && export PATH="$HOMEBREW_PREFIX/opt/rustup/bin:$PATH"

export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.nix-profile/bin:$PATH"
