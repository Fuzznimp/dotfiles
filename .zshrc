# Fig pre block. Keep at the top of this file.
. "$HOME/.fig/shell/zshrc.pre.zsh"
export HISTFILE=~/.zsh_history
export HISTFILESIZE=100000
export HISTSIZE=100000
setopt INC_APPEND_HISTORY
export HISTTIMEFORMAT="[%F %T] "
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE

autoload -U colors && colors

COMMON_PROMPT_SYMBOL="%{%G❯%}"
COMMON_COLORS_HOST_ME=green
COMMON_COLORS_HOST_AWS_VAULT=yellow
COMMON_COLORS_CURRENT_DIR=yellow
COMMON_COLORS_RETURN_STATUS_TRUE=green
COMMON_COLORS_RETURN_STATUS_FALSE=red
COMMON_COLORS_GIT_STATUS_DEFAULT=green
COMMON_COLORS_GIT_STATUS_STAGED=red
COMMON_COLORS_GIT_STATUS_UNSTAGED=yellow
COMMON_COLORS_GIT_PROMPT_SHA=green
COMMON_COLORS_BG_JOBS=yellow

# Host
common_host() {
  if [[ -n $SSH_CONNECTION ]]; then
    me="%n@%m"
  elif [[ $LOGNAME != $USER ]]; then
    me="%n"
  fi
  if [[ -n $me ]]; then
    echo "%{$fg[$COMMON_COLORS_HOST_ME]%}$me%{$reset_color%}:"
  fi
  if [[ $AWS_VAULT ]]; then
    echo "%{$fg[$COMMON_COLORS_HOST_AWS_VAULT]%}$AWS_VAULT%{$reset_color%} "
  fi
}

precmd () {print -Pn "\e]0;%~\a"}

# Current directory
common_current_dir() {
  echo -n "%{$fg[$COMMON_COLORS_CURRENT_DIR]%}%c "
}

# Prompt symbol
common_return_status() {
  echo -n "%(?.%F{$COMMON_COLORS_RETURN_STATUS_TRUE}.%F{$COMMON_COLORS_RETURN_STATUS_FALSE})$COMMON_PROMPT_SYMBOL%f "
}

# Git status
common_git_status() {
    local message=""
    local message_color="%F{$COMMON_COLORS_GIT_STATUS_DEFAULT}"

    # https://git-scm.com/docs/git-status#_short_format
    local staged=$(git status --porcelain 2>/dev/null | grep -e "^[MADRCU]")
    local unstaged=$(git status --porcelain 2>/dev/null | grep -e "^[MADRCU? ][MADRCU?]")

    if [[ -n ${staged} ]]; then
        message_color="%F{$COMMON_COLORS_GIT_STATUS_STAGED}"
    elif [[ -n ${unstaged} ]]; then
        message_color="%F{$COMMON_COLORS_GIT_STATUS_UNSTAGED}"
    fi

    local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if [[ -n ${branch} ]]; then
        message+="${message_color}%{%G%} ${branch}%f"
    fi

    echo -n "${message}"
}

# Icon git status
icon_git_status() {
    local message=""
    local message_color="%F{$COMMON_COLORS_GIT_STATUS_DEFAULT}"

    # https://git-scm.com/docs/git-status#_short_format
    local staged=$(git status --porcelain 2>/dev/null | grep -e "^[MADRCU]")
    local unstaged=$(git status --porcelain 2>/dev/null | grep -e "^[MADRCU? ][MADRCU?]")

    if [[ -n ${staged} ]]; then
        message_color="%F{$COMMON_COLORS_GIT_STATUS_STAGED}"
    elif [[ -n ${unstaged} ]]; then
        message_color="%F{$COMMON_COLORS_GIT_STATUS_UNSTAGED}"
    fi

    local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if [[ -n ${branch} ]]; then
        message+="${message_color}%{%G%}"
    fi

    echo -n "${message}"
}

# Git prompt SHA
ZSH_THEME_GIT_PROMPT_SHA_BEFORE="%{%F{$COMMON_COLORS_GIT_PROMPT_SHA}%}"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{$reset_color%} "

# Background Jobs
common_bg_jobs() {
  bg_status="%{$fg[$COMMON_COLORS_BG_JOBS]%}%(1j.↓%j .)"
  echo -n $bg_status
}

setopt PROMPT_SUBST
# precmd() { print "" }
PROMPT='$(common_host)$(common_current_dir)$(common_bg_jobs)$(common_git_status) $(common_return_status)'
# PROMPT='$(common_host)$(common_current_dir)$(common_bg_jobs)$(common_return_status)'
# RPROMPT='$(common_git_status)'

autoload -Uz compinit && compinit
# Completion for kitty
kitty + complete setup zsh | source /dev/stdin

# Do menu-driven completion.
zstyle ':completion:*' menu select

# Color completion for some things.
# http://linuxshellaccount.blogspot.com/2008/12/color-completion-using-zsh-modules-on.html
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# formatting and messages
# http://www.masterzen.fr/2009/04/19/in-love-with-zsh-part-one/
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format "$fg[yellow]%B--- %d%b"
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format "$fg[red]No matches for:$reset_color %d"
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

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


typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[arg0]=fg=green,bold
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=208,bold
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=208,bold
ZSH_HIGHLIGHT_STYLES[path]=fg=255,bold
ZSH_HIGHLIGHT_STYLES[path_pathseparator]=fg=yellow,bold

source ${HOME}/.env.zsh
source ${HOME}/.zsh/.aliases
source ${HOME}/.zsh/.functions
source /Users/fuzznimp/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ${HOME}/.cargo/env
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -l -g ""'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(atuin init zsh)"

eval "$(atuin init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Fig post block. Keep at the bottom of this file.
. "$HOME/.fig/shell/zshrc.post.zsh"
