# Keyboard Shortcuts

The window-manager modifier is Ctrl+Option (`ctrl-alt` in AeroSpace TOML).
The Logitech MX Keys S is in Mac mode; Command and Option behave as labelled.
Letters below do not require Shift unless it is explicitly listed.

## AeroSpace

| Shortcut | Action |
| --- | --- |
| Ctrl+Option+Enter | Open or activate Ghostty |
| Ctrl+Option+Shift+C | Reload AeroSpace configuration |
| Ctrl+Option+H/J/K/L or arrows | Focus left/down/up/right |
| Ctrl+Option+Shift+H/J/K/L or arrows | Move the window left/down/up/right |
| Ctrl+Option+1–9 | Switch to workspace 1–9 |
| Ctrl+Option+0 | Switch to workspace 10 |
| Ctrl+Option+Shift+1–9 | Move the window to workspace 1–9 without following |
| Ctrl+Option+Shift+0 | Move the window to workspace 10 without following |
| Ctrl+Option+B / V | Arrange the current container as horizontal/vertical tiles |
| Ctrl+Option+S / W | Use vertical/horizontal accordion layout |
| Ctrl+Option+E | Toggle tiled horizontal/vertical layout |
| Ctrl+Option+F | Toggle AeroSpace fullscreen |
| Ctrl+Option+Shift+Space | Toggle the focused window between floating and tiling |
| Ctrl+Option+R | Enter resize mode |

Ghostty is launched with `/usr/bin/open -a Ghostty`. If already running, this
may activate its existing window rather than create a new terminal.

## Resize Mode

| Shortcut | Action |
| --- | --- |
| Ctrl+Option+H or Left | Shrink width by 10 |
| Ctrl+Option+L or Right | Grow width by 10 |
| Ctrl+Option+K or Up | Shrink height by 10 |
| Ctrl+Option+J or Down | Grow height by 10 |
| Enter, Escape, or Ctrl+Option+R | Return to the main mode |

Hold Ctrl+Option for resize directions. Command shortcuts, Option-only
shortcuts, and Ctrl+A remain unbound in this mode. Plain Enter/Escape are
intercepted until resize mode is exited. The increment is in AeroSpace's
coordinate system and may look different from Sway's 10 pixels.

## Native macOS and Tmux

Command shortcuts remain available, including copy, paste, save, find,
browser navigation, and Command+W to close a window. Use Command+Space for
Spotlight, Ctrl+Command+Q to lock, and Command+Shift+3/4/5 for screenshots.

AeroSpace does not bind Option-only shortcuts or Ctrl+A. This preserves the
Linux tmux workflow: Ctrl+A prefix, Option+H/J/K/L pane navigation, and
Option+1–9 window selection. Tmux itself is not yet managed by this repository.
Ghostty's managed configuration treats Option as Alt.

## Conflicts and Differences from Sway

- VoiceOver uses Ctrl+Option as a default modifier. These bindings conflict
  when VoiceOver uses it; this repository does not change accessibility settings.
- Standard Mission Control/Spaces Ctrl+arrow shortcuts are distinct from the
  Ctrl+Option bindings. Input switching may use Ctrl+Option+Space; the floating
  binding includes Shift. Check custom system, app, and Logitech assignments.
- B/V arrange an existing container rather than prepare a nested Sway split.
  AeroSpace's default container normalization is retained.
- Accordion approximates stacked/tabbed layouts without Sway title tabs.
- AeroSpace workspaces are separate from native macOS Spaces. Its fullscreen
  command is separate from native macOS fullscreen.
- Directional focus includes floating windows; no separate tiled/floating
  focus switch is configured.
- Parent-container focus, scratchpad, passthrough mode, modifier-drag controls,
  and Sway session exit are omitted. Native macOS facilities handle launching,
  locking, screenshots, and session actions.
- No hardware-specific monitor assignments or Linux window rules are copied.

The source references are `~/repos/dotfiles/sway/.config/sway/config` and
`~/repos/dotfiles/docs/shortcuts.md`. That repository remains read-only.

## References

- [AeroSpace guide](https://nikitabobko.github.io/AeroSpace/guide)
- [AeroSpace commands](https://nikitabobko.github.io/AeroSpace/commands)
- [macOS shortcuts](https://support.apple.com/en-gb/102650)
- [VoiceOver modifier settings](https://support.apple.com/guide/voiceover/commands-category-voe7adb19917/mac)
