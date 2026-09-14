# Omarchy Customization Ideas

Catatan arah teknis untuk pengembangan lebih lanjut dari setup Omarchy pribadi, di luar script `mode` yang sudah ada. Bersifat rencana/roadmap, bukan implementasi yang sudah jadi.

## Hyprland

- Custom keybinding untuk workspace/window management: submap untuk resize, workspace per-monitor, scratchpad untuk floating terminal.
- `windowrule`/`windowrulev2` per aplikasi, misalnya paksa Obsidian selalu di workspace tertentu, atau video PiP selalu floating dan pinned di semua workspace.
- Layout switching otomatis (dwindle vs master) berdasarkan workspace, via rule `workspace` di `hyprland.conf`.
- Animasi custom (`animations.conf`) sebagai override dari default Omarchy.

## Waybar

- Modul custom (`custom/<name>`) yang exec script sendiri: indikator mode aktif dari `bin/mode`, status VPN, uptime custom, atau counter Pomodoro.
- Multiple config waybar untuk profile berbeda (minimal saat presentasi, penuh info saat kerja), di-switch lewat script terpisah.

## Script dan automation

- Wrapper screenshot/screen-record (`grim` + `slurp` + `wl-copy`) dengan naming convention dan folder output otomatis.
- Clipboard manager history dengan `cliphist`, dipadukan binding rofi/walker untuk paste dari history.
- Script "focus session": mematikan notifikasi, membuka aplikasi tertentu, menjalankan timer, lalu mengirim notifikasi saat selesai.
- Auto-backup dotfiles ke git secara periodik via systemd timer atau cron.

## Terminal dan shell

- Custom prompt (starship config) yang menampilkan context tambahan: git branch, exit code, durasi command.
- Alias/function set pribadi untuk workflow git, docker, atau project switching (integrasi `zoxide`).
- Template sesi tmux/zellij yang auto-restore layout untuk project tertentu.

## Theming

- Custom theme Omarchy sendiri (warna terminal, border Hyprland, waybar, rofi/walker) dalam satu skema konsisten, didaftarkan sebagai theme yang bisa di-switch lewat `omarchy-theme-set` (jika tersedia di versi Omarchy yang dipakai).
- Dynamic wallpaper dengan accent color extraction (mirip pywal) yang auto-update warna waybar/terminal saat wallpaper berganti.

## System-level

- Systemd user service untuk daemon kecil, misalnya idle detector yang trigger lock screen custom, atau auto-mute saat aplikasi meeting aktif.
- Network profile switching: script yang mengganti DNS/VPN config sesuai lokasi atau mode kerja.

## Status implementasi

| Area | Status |
|---|---|
| Mode launcher (`bin/mode`) | Sudah ada |
| Hyprland keybinding/windowrule custom | Belum |
| Waybar module custom | Belum |
| Screenshot/clipboard automation | Belum |
| Focus session script | Belum |
| Shell/prompt custom | Belum |
| Theme custom | Belum |
| Systemd service tambahan | Belum |

Update tabel ini setiap kali satu item benar-benar diimplementasikan di repo.
