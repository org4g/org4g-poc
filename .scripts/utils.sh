
function contains_element () {
  local i
  for i in "${@:2}"; do
    [[ "$i" == "$1" ]] && return 0
  done
  return 1
}

function info () {
  echo -e "\033[32mINFO: $*\033[0m"
}

# Fix: Redirect to stderr (message not seen from make)
function error () {
  echo -e "\033[31mERROR: $*\033[0m" >&2
}

function help {
  echo "USAGE: ${0} <action>"
  exit 1
}

export SCRIPT_DIR="$(dirname "$(readlink "${BASH_SOURCE[0]}")")/.scripts"
