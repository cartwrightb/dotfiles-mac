# macOS Dotfiles

Minimal, keyboard-driven macOS user configuration, deployed with GNU Stow.

This repository carries forward the restrained visual style and workflow
of `~/repos/dotfiles`: dark surfaces, muted accents, Vim-style navigation,
numbered workspaces, and small, understandable configuration files.

## Design Principles

- Manage intentional user configuration; retain useful application defaults.
- Keep each application in an independent Stow package.
- Add packages only when there is reviewed configuration to manage.
- Prefer native macOS facilities for system functions.
- Preserve established keyboard habits while checking shortcut conflicts.
- Keep secrets, generated state, and hardware-specific values untracked.
- Preview deployment and resolve existing-file conflicts explicitly.
- Keep installation separate from configuration deployment.

## Linux Reference

`~/repos/dotfiles` is the existing Fedora Sway dotfiles repository.
It is a read-only design reference: inspect its documentation and settings,
but never modify it as part of work in this repository.

Reuse portable configuration selectively. Translate platform-specific
behaviour rather than copying Linux configuration wholesale.

## Repository Layout

Each application directory mirrors paths below `$HOME`:

```text
dotfiles-mac/
├── ghostty/
│   └── .config/
│       └── ghostty/
│           └── config.ghostty
├── README.md
├── AGENTS.md
└── .gitignore
```

Documentation and repository metadata are not Stow packages.

## Initial Configuration

Ghostty is the only managed package. Its configuration adapts the Linux
Alacritty appearance:

- JetBrainsMono Nerd Font Mono, size 11.
- Black background and light-grey foreground.
- 95% background opacity and modest padding.
- Option treated as Alt for terminal shortcuts.

Font size and padding are starting values to review on the Mac display.
Option-as-Alt changes Option-based special-character entry in the terminal.

Ghostty and the selected font are installed separately.

## Planned Direction

- Shell: small fragments, a simple Git-aware prompt, and private local
  overrides; choose the macOS shell before implementing.
- Tmux: preserve Ctrl+A, Vim navigation/copy mode, one-based numbering,
  working-directory-preserving splits, and the compact status bar.
- AeroSpace: translate the Sway workspace and navigation workflow later.
  No AeroSpace configuration or installation is included.
- Keep Option-based tmux shortcuts in mind when choosing desktop bindings.
- Use native launcher, menu bar, locking, screenshots, and system controls
  initially.
- Zed settings are available in the Linux reference. That repository has
  no Neovim configuration to migrate.

Fedora startup, systemd integration, GTK settings, Wayland utilities,
Linux hardware identifiers, and host-specific window rules are omitted.

## Deployment

Git, GNU Stow, and Ghostty must already be available. No installation or
deployment is performed automatically.

Inspect existing Ghostty files and symlinks first, including:

- `~/.config/ghostty/`
- `~/Library/Application Support/com.mitchellh.ghostty/`

Ghostty loads macOS-specific configuration after XDG configuration;
later conflicting values override earlier ones.

From this repository, preview deployment:

```bash
stow --no --verbose=2 --target="$HOME" ghostty
```

Compare and back up conflicting files before proceeding. Do not use
`stow --adopt` to resolve conflicts automatically.

After reviewing the preview, deploy:

```bash
stow --verbose=1 --target="$HOME" ghostty
```

To remove managed links:

```bash
stow --delete --target="$HOME" ghostty
```

Unstowing does not uninstall Ghostty.

## Local and Private Configuration

Keep credentials, private keys, browser profiles, histories, caches,
databases, and runtime state outside this repository.

Keep machine-specific settings in documented local overrides where the
application supports them. Commit sanitized `.example` files when useful.

## Validation

Inspect `git diff` and run `git diff --check` before accepting changes.
Preview Stow links and use application-native validation where available.
After deployment, check Ghostty appearance, Option shortcuts, and clipboard
behaviour interactively.

Contributor and automation rules are in `AGENTS.md`.

## References

- https://ghostty.org/docs/config
- https://ghostty.org/docs/config/reference
