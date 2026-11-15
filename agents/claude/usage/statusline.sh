#!/bin/bash
# Claude Code status line: saves the account's rate limits for the tasks pane.
# It prints nothing, so no row appears under the input. Claude sends session JSON on stdin.
cache="$HOME/.cache/usage-indicator"
mkdir -p "$cache"
input=$(cat)
printf '%s' "$input" > "$cache/statusline-input.json"
printf '%s' "$input" | python3 -c '
import json, sys, time
d = json.load(sys.stdin)
r = d.get("rate_limits") or {}
if r:
    json.dump({"saved": time.time(), "rate_limits": r}, open(sys.argv[1], "w"))
' "$cache/claude.json"
# The tasks pane reads the cache written above. Printing nothing keeps that
# row from appearing under the input box.
true
