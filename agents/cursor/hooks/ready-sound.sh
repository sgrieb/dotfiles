#!/bin/bash
# Plays when Cursor finishes a turn, the same clip Claude Code's Stop hook plays.
# Returns immediately so the clip is not cut off when the hook exits.
cat >/dev/null
nohup "$HOME/.claude/ready-sound.sh" >/dev/null 2>&1 &
disown
exit 0
