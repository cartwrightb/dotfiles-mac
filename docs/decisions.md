# Configuration Decisions

This record describes the current design. Deployment instructions are in
[README.md](../README.md), and bindings are in [shortcuts.md](shortcuts.md).

## Minimal Configuration

Keep small overrides with known purposes and retain useful application
defaults. Add independent packages only when there is intentional configuration
to manage. Do not add frameworks, plugins, themes, or automation speculatively.
Preserve the restrained dark appearance and keyboard-driven workflow.

## GNU Stow and Repository Boundaries

Use GNU Stow, with each application package mirroring paths below `$HOME`.
Use supported XDG paths. Inspect destinations and preview links before
deployment; resolve conflicts explicitly rather than automatically adopting
existing files. Installation, deployment, reloads, and login changes are
separate actions requiring authorization.

`~/repos/dotfiles` is a strictly read-only Fedora reference. Reuse portable
behaviour selectively without copying Fedora session integration, hardware
identifiers, or generated state. Keep credentials, private settings, histories,
caches, and runtime data outside tracked packages.

## Ghostty

Use Ghostty in place of Alacritty on macOS. Preserve the tested Mac appearance:
JetBrainsMono Nerd Font at size 14, black background, `#d4d4d4` foreground,
0.92 background opacity, and padding of 8 on both axes. These are the accepted
Mac settings rather than an exact copy of Fedora's font size and opacity.

Keep `macos-option-as-alt = true`. Remove the experimental explicit
Option+H/J/K/L escape-sequence bindings. Prefer tmux prefix navigation instead
of adding terminal pane-navigation overrides.

Use the explicit `keybind = alt+c=esc:c` for fzf directory navigation. Option+C
produced `ç` despite Option-as-Alt being enabled; this binding sends ESC followed
by lowercase c to Zsh's fzf-cd-widget. The user confirmed it works in a temporary
Ghostty instance. Preserve all other Option handling and shortcuts.

## AeroSpace

Use Ctrl+Option as the window-manager modifier and add Shift for moving
windows. Preserve macOS Command shortcuts and tmux's Ctrl+A prefix and
Option-only bindings. The Logitech MX Keys S is in Mac mode.

Keep workspaces 1–10, Vim-style directional navigation, resize mode,
fullscreen, and floating/tiling toggling. Use AeroSpace's native layouts and
default container normalization; accordion approximates Sway's stacked/tabbed
layouts. Use `/usr/bin/open -a Ghostty`, which may activate an existing window.

Keep zero gaps and avoid extra bars or appearance helpers. Use native macOS
launching, locking, screenshots, and system controls. Login startup and
automatic reload remain disabled. Document the Ctrl+Option conflict with
VoiceOver.

Stage 5A uses `workspace-to-monitor-force-assignment` with portable display
roles instead of host-specific monitor IDs or ambiguous identical model names.
In the closed-lid two-display setup, the top PHL 345B1C is secondary (reported
monitor 1) and receives 2, 4, 6, 8, 10. The bottom PHL 345B1C is main (reported
monitor 2) and receives 1, 3, 5, 7, 9.

Odd workspaces select `main`; even workspaces try `['secondary', 'main']` in
order. With only the built-in display active, every workspace is expected to
select main, requiring no scripts, manual edits, or reload hooks for undocking.
This undocked behaviour has not yet been physically tested. Physical
placement depends on keeping the bottom display main. The `secondary` selector
is documented for exactly two monitors; three active displays require a
separate design. Forced assignments prevent manual workspace-to-monitor moves.
Existing bindings and all other settings are preserved. Stage 5A is deployed
through Stow; the user confirmed the docked odd/even monitor assignments and
existing shortcuts work interactively. Native dry-run validation also passed.

## Zsh and Starship

Keep the existing Zsh and Starship setup instead of reproducing Fedora's Bash
prompt. Preserve Starship's default Git icons, colours, status, and other
modules. Override only `add_newline = false` and `line_break.disabled = true`
for a compact single-line prompt. The independent `shell` Stow package
preserves Homebrew initialization in `.zprofile` and Starship initialization
in `.zshrc`. Use Zsh's native HOME startup paths without adding a ZDOTDIR
bootstrap or fragment loader.

Enable native completion with `compinit`, including Homebrew's supplied
completion directory for non-login shells. Keep completion security checks.
Load fzf's built-in Zsh integration after compinit when fzf is available;
retain its file walker, standard bindings, and completion trigger.

Keep `~/.zsh_history` outside the repository, with HISTSIZE and SAVEHIST both
10,000. Enable INC_APPEND_HISTORY and HIST_IGNORE_DUPS. Leave automatic
history importing between running shells disabled. Preserve the default
editing keymap and Ctrl+A behaviour.

Preserve Fedora's `ll='ls -lah'`; add only `lt='eza --tree --level=2'`.
Keep standard commands unchanged and use the installed CLI tools directly.
Add no `..` alias, frameworks, plugins, custom fzf generators, or automatic
tmux startup. Source optional untracked `~/.zshrc.local` last so local settings
can override the portable base. The existing `*.local` ignore rule covers it.

Deploy the startup files through Stow. On machines with existing regular
files, back up and verify both before an explicitly authorized replacement;
never adopt them automatically. Stage 4A is deployed on the MacBook; confirmed
behaviour and remaining interactive checks are recorded in README.md and
shortcuts.md.

## Tmux

Preserve the Fedora configuration's Ctrl+A prefix, splits in the active
directory, Vim-style copy mode, mouse behaviour, one-based numbering,
window navigation, and compact status palette. Change only the terminal RGB
declaration to `xterm-ghostty:RGB` for the Mac terminal.

Prefer Ctrl+A followed by lowercase h/j/k/l for pane navigation. Existing
Option pane bindings remain alternatives when delivered as Meta sequences.
Keep clipboard integration through the terminal. Add no plugins, clipboard
utilities, shell changes, or automatic tmux startup.

## Zed and Neovim

Zed is the primary editor. Neovim is only for quick terminal editing of
configuration files, scripts, and similar tasks. The Fedora repository has no
tracked Vim/Neovim configuration to migrate.

Neovim's init.lua contains exactly:

```lua
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
```

Keep all other Neovim defaults. Add no plugins, plugin managers, themes,
LSP configuration, custom mappings, or extra options. Use its built-in
clipboard provider and normal editing commands.

Declare `vim` in `diagnostics.globals` in the repository-root `.luarc.json`
so Zed's Lua language server recognises Neovim's runtime global. This is
project editor metadata, outside the Stow packages; keep other diagnostics
enabled and the three-line init.lua unchanged.

## Validation

Review diffs and whitespace, preview Stow links, and use native validators.
Use isolated temporary state for Neovim and a temporary socket for tmux
validation. Never reload a working application merely to validate repository
files. Treat user runtime checks as evidence alongside automated checks, and
report validation limitations rather than changing settings to bypass them.
