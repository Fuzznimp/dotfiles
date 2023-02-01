[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
eval "$(atuin init bash)"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
. "$HOME/.cargo/env"

source /Users/anthonymontaigne/.docker/init-bash.sh || true # Added by Docker Desktop
