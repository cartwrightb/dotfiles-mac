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
- Managed packages are `ghostty` and `aerospace`.
- Do not create placeholder packages or copy entire third-party setups.

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

## Private Data

Never commit secrets, credentials, tokens, cookies, private keys,
browser profiles, histories, caches, databases, or runtime state.
Use sanitized example files to document local settings when needed.
Preserve unrelated user changes.

## Validation

- Inspect `git diff` and run `git diff --check`.
- Preview Stow deployment for affected packages.
- Use application-native validation where available.
- For AeroSpace, parse TOML and use `aerospace reload-config --dry-run`
  when available. It checks the app's configured path, not an arbitrary
  repository file; do not deploy or reload merely to enable validation.
- Report checks that could not run and why.
- Check appearance and keyboard behaviour after an authorized deployment.
