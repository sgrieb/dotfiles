# New system setup

- macOS: install the zsh theme (`git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k`), then `./install` (links the dotfiles into ~)
- Ubuntu server: `./install-ubuntu-server` (zsh, tmux, Powerlevel10k), then `./install`

`./install` also sets up Claude Code, Cursor and Codex (`agents/`): Claude's settings, theme, hooks and mod are linked;
Cursor's and Codex's shared settings are merged into their own files, which hold sign-in details and stay out of this repo.
The Claude ready sounds are not in this public repo; copy `~/.claude/sounds/` by hand if wanted.

Over SSH the shell opens straight into the tmux session `ssh`.
