#!/bin/bash
# Returns a single-width nerd-font glyph for the current pane command.
# Uses only classic FontAwesome 4 codepoints (U+F0xx-U+F2xx) which are
# universally present in nerd fonts and not preempted by macOS CJK fallback.
cmd="$1"

case "$cmd" in
  *vim*|*nvim*)
    printf '\xef\x84\xa1'  # code <>
    ;;
  claude*|opencode|aider|copilot|gpt*|[0-9]*.[0-9]*.[0-9]*)
    printf '\xef\x83\x83'  # flask
    ;;
  zsh|bash|fish|sh|-zsh|-bash|-fish)
    printf '\xef\x84\xa0'  # terminal
    ;;
  git|lazygit|tig|gitui)
    printf '\xef\x87\x93'  # git
    ;;
  node|*node*|npm|yarn|bun|pnpm|deno)
    printf '\xef\x82\xac'  # globe
    ;;
  python*|*python*|py|ipython)
    printf '\xef\x84\xa1'  # code
    ;;
  ssh|*ssh*|mosh)
    printf '\xef\x80\xa3'  # lock
    ;;
  docker|*docker*|kubectl|k9s)
    printf '\xef\x86\xb3'  # cube
    ;;
  *)
    printf '\xef\x84\xa8'  # question
    ;;
esac
