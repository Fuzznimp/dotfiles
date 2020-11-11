api_key() {
  size=${1:-16}
  openssl rand -hex ${size}
}

# Markdown
md() {
  pandoc $1 | lynx -stdin -dump
}

# Open man page as PDF
manpdf() {
  man -t "$1" | open -f -a /Applications/Preview.app/
}

mk() {
  mkdir -p "$@" && cd "$@"
}

port_in_use() {
  local port=${1:?"you should set a port"}
  lsof -n -i:${port} | grep LISTEN
}

uuid() {
  uuidgen | tr '[:upper:]' '[:lower:]' | tr -d '\n'
}

# Weather
wth() {
  city=${1:?"Choose a city"}
  curl "wttr.in/${city}"
}