#!/usr/bin/env bash

source "$(dirname "$(readlink "${BASH_SOURCE[0]}")")/.scripts/utils.sh"


# Possible actions for this script
ACTIONS=(init start end)

if [ $# -lt 1 ] || [ $# -gt 2 ] || [ "$1" = "help" ]; then
  help
fi

# Validate action
if ! contains_element "$1" "${ACTIONS[@]}"; then
  error "$1 is not a valid action."
  error "Possible actions for this script =  $ACTIONS"
  exit 1
fi
ACTION=$1


# ACTIONS
if [ "$ACTION" = "init" ]; then
  
  # Init submodules
  git submodule update --init --remote
  
  # Success message
  info "Submodules in sync with to remote repos :)"

  exit 0
fi
