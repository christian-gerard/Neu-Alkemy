#!/bin/bash
# Returns an icon based on the current pane command
cmd="$1"

case "$cmd" in
  *vim*|*nvim*)
    echo ""
    ;;
  claude*|opencode|aider|copilot|gpt*|[0-9]*.[0-9]*.[0-9]*)
    echo "⚗️"
    ;;
  zsh|bash|fish|sh)
    echo "👻"
    ;;
  *)
    echo "$cmd"
    ;;
esac
