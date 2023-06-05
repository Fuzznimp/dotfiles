source ${HOME}/workspace/dotfiles/zsh/.constants
source ${HOME}/workspace/dotfiles/zsh/.prompt
source ${HOME}/workspace/dotfiles/zsh/.highlights
source ${HOME}/workspace/dotfiles/zsh/.history
source ${HOME}/workspace/dotfiles/zsh/.completion
source ${HOME}/workspace/dotfiles/zsh/.aliases
source ${HOME}/workspace/dotfiles/zsh/.functions
source ${HOME}/.cargo/env
[ -f ~/.fzf.zsh ] && source  ${HOME}/.zsh

bindkey -e
autoload -U edit-command-line;
zle -N edit-command-line;
bindkey '^F' edit-command-line # Edit current line with C-f
bindkey '^[[1;3D' backward-word # Alt-Left
bindkey '^[[1;3C' forward-word # Alt-Right
bindkey '^[[3~' delete-char # Delete
bindkey '^[[Z' reverse-menu-complete # Ctrl-r

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

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
# export DOCKER_HOST=unix://$HOME/.colima/docker.sock

# export PATH="${HOME}/.pyenv/shims:${PATH}"

# Source last
source ${HOME}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
