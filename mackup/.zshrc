source ${HOME}/workspace/dotfiles/zsh/.constants
source ${HOME}/workspace/dotfiles/zsh/.prompt
source ${HOME}/workspace/dotfiles/zsh/.highlights
source ${HOME}/workspace/dotfiles/zsh/.history
source ${HOME}/workspace/dotfiles/zsh/.completion
source ${HOME}/workspace/dotfiles/zsh/.aliases
source ${HOME}/workspace/dotfiles/zsh/.functions
source ${HOME}/workspace/dotfiles/zsh/.keybindings
source ${HOME}/.cargo/env

[ -f ~/.fzf.zsh ] && source  ${HOME}/.zsh

bindkey '^ ' autosuggest-accept

export PATH=/opt/homebrew/bin:$PATH
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -l -g ""'

eval "$(zoxide init zsh)"
eval "$(atuin init zsh)"
export PATH=$PATH:/Users/anthonymontaigne/.nix-profile/bin/direnv
eval "$(direnv hook zsh)"

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

source /Users/anthonymontaigne/.docker/init-zsh.sh || true # Added by Docker Desktop
# Colima + Lazydocker
export DOCKER_HOST=unix://$HOME/.colima/docker.sock

# Nix
export PATH=$HOME/.nix-profile/bin:$PATH

# Source last
source ${HOME}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
