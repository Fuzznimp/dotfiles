ZSH_PATH="${HOME}/workspace/dotfiles/zsh"

source ${ZSH_PATH}/.constants
source ${ZSH_PATH}/.prompt
source ${ZSH_PATH}/.highlights
source ${ZSH_PATH}/.history
source ${ZSH_PATH}/.completion
source ${ZSH_PATH}/.aliases
source ${ZSH_PATH}/.functions
source ${ZSH_PATH}/.keybindings
source ${HOME}/.cargo/env

XDG_CONFIG_HOME=$HOME/.config

# Tells lazydocker where to find the docker socket when using Colima.
export DOCKER_HOST="unix://$HOME/.colima/docker.sock"

export PATH=/opt/homebrew/bin:$PATH
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -l -g ""'

eval "$(zoxide init zsh)"
eval "$(atuin init zsh)"
eval "$(fzf --zsh)"

# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
# End Nix
export PATH=$HOME/.nix-profile/bin:$PATH
eval "$(direnv hook zsh)"

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Source last
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
