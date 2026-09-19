# dotfiles

Personal configuration and scripts for [Omarchy](https://omarchy.org), the [Arch Linux](https://archlinux.org) + [Hyprland](https://hypr.land) setup made by DHH. This repo holds customizations layered on top of a default [Omarchy](https://omarchy.org) install: extra commands, config overrides, and workflow tweaks.

## Contents

- [Structure](#structure)
- [Requirements](#requirements)
- [Installation](#installation)
- [Commands](#commands)
- [Customization](#customization)
- [Roadmap](#roadmap)
- [Troubleshooting](#troubleshooting)

## Structure

```
.
├── bin/                # extra commands (run via omarchy-menu or directly)
│   └── mode            # opens an app set based on work mode
├── config/             # overrides for ~/.config (hypr, waybar, walker, etc.)
└── install.sh          # symlinks/copies files to the right locations
```

Update this tree whenever files are added or moved so it matches the repo.

## Requirements

- [Omarchy](https://omarchy.org) installed, with the `omarchy` CLI available on `$PATH`
- [Hyprland](https://hypr.land) as the window manager ([Omarchy](https://omarchy.org)'s default)
- `gtk-launch`, plus `.desktop` files for every GUI app the scripts reference ([VS Code](https://code.visualstudio.com), [WhatsApp](https://www.whatsapp.com), [Discord](https://discord.com), [Tetr.io](https://tetr.io), [Obsidian](https://obsidian.md), etc.)

## Installation

Clone the repo and run the install script:

```bash
git clone <repo-url> ~/dotfiles
cd ~/dotfiles
./install.sh
```

`install.sh` symlinks or copies the contents of `bin/` and `config/` into the right locations under `$HOME`. Review the script before running it, since it may overwrite existing files in `~/.config`.

If you prefer [GNU Stow](https://www.gnu.org/software/stow/), the layout can be adapted so each top-level directory is a package, and you would run `stow <package>` from the repo root instead. Document whichever method the repo actually uses here.

After installing, make sure the scripts in `bin/` are executable and that their directory is on your `$PATH`:

```bash
chmod +x bin/*
```

## Commands

### `bin/mode`

Opens a set of applications at once based on a work mode, using `omarchy launch` and `gtk-launch`.

**Usage**

```bash
mode [code|relax|socialize|tetris|study|work|eat]
```

**Behavior**

- With an argument, the script opens the apps for that mode.
- Without an argument, it calls `omarchy-menu-select` so you can pick a mode interactively.
- The URLs and apps for each mode are hardcoded in the script. Edit the `case` block to change them.

**[Omarchy](https://omarchy.org) menu integration**

The `# omarchy:summary=` and `# omarchy:args=` metadata lines in the file header are read by [Omarchy](https://omarchy.org) to display the command's description in its menu. Keep them updated when the script's behavior or arguments change.

## Customization

### Adding a new mode

1. Open `bin/mode`.
2. Add a new branch to the `case` block that launches the apps or URLs you want, following the pattern of the existing modes.
3. Add the mode name to the argument list in the `# omarchy:args=` header and to the usage text above.
4. If the mode opens a GUI app through `gtk-launch`, confirm the matching `.desktop` file exists.

### Where config overrides live

Files under `config/` mirror the layout of `~/.config`. To override a default [Omarchy](https://omarchy.org) setting, add or edit the corresponding file there and rerun `install.sh`.

## Roadmap

This section is a planning note, not a list of implemented features. Move items out of it (and document them above) once they are added to the repo.

### Hyprland

- Keybinding to run `bin/mode` directly from the keyboard (`~/.config/hypr/bindings.conf`)
- Custom workspace-switching bindings
- Bindings for other utility scripts
- Per-mode window rules (`windowrule`) to position windows automatically, for example pinning the browser to a specific workspace in work mode
- Additional autostart entries for background services (`~/.config/hypr/autostart.conf` or `exec-once` in `hyprland.conf`), kept separate from manual modes

### Waybar

- Custom module showing the active mode, backed by a simple state file in `/tmp` or `$XDG_RUNTIME_DIR` (a `custom/<name>` module with an `exec` script)
- Alternate formats for battery and network status

### Theming

- Personal theme or colorscheme override for [Omarchy](https://omarchy.org)'s defaults (typically under `~/.config/omarchy/current/theme` or a theme symlink), applied consistently across the terminal, [Hyprland](https://hypr.land) borders, and [Waybar](https://github.com/Alexays/Waybar)

### Scripts and tooling

- State and tracking script that records the active mode, or appends a history of modes to a log file, for work and relax time tracking
- Wrapper around `omarchy launch browser|webapp` with default flags, such as a specific browser profile or a special window rule
- Additional [Rofi](https://github.com/davatorium/rofi) or [Walker](https://github.com/abenz1267/walker) selection menus (similar to `omarchy-menu-select`), for example a quick launcher for project folders
- `notify-send` calls at key points in `bin/mode` for visual feedback when a mode runs successfully

## Troubleshooting

- **`mode: command not found`**: the `bin/` directory is not on `$PATH`, or the script is not executable.
- **An app does not open in a mode**: check that its `.desktop` file exists and that `gtk-launch <name>` works from a terminal.
- **The command does not appear in the [Omarchy](https://omarchy.org) menu**: verify the `# omarchy:summary=` and `# omarchy:args=` header lines are present and correctly formatted.
- **A config change has no effect**: rerun `install.sh`, then reload [Hyprland](https://hypr.land) or restart the affected program.
