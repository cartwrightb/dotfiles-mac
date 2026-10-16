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
│   ├── decisions.md
│   └── shortcuts.md
├── starship/
│   └── .config/
│       └── starship.toml
├── tmux/
│   └── .config/
│       └── tmux/
│           └── tmux.conf
├── nvim/
│   └── .config/
│       └── nvim/
│           └── init.lua
├── shell/
│   ├── .zprofile
│   └── .zshrc
├── README.md
├── AGENTS.md
└── .gitignore
```

Documentation and repository metadata are not Stow packages.

The reasons behind the configuration are recorded in
[docs/decisions.md](docs/decisions.md). Keyboard commands are in
[docs/shortcuts.md](docs/shortcuts.md).

## Current Configuration

Managed packages are `ghostty`, `aerospace`, `starship`, `tmux`, `nvim`, and `shell`.
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
Fedora's Bash prompt. The `shell` package preserves Starship initialization
in `.zshrc`; Starship appearance remains managed by the separate package.

The `shell` package manages `.zprofile` and `.zshrc` at their native HOME
paths, without changing ZDOTDIR. It preserves Homebrew login initialization,
enables native Zsh completion and fzf's built-in Zsh integration, and retains
10,000 history entries in memory and on disk. Commands append incrementally
to `~/.zsh_history`, with consecutive duplicates suppressed; history is not
automatically imported from other running shells.

Aliases are only `ll='ls -lah'` and `lt='eza --tree --level=2'`. Standard
commands remain unchanged. Use `rg`, `fd`, `bat`, and `eza` directly; no
additional configuration or installation is performed for them. There are no
shell frameworks, plugins, or custom fzf generators. An optional untracked
`~/.zshrc.local` is sourced last for private or host-specific overrides.

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

Zed remains the primary editor. Neovim is for quick terminal editing of
configuration files and scripts. Its init.lua contains only three settings:
absolute line numbers, relative line numbers, and `clipboard = "unnamedplus"`.
Together, the number options show the current line's absolute number and
relative numbers elsewhere. Ordinary yank, delete, and paste operations use
the system clipboard through Neovim's built-in provider. Everything else
retains Neovim defaults: no plugins, themes, LSP, or custom mappings.

## Planned Direction

- Use native launcher, menu bar, locking, screenshots, and system controls
  initially.
- Zed settings are available in the Linux reference. That repository has
  no Neovim configuration to migrate.
- Dual-monitor workspace assignments remain a later stage.

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

Inspect `~/.config/nvim/init.lua` and `init.vim` before deploying Neovim.
XDG_CONFIG_HOME and NVIM_APPNAME can select a different configuration directory;
review these first. Preview independently:

```bash
stow --no --verbose=2 --target="$HOME" nvim
```

Use `nvim` in the deployment/removal commands below only when requested.

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

### Zsh: deployment and verification

Inspect `~/.zprofile`, `~/.zshrc`, `~/.zshenv`, ZDOTDIR, and any
`~/.zshrc.local`. A custom ZDOTDIR requires a separate path review.
Homebrew, Starship, and fzf must be installed separately; `lt` also needs eza.
Homebrew initialization stays in `.zprofile`; `.zshrc` also adds Homebrew's
completion directory for non-login interactive shells, without repeating
Homebrew PATH initialization. Native `compinit` retains its security checks.

```bash
cd "$HOME/repos/dotfiles-mac"
stow --no --verbose=2 --target="$HOME" shell
```

Stage 4A is deployed on the MacBook with Stow-managed `.zprofile` and `.zshrc`
symlinks. The user confirmed login startup, Starship appearance, native Git Tab
completion, fzf Ctrl+R history search, both aliases, and HISTSIZE/SAVEHIST of
10,000. Option+C was also confirmed in a temporary Ghostty instance with the
explicit `keybind = alt+c=esc:c`, now included in the Ghostty package to send
ESC followed by lowercase c instead of `ç`. Ctrl+T and `**` followed by Tab
remain configured but have not yet been interactively confirmed;
see [shortcuts](docs/shortcuts.md).

On a machine with regular files at these destinations, Stow reports conflicts
and aborts without changing them. Do not use `--adopt`. The following procedure
is only for replacing regular files after explicit deployment approval; do not
repeat it over the existing managed symlinks. Run it in a subshell so a failed
step stops the procedure without exiting your working shell:

```bash
(
    set -eu
    cd "$HOME/repos/dotfiles-mac"
    test -z "${ZDOTDIR:-}"
    test -f "$HOME/.zprofile"
    test ! -L "$HOME/.zprofile"
    test -f "$HOME/.zshrc"
    test ! -L "$HOME/.zshrc"
    shell_backup=$(mktemp -d "$HOME/.zsh-backup.XXXXXXXX")
    chmod 700 "$shell_backup"
    cp -p "$HOME/.zprofile" "$shell_backup/.zprofile"
    cp -p "$HOME/.zshrc" "$shell_backup/.zshrc"
    cmp "$HOME/.zprofile" "$shell_backup/.zprofile"
    cmp "$HOME/.zshrc" "$shell_backup/.zshrc"
    printf 'Verified backups: %s\n' "$shell_backup"
    rm "$HOME/.zprofile" "$HOME/.zshrc"
    stow --no --verbose=2 --target="$HOME" shell
    stow --verbose=1 --target="$HOME" shell
    test -L "$HOME/.zprofile" && test -L "$HOME/.zshrc"
    ls -l "$HOME/.zprofile" "$HOME/.zshrc"
    cmp "$HOME/.zprofile" shell/.zprofile
    cmp "$HOME/.zshrc" shell/.zshrc
)
```

Keep the printed backup directory. If deployment fails after removing the
original files, leave the current terminal open. Preview and run
`stow --delete --target="$HOME" shell` to remove any package links, then copy
both backup files back only after checking that their destinations are absent.
Do not overwrite an unexpected file or symlink. Deployment does not reload the
current shell; interactive checks in a new terminal require separate approval.

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

Validate Neovim headlessly with `-u` pointing to the repository init.lua and
`-i NONE` to disable ShaDa. Use temporary XDG state/cache/data directories and
verify number, relativenumber, and clipboard options. Check clipboard-provider
availability without changing clipboard contents; after deployment, verify
line numbers and normal editing interactively.

Validate shell syntax with `/bin/zsh -n shell/.zprofile` and
`/bin/zsh -n shell/.zshrc`. Exercise startup in isolated login and non-login
interactive child shells with temporary HOME, ZDOTDIR, and XDG state/cache/data
directories. Check completion registrations, fzf widgets and bindings, history
options, aliases, and local override ordering without touching user history or
completion dumps. After authorized deployment, verify fzf selection and prompt
appearance interactively in Ghostty, both outside and inside tmux.

## References

- https://ghostty.org/docs/config
- https://ghostty.org/docs/config/reference
- https://nikitabobko.github.io/AeroSpace/guide
- https://nikitabobko.github.io/AeroSpace/commands
- https://starship.rs/config/
- https://zsh.sourceforge.io/Doc/Release/Files.html
- https://zsh.sourceforge.io/Doc/Release/Options.html
- https://docs.brew.sh/Shell-Completion
- https://github.com/junegunn/fzf#shell-integration
