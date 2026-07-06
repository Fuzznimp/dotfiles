ZSH_PATH="${HOME}/workspace/dotfiles/zsh"

source ${ZSH_PATH}/.constants
source ${ZSH_PATH}/.prompt
source ${ZSH_PATH}/.highlights
source ${ZSH_PATH}/.history
source ${ZSH_PATH}/.completion
source ${ZSH_PATH}/.aliases
source ${ZSH_PATH}/.functions
source ${ZSH_PATH}/.keybindings

export XDG_CONFIG_HOME=$HOME/.config

# Tells lazydocker where to find the docker socket when using Colima (macOS).
# On WSL2, Docker Desktop provides the default socket, so leave DOCKER_HOST unset.
[[ $OS == macos ]] && export DOCKER_HOST="unix://$HOME/.colima/docker.sock"

export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'

command -v zoxide >/dev/null && eval "$(zoxide init zsh)"
command -v atuin >/dev/null && eval "$(atuin init zsh)"
command -v fzf >/dev/null && eval "$(fzf --zsh)"

# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
# End Nix

command -v direnv >/dev/null && eval "$(direnv hook zsh)"

# $HOMEBREW_PREFIX is exported by `brew shellenv` in .zprofile (macOS or Linux).
BREW_SHARE="$HOMEBREW_PREFIX/share"

source "$BREW_SHARE/zsh-autosuggestions/zsh-autosuggestions.zsh"

# Source last
source "$BREW_SHARE/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
