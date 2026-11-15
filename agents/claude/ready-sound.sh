#!/usr/bin/env bash
# Stop hook: an original Warcraft peon or StarCraft SCV clip says Claude is ready.
# Main tab only: a todo agent's tab (YARN_AGENT set) alerts once, when its whole task ends
# (the repo's scripts/agent-turn-end.sh and scripts/lib/agent-alert.ts).
# Silent over SSH, without afplay (Linux), or where the clips (kept out of this public repo) are missing.
[ -n "${YARN_AGENT:-}" ] && exit 0
[ -n "${SSH_CONNECTION:-}" ] && exit 0
command -v afplay >/dev/null || exit 0
shopt -s nullglob
files=("$HOME/.claude/sounds/ready/"*)
(( ${#files[@]} )) || exit 0
afplay "${files[RANDOM % ${#files[@]}]}"
