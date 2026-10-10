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
├── aerospace/
│   └── .config/
│       └── aerospace/
│           └── aerospace.toml
├── docs/
│   └── shortcuts.md
├── starship/
│   └── .config/
│       └── starship.toml
├── tmux/
│   └── .config/
│       └── tmux/
│           └── tmux.conf
├── README.md
├── AGENTS.md
└── .gitignore
```

Documentation and repository metadata are not Stow packages.

## Initial Configuration

Managed packages are `ghostty`, `aerospace`, `starship`, and `tmux`.
Ghostty adapts the Linux Alacritty appearance:

- JetBrainsMono Nerd Font, size 14.
- Black background and light-grey foreground.
- 92% background opacity and modest padding.
- Option treated as Alt for terminal shortcuts.

These settings preserve the current working macOS terminal appearance.
Option-as-Alt changes Option-based special-character entry in the terminal.

Ghostty and the selected font are installed separately.

AeroSpace targets 0.21.3-Beta and uses Ctrl+Option for desktop navigation,
Shift for window movement, and numbered workspaces 1–10. Command shortcuts,
Option-only tmux shortcuts, and Ctrl+A remain available. Layouts retain
AeroSpace's default container normalization and zero gaps. Login startup and
automatic reload are disabled.

Ctrl+Option conflicts with VoiceOver when it uses that modifier. Review custom
system, application, and Logitech shortcuts before deployment. See
[docs/shortcuts.md](docs/shortcuts.md) for bindings and Sway differences.

Starship keeps its default Git icons, colours, status information, and other
modules. Its only overrides remove the blank line before each prompt and put
the input marker on the same line. This retains Starship rather than recreating
Fedora's Bash prompt. The existing Mac `~/.zshrc` initializes Starship; that
shell file is not yet managed by this repository.

Tmux targets Homebrew tmux 3.8. It preserves the Fedora Ctrl+A prefix,
Vim-style pane navigation and copy mode, Option-only navigation, one-based
numbering, mouse support, current-directory splits, and compact dark status
bar. The only functional change from the Fedora configuration is the
`xterm-ghostty:RGB` terminal declaration. There are no plugins, clipboard
utilities, shell changes, or automatic tmux startup.

Ghostty provides Option-as-Alt and terminal clipboard integration. AeroSpace's
Ctrl+Option bindings remain separate. Tmux intercepts Option navigation and
Shift+Left/Right before terminal applications; Ctrl+A twice sends Ctrl+A
through. See [docs/shortcuts.md](docs/shortcuts.md) for copy-mode behaviour.

Preferred pane navigation is Ctrl+A followed by lowercase h/j/k/l. Existing
Option pane bindings remain alternatives. Ghostty uses
`macos-option-as-alt = true` without explicit Option+H/J/K/L key overrides.

## Planned Direction

- Shell: retain Zsh and Starship; manage small shell fragments and private
  local overrides when reviewed.
- Use native launcher, menu bar, locking, screenshots, and system controls
  initially.
- Zed settings are available in the Linux reference. That repository has
  no Neovim configuration to migrate.

Fedora startup, systemd integration, GTK settings, Wayland utilities,
Linux hardware identifiers, and host-specific window rules are omitted.

## Deployment

Git, GNU Stow, and the application being configured must already be available.
No installation or deployment is performed automatically.

Inspect existing Ghostty files and symlinks first, including:

- `~/.config/ghostty/`
- `~/Library/Application Support/com.mitchellh.ghostty/`

Ghostty loads macOS-specific configuration after XDG configuration;
later conflicting values override earlier ones.

For AeroSpace, inspect `~/.aerospace.toml` and
`~/.config/aerospace/aerospace.toml`. If XDG_CONFIG_HOME is set, inspect its
`aerospace/aerospace.toml` instead. AeroSpace reports ambiguity if both supported
locations contain configuration. The package targets the default XDG path;
review deployment separately if XDG_CONFIG_HOME points elsewhere.

Preview AeroSpace independently:

```bash
stow --no --verbose=2 --target="$HOME" aerospace
```

This is a preview only. Deployment, reload, and login changes require a
separate request. Use the same Stow commands below with `aerospace` instead
of `ghostty` when its deployment or removal is requested.

From this repository, preview deployment:

```bash
stow --no --verbose=2 --target="$HOME" ghostty
```

Preview Starship independently:

```bash
stow --no --verbose=2 --target="$HOME" starship
```

Inspect `~/.config/starship.toml` first. STARSHIP_CONFIG can select a different
file, and XDG_CONFIG_HOME can change the default directory; review these before
deployment. Use `starship` in the deployment/removal commands below only when
requested. The package does not change shell initialization.

Inspect `~/.tmux.conf`, `~/.config/tmux/tmux.conf`, any active XDG_CONFIG_HOME,
and `/opt/homebrew/etc/tmux.conf` before deploying tmux. Preview independently:

```bash
stow --no --verbose=2 --target="$HOME" tmux
```

Use `tmux` in the deployment/removal commands below only when requested.
Existing tmux servers load configuration at startup; deployment alone does
not reload them. Applications inside tmux use `TERM=tmux-256color`, which
remote machines may also need in their terminfo database.

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

Validate Starship TOML and inspect its computed configuration without changing
the active shell:

```bash
STARSHIP_CONFIG="$PWD/starship/.config/starship.toml" starship print-config
```

Only `add_newline` and `line_break.disabled` should differ from Starship defaults.

Parse AeroSpace TOML before deployment. `aerospace reload-config --dry-run`
validates without reloading, but checks the configuration selected by the
running app; it cannot validate an arbitrary undeployed repository path.
Do not deploy or launch a second app instance merely to enable this check.
After authorized deployment, verify desktop shortcuts, resize mode, floating
focus, and Ghostty launch behaviour on the actual keyboard.

Contributor and automation rules are in `AGENTS.md`.

Validate tmux using an isolated temporary server/socket with the repository
configuration, inspect its errors, options, and key bindings, then stop only
that test server. After authorized deployment, check Option shortcuts,
Shift+arrows, split directories, and copying to the macOS clipboard in Ghostty.

## References

- https://ghostty.org/docs/config
- https://ghostty.org/docs/config/reference
- https://nikitabobko.github.io/AeroSpace/guide
- https://nikitabobko.github.io/AeroSpace/commands
- https://starship.rs/config/
