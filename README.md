# dotfiles

Konfigurasi dan script pribadi untuk [Omarchy](https://omarchy.org), sebuah Arch Linux + Hyprland distro/setup buatan DHH. Repo ini menyimpan kustomisasi di atas instalasi Omarchy default: command tambahan, override konfigurasi, dan tweak workflow.

## Struktur

```
.
├── bin/                # command/script tambahan (dipanggil lewat omarchy-menu atau langsung)
│   └── mode            # buka app set sesuai mode kerja
├── config/             # override untuk ~/.config (hypr, waybar, walker, dll)
└── install.sh          # symlink/copy file ke lokasi yang sesuai
```

Sesuaikan struktur di atas dengan isi repo yang sebenarnya.

## bin/mode

Script untuk membuka sekumpulan aplikasi sekaligus berdasarkan mode kerja (`code`, `relax`, `socialize`, `tetris`, `study`, `work`, `eat`), menggunakan `omarchy launch` dan `gtk-launch`.

Usage:

```
mode [code|relax|socialize|tetris|study|work|eat]
```

Tanpa argumen, script memanggil `omarchy-menu-select` untuk memilih mode secara interaktif. Detail tiap mode (URL, aplikasi yang dibuka) di-hardcode langsung di dalam script; ubah blok `case` untuk menyesuaikan.

Metadata `# omarchy:summary=` dan `# omarchy:args=` di header file dipakai Omarchy untuk menampilkan deskripsi command di menu-nya.

## Ide kustomisasi lain yang mungkin diterapkan

Daftar berikut adalah arah teknis yang umum dilakukan di atas Omarchy, sebagai catatan untuk pengembangan repo ke depan:

- **Keybinding tambahan di Hyprland** (`~/.config/hypr/bindings.conf` atau sejenis): binding untuk menjalankan `bin/mode` langsung dari keyboard, binding untuk workspace switching custom, atau binding untuk script utilitas lain.
- **Waybar module custom**: menambah modul di `~/.config/waybar/config` yang menampilkan status mode aktif (misalnya dari file state sederhana di `/tmp` atau `$XDG_RUNTIME_DIR`), status baterai/network dengan format berbeda, atau indikator custom lain via `custom/<name>` module dengan script exec.
- **Theme/colorscheme override**: mengganti skema warna default Omarchy (biasanya di `~/.config/omarchy/current/theme` atau symlink tema) dengan tema pribadi untuk terminal, Hyprland border, dan waybar sekaligus, supaya konsisten.
- **Autostart tambahan**: menambahkan aplikasi ke `~/.config/hypr/autostart.conf` (atau exec-once di hyprland.conf) untuk service yang selalu ingin jalan di background, terpisah dari mode manual seperti `bin/mode`.
- **Script state/tracking**: script sederhana yang mencatat mode yang sedang aktif atau riwayat mode yang dijalankan (append ke file log) untuk keperluan tracking waktu kerja/relax.
- **Wrapper untuk `omarchy launch`**: fungsi/alias tambahan yang membungkus `omarchy launch browser|webapp` dengan default flag tertentu (misalnya profile browser tertentu, atau window rule khusus).
- **Rofi/Walker custom menu**: menu selection tambahan (mirip `omarchy-menu-select`) untuk kebutuhan lain di luar pemilihan mode, misalnya quick launcher untuk project folder.
- **Window rules per mode**: aturan Hyprland (`windowrule`) untuk memposisikan otomatis jendela yang dibuka tiap mode (misalnya browser selalu di workspace tertentu saat mode `work` aktif).
- **Integrasi notifikasi**: menambahkan `notify-send` di titik tertentu dalam script (misalnya saat mode berhasil dijalankan) untuk feedback visual tanpa harus melihat terminal.

Bagian ini bersifat catatan rencana, bukan implementasi yang sudah ada di repo; update begitu fitur benar-benar ditambahkan.

## Instalasi

Jelaskan di sini cara symlink/copy config dari repo ke `$HOME`, misalnya via `stow` atau script `install.sh` custom, sesuai metode yang dipakai.

## Requirement

- Omarchy terpasang dan `omarchy` CLI tersedia di `$PATH`.
- Hyprland sebagai window manager (bawaan Omarchy).
- `gtk-launch` dan file `.desktop` untuk aplikasi GUI yang direferensikan oleh script (VS Code, WhatsApp, Discord, Tetr.io, Obsidian, dll).
