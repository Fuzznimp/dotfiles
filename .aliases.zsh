# Source Shell
alias reload.zsh="source ~/.zshrc"

# List declared aliases, functions, path
alias aliases="alias | sed 's/=.*//'"
alias functions="declare -f | grep '^[a-z].* ()' | sed 's/{$//'"
alias paths="echo -e ${PATH//:/\\n}"

# System
alias ~="cd ~"
alias /="cd /"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias rr="rm -rf"
alias cp="cp -iv"
alias mv="mv -iv"
alias mkdir="mkdir -pv"

# Paths
alias wks="cd ~/workspace"
alias fwl="cd ~/workspace/fewlines"
alias fwl.courses="cd ~/workspace/fewlines/sparta_courses"
alias fwl.sparta="cd ~/workspace/fewlines/sparta-monorepo"
alias fwl.account="cd ~/workspace/fewlines/connect-account"
alias fwl.connect="cd ~/workspace/fewlines/connect"
alias fwl.web="cd ~/workspace/fewlines/web-node-libraries"
alias dotfiles="cd ~/workspace/dotfiles"
alias conf.alias="code ~/.oh-my-zsh/custom/aliases.zsh"

# ls
alias ll="exa --all --long --header --git"
alias lt="exa -aT --color=always --group-directories-first --ignore-glob='**/node_modules|**/dist|**/.next'"

# tar
alias tarr="tar -pczf $1 $2"
alias untarr="tar -pxzf $1"
alias starr="sudo tar -pczf $1 $2"

# Mac
alias cask="brew cask"
alias update="brew update && brew upgrade && brew cleanup && asdf update && asdf plugin-update --all && mas upgrade"
alias delete.ds="find . -type f -name '*.DS_Store' -ls -delete"
alias delete.ad="find . -type d -name '.AppleD*' -ls -exec /bin/rm -r {} \;"
alias desktopshow="defaults write com.apple.finder CreateDesktop -bool true && killfinder"
alias desktophide="defaults write com.apple.finder CreateDesktop -bool false && killfinder"
alias displays="system_profiler SPDisplaysDataType"
alias cpu="sysctl -n machdep.cpu.brand_string"
alias ram="top -l 1 -s 0 | grep PhysMem"

# Git
alias gcb="git checkout -b"
alias gd="git diff"
alias ga="git add"
alias gcm="git commit -m"
alias gpo="git push -u origin"
alias gtl="git stash list"
alias gts="git stash save"
alias gsd="git stash drop"
alias gca="git commit --amend"
alias gb="git rebase"
alias gbd="git branch -D"
alias gl="git log --pretty=oneline --abbrev-commit"
alias gbleach="git branch -vv | grep 'gone'] | awk '{ print $1 }' | xargs git branch -D"

# Vim
alias vim="nvim"
alias vi="vim ."

# Onivim2
alias oni="/Applications/Onivim2.App/Contents/MacOS/Oni2"

# Docker
alias docker.cleancontainer="docker ps -a -q | xargs docker rm"
alias docker.cleanimage="docker images --filter dangling=true -q | xargs docker rmi"

# Network
alias nets="lsof -i"
alias ip="curl -s ipinfo.io | jq -r '.ip'"
alias ipl="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias wip="curl ifconfig.co"
alias speedtest="curl -o /dev/null http://ovh.net/files/100Mio.dat"

# Misc
alias week="date +%V"