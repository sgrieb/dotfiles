#!/usr/bin/env python3
"""Merge the shared Codex and Cursor settings into this machine's live files.

Both tools write sign-in details and machine state (trusted paths, caches) into the same
file as their settings, so those files are merged rather than linked to this public repo.
Only the keys kept here are changed; everything else in the live file stays.
"""
import json, os, pathlib

here = pathlib.Path(__file__).resolve().parent
home = pathlib.Path.home()

def merge_json(base, extra):
    for k, v in extra.items():
        if isinstance(v, dict) and isinstance(base.get(k), dict):
            merge_json(base[k], v)
        else:
            base[k] = v
    return base

def cursor():
    live = home / ".cursor/cli-config.json"
    data = json.loads(live.read_text()) if live.exists() else {}
    merge_json(data, json.loads((here / "cursor/cli-config.json").read_text()))
    live.parent.mkdir(parents=True, exist_ok=True)
    live.write_text(json.dumps(data, indent=2) + "\n")

def codex():
    live = home / ".codex/config.toml"
    shared = [l for l in (here / "codex/config.toml").read_text().splitlines()
              if l.strip() and not l.lstrip().startswith("#")]
    keys = {l.split("=", 1)[0].strip() for l in shared}
    lines = live.read_text().splitlines() if live.exists() else []
    # Top-level keys must come before the first [table].
    first_table = next((i for i, l in enumerate(lines) if l.lstrip().startswith("[")), len(lines))
    top = [l for l in lines[:first_table] if "=" not in l or l.split("=", 1)[0].strip() not in keys]
    out = shared + [l for l in top if l.strip()] + ([""] if first_table < len(lines) else []) + lines[first_table:]
    live.parent.mkdir(parents=True, exist_ok=True)
    live.write_text("\n".join(out) + "\n")
    os.chmod(live, 0o600)

cursor()
codex()
print("Merged shared Cursor and Codex settings")
