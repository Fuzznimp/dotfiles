# Login-shell environment. Runs once per login shell (new terminals + tmux panes).
# PATH lives here, not .zshrc, so it does not re-prepend on nested interactive shells.

# Homebrew: puts /opt/homebrew/{bin,sbin} on PATH, sets MANPATH/INFOPATH.
eval "$(/opt/homebrew/bin/brew shellenv)"

# Collapse duplicate PATH entries.
typeset -U path PATH

export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.nix-profile/bin:$PATH"
