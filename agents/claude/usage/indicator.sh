#!/bin/bash
# Usage left for the agent in the active tmux pane: Claude or Cursor.
# Usage: indicator.sh [claude|cursor|<pane_pid>] [plain]
cache="$HOME/.cache/usage-indicator"
mkdir -p "$cache"
which="$1"
if [[ "$which" =~ ^[0-9]+$ ]]; then
  # Whichever agent runs under the pane wins; Claude when neither does.
  tree=$(ps -A -o pid=,ppid=,command= | awk -v root="$which" '
    { pid[NR]=$1; ppid[NR]=$2; $1=$2=""; cmd[NR]=$0 }
    END { keep[root]=1; for (pass=0; pass<6; pass++) for (i in pid) if (keep[ppid[i]]) keep[pid[i]]=1;
          for (i in pid) if (keep[pid[i]]) print cmd[i] }')
  if grep -q 'cursor-agent\|/cursor-agent/\|\.local/share/cursor' <<<"$tree"; then which=cursor
  else which=claude; fi
fi
exec python3 - "$which" "$2" "$cache" <<'PY'
import json, os, subprocess, sys, time, base64, urllib.request
which, style, cache = sys.argv[1], sys.argv[2], sys.argv[3]

def color(left):
    if style == "plain":
        return ""
    return "#[fg=green]" if left > 50 else "#[fg=yellow]" if left > 20 else "#[fg=red]"

def when(ts):
    t = time.localtime(float(ts))
    same_day = time.strftime("%j", t) == time.strftime("%j")
    return time.strftime("%-I:%M %p" if same_day else "%a %-I %p", t)

def claude():
    try:
        saved = json.load(open(os.path.join(cache, "claude.json")))
    except Exception:
        return "Claude usage: waiting for Claude Code"
    r = saved["rate_limits"]
    parts = []
    for key, name in (("five_hour", "5h"), ("seven_day", "week")):
        w = r.get(key)
        if not w or w.get("used_percentage") is None:
            continue
        left = max(0, round(100 - float(w["used_percentage"])))
        reset = f" (resets {when(w['resets_at'])})" if w.get("resets_at") else ""
        parts.append(f"{color(left)}{left}% {name}{reset}")
    stale = " (old)" if time.time() - saved["saved"] > 6 * 3600 else ""
    sep = " · " if style == "plain" else "#[default] · "
    return "Claude left: " + sep.join(parts) + ("" if style == "plain" else "#[default]") + stale

def cursor():
    path = os.path.join(cache, "cursor.json")
    try:
        saved = json.load(open(path))
        fresh = time.time() - saved["saved"] < 300
    except Exception:
        saved, fresh = None, False
    if not fresh:
        try:
            token = subprocess.run(["security", "find-generic-password", "-s",
                                    "cursor-access-token", "-w"], capture_output=True,
                                   text=True, timeout=5).stdout.strip()
            body = token.split(".")[1]
            user = json.loads(base64.urlsafe_b64decode(body + "=" * (-len(body) % 4)))["sub"]
            req = urllib.request.Request("https://cursor.com/api/usage-summary", headers={
                "Cookie": f"WorkosCursorSessionToken={user.split('|')[-1]}%3A%3A{token}",
                "Origin": "https://cursor.com"})
            data = json.load(urllib.request.urlopen(req, timeout=8))
            saved = {"saved": time.time(), "data": data}
            json.dump(saved, open(path, "w"))
        except Exception:
            if saved is None:
                return "Cursor usage: unavailable"
    plan = saved["data"]["individualUsage"]["plan"]
    left = max(0, round(100 - float(plan.get("totalPercentUsed", 0))))
    end = saved["data"].get("billingCycleEnd", "")[:10]
    reset = time.strftime("%b %-d", time.strptime(end, "%Y-%m-%d")) if end else "?"
    tail = "" if style == "plain" else "#[default]"
    return f"Cursor left: {color(left)}{left}% (resets {reset}){tail}"

print(cursor() if which == "cursor" else claude())
PY
