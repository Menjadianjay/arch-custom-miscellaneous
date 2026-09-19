  dotfiles

  Personal configuration and scripts for Omarchy (https://omarchy.org), an Arch Linux + Hyprland distro/setup made by DHH. This repo stores customizations on top of a default
  Omarchy install: extra commands, config overrides, and workflow tweaks.

  Structure

  .
  ├── bin/                # extra commands/scripts (invoked via omarchy-menu or directly)
  │   └── mode            # opens an app set based on work mode
  ├── config/             # overrides for ~/.config (hypr, waybar, walker, etc.)
  └── install.sh          # symlinks/copies files to the right locations

  Adjust the structure above to match the repo's actual contents.

  bin/mode

  Script that opens a set of applications at once based on a work mode (code, relax, socialize, tetris, study, work, eat), using omarchy launch and gtk-launch.

  Usage:

  mode [code|relax|socialize|tetris|study|work|eat]

  Without an argument, the script calls omarchy-menu-select to pick a mode interactively. Details for each mode (URLs, apps opened) are hardcoded directly in the script; edit the
  case block to customize.

  The # omarchy:summary= and # omarchy:args= metadata in the file header are used by Omarchy to display the command's description in its menu.

  Other customization ideas that could be applied

  The list below is a set of technical directions commonly taken on top of Omarchy, noted here for future development of this repo:

  - Extra Hyprland keybindings (~/.config/hypr/bindings.conf or similar): a binding to run bin/mode directly from the keyboard, a binding for custom workspace switching, or
    bindings for other utility scripts.
  - Custom waybar module: add a module in ~/.config/waybar/config that shows the active mode status (e.g. from a simple state file in /tmp or $XDG_RUNTIME_DIR), battery/network
    status with a different format, or another custom indicator via a custom/<name> module with an exec script.
  - Theme/colorscheme override: replace Omarchy's default color scheme (usually at ~/.config/omarchy/current/theme or a theme symlink) with a personal theme applied consistently
    across terminal, Hyprland borders, and waybar.
  - Additional autostart entries: add applications to ~/.config/hypr/autostart.conf (or exec-once in hyprland.conf) for services that should always run in the background, separate
    from manual modes like bin/mode.
  - State/tracking script: a simple script that records the currently active mode or a history of modes run (appended to a log file) for work/relax time tracking purposes.
  - Wrapper for omarchy launch: an additional function/alias that wraps omarchy launch browser|webapp with certain default flags (e.g. a specific browser profile, or a special
    window rule).
  - Custom Rofi/Walker menu: additional selection menus (similar to omarchy-menu-select) for needs beyond mode selection, e.g. a quick launcher for project folders.
  - Per-mode window rules: Hyprland rules (windowrule) to automatically position windows opened by each mode (e.g. the browser always on a specific workspace when work mode is
    active).
  - Notification integration: add notify-send at certain points in the script (e.g. when a mode runs successfully) for visual feedback without needing to check the terminal.

  This section is a planning note, not something already implemented in the repo; update it once a feature is actually added.

  Installation

  Explain here how to symlink/copy configs from the repo to $HOME, e.g. via stow or a custom install.sh script, depending on the method used.

  Requirements

  - Omarchy installed and the omarchy CLI available on $PATH.
  - Hyprland as the window manager (Omarchy's default).
  - gtk-launch and .desktop files for the GUI apps referenced by the script (VS Code, WhatsApp, Discord, Tetr.io, Obsidian, etc.).
