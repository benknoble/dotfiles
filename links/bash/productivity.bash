# git alias
alias g='git'

G() {
  grep --color=auto "$@"
}

EG() {
  grep -E --color=auto "$@"
}

L() {
  less "$@"
}

# attempt to extract file with correct extraction method
extract () {
  for file in "$@"; do
    if [ -f "$file" ]; then
      case "$file" in
        *.tar.bz2)  tar xjf "$file"      ;;
        *.tar.gz)   tar xzf "$file"      ;;
        *.bz2)      bunzip2 "$file"      ;;
        *.rar)      unrar x "$file"      ;;
        *.gz)       gunzip "$file"       ;;
        *.tar)      tar xf "$file"       ;;
        *.tbz2)     tar xjf "$file"      ;;
        *.tgz)      tar xzf "$file"      ;;
        *.zip)      unzip "$file"        ;;
        *.Z)        uncompress "$file"   ;;
        *)          echo "'$file' cannot be extracted via extract()" ;;
      esac
    else
      echo "'$file' is not a valid file"
    fi
  done
}

# go up
up() {
  local count="${1:-1}"
  local path=../
  (( count-- ))
  while (( count > 0 )) ; do
    path="$path"../
    (( count-- ))
  done
  echo "cd -- $path"
  cd -- "$path"
}