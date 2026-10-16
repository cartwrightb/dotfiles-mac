# Repository Guide

## Purpose

Manage minimal, understandable macOS user configuration with GNU Stow.
Preserve the user's restrained visual style and keyboard-driven workflow.

## Read-Only Linux Reference

`~/repos/dotfiles` contains the existing Fedora Sway configuration.
Read it for design context and portable settings.

Never edit, deploy from, or otherwise mutate that repository as part of
work here. Make macOS changes only in `~/repos/dotfiles-mac`.

## Architecture

- Each top-level application directory is an independent Stow package.
- Package contents mirror paths below `$HOME`.
- Use XDG paths when supported by the application on macOS.
- README.md, AGENTS.md, and .gitignore are repository metadata.
- Managed packages are `ghostty`, `aerospace`, `starship`, `tmux`, `nvim`, and `shell`.
- Do not create placeholder packages or copy entire third-party setups.
- Keep significant design decisions in `docs/decisions.md` and keyboard
  commands in `docs/shortcuts.md`; keep both consistent with the packages.
- Whenever Codex introduces, changes, or removes a keyboard shortcut, alias,
  or custom command, update `docs/shortcuts.md` in the same change.

## Design Rules

- Keep overrides small and explain why each setting exists.
- Preserve application defaults where they satisfy the user's needs.
- Preserve established appearance and shortcuts unless asked to change them.
- Check conflicts between desktop, terminal, tmux, and application bindings.
- Prefer native macOS facilities for system functions.
- Translate Linux behaviour; do not copy Fedora integration or device IDs.
- Keep host-specific settings outside the portable base.
- AeroSpace uses Ctrl+Option (`ctrl-alt`), with Shift for window movement.
  Preserve macOS Command shortcuts, Option-only tmux shortcuts, and Ctrl+A.
- Keep numbered workspaces 1–10 and document bindings in `docs/shortcuts.md`.
- Keep AeroSpace login startup and automatic reload disabled unless requested.
- Starship changes only prompt spacing: no preceding blank line and no
  separate input line. Preserve all other Starship defaults.
- Tmux preserves the Fedora Ctrl+A prefix, Option navigation, copy mode,
  mouse behaviour, numbering, split directories, and status palette.
  Use Ghostty's RGB declaration; do not add plugins or startup automation.
- Prefer Ctrl+A followed by h/j/k/l for tmux pane navigation. Preserve the
  existing Option bindings as alternatives; do not add Ghostty pane-navigation
  overrides. Preserve the tested `alt+c=esc:c` binding for fzf directory navigation.
- Zsh uses native compinit and fzf integration, 10,000-entry history with
  incremental append and consecutive duplicate suppression, and only the
  reviewed `ll` and `lt` aliases. Keep Homebrew in `.zprofile`, Starship in
  `.zshrc`, and optional untracked `~/.zshrc.local` last. Add no frameworks,
  plugins, custom fzf generators, or replacements for standard commands.
- Zed is the primary editor. Neovim is for quick terminal edits; configure
  only absolute/relative line numbers and `clipboard = "unnamedplus"`.
  Do not add plugins, themes, LSP, custom mappings, or other settings.

## Safe Workflow

Before changing or deploying an application package:

1. Inspect existing destination files and symlinks.
2. Read application documentation for supported paths and override order.
3. Manage only intentional, user-authored configuration.
4. Preview with `stow --no --verbose=2 --target="$HOME" <package>`.
5. Resolve conflicts explicitly; never use `--adopt` automatically.
6. Deploy only when requested, then verify the result.

Creating repository files does not authorize deployment into `$HOME`,
application reloads, software installation, or system changes.

For Ghostty, inspect both XDG and macOS Application Support configuration.
The latter loads afterward and may override the managed XDG settings.

For AeroSpace, inspect both `~/.aerospace.toml` and
`~/.config/aerospace/aerospace.toml` (or the active XDG_CONFIG_HOME).
Having configurations in both locations is ambiguous. Check VoiceOver and
custom system/app shortcuts for Ctrl+Option conflicts.

For Starship, inspect `~/.config/starship.toml`, XDG_CONFIG_HOME, and
STARSHIP_CONFIG before deployment. The package uses the default XDG path.

For tmux, inspect `~/.tmux.conf`, `~/.config/tmux/tmux.conf`, any active
XDG_CONFIG_HOME, and Homebrew's `/opt/homebrew/etc/tmux.conf` before deployment.

For Neovim, inspect `~/.config/nvim/init.lua` and `init.vim`, XDG_CONFIG_HOME,
and NVIM_APPNAME before deployment. The package uses the default XDG path.

For Zsh, inspect `~/.zprofile`, `~/.zshrc`, `~/.zshenv`, ZDOTDIR, and any
`~/.zshrc.local` before deployment. The package targets startup files in HOME;
review separately if ZDOTDIR selects another directory. Preserve existing
regular files until backup and deployment are explicitly authorized.

## Private Data

Never commit secrets, credentials, tokens, cookies, private keys,
browser profiles, histories, caches, databases, or runtime state.
Use sanitized example files to document local settings when needed.
Preserve unrelated user changes.

## Validation

- Inspect `git diff` and run `git diff --check`.
- Preview Stow deployment for affected packages.
- Use application-native validation where available.
- Validate Neovim headlessly with the repository init.lua, ShaDa disabled,
  and temporary XDG state/cache/data directories. Check the three options
  without modifying the user's editor state or clipboard contents.
- Validate tmux on an isolated temporary socket with the repository file;
  inspect configuration errors, options, and bindings, then remove that test
  server. Never source configuration into an existing server without a request.
- For Starship, parse TOML and inspect `starship print-config` with
  STARSHIP_CONFIG set only for that process to the repository file.
- For AeroSpace, parse TOML and use `aerospace reload-config --dry-run`
  when available. It checks the app's configured path, not an arbitrary
  repository file; do not deploy or reload merely to enable validation.
- Validate Zsh syntax with `zsh -n`. Validate startup, completion, history
  options, aliases, and fzf widgets in child shells with temporary HOME,
  ZDOTDIR, and XDG state/cache/data paths. Never source the repository files
  into the working shell or read/write the user's history for validation.
- Report checks that could not run and why.
- Check appearance and keyboard behaviour after an authorized deployment.
