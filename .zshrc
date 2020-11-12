fpath+=$HOME/.zsh/pure

autoload -U promptinit; promptinit

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

zstyle :prompt:pure:git:stash show yes

zstyle :prompt:pure:path color 26
zstyle :prompt:pure:prompt:success color 34
zstyle :prompt:pure:git:branch color 34

prompt pure

bindkey -e
autoload -Uz compinit && compinit
autoload -U edit-command-line;
zle -N edit-command-line;
bindkey '^F' edit-command-line # Edit current line with C-f
bindkey '^[[1;9D' backward-word # Alt-Left
bindkey '^[[1;9C' forward-word # Alt-Right
bindkey '^[[3~' delete-char # Delete
bindkey '^[[Z' reverse-menu-complete # Ctrl-r
bindkey '^[[A' up-line-or-search # Arrow up
bindkey '^[[B' down-line-or-search # Arrow down

source ${HOME}/.zsh/.aliases
source ${HOME}/.zsh/.functions
source /usr/local/opt/zsh-syntax-highlighting/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[[ -r ${HOME}/.asdf/asdf.sh ]] && source ${HOME}/.asdf/asdf.sh