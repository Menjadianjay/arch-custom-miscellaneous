# mode

Bash script untuk membuka sekumpulan aplikasi/browser sesuai mode kerja tertentu, menggunakan Omarchy (`omarchy launch`, `omarchy-menu-select`) dan `gtk-launch` sebagai launcher.

## Requirement

- Bash (`set -euo pipefail`)
- Omarchy CLI tersedia di `$PATH`:
  - `omarchy launch browser [url]`
  - `omarchy launch webapp <url>`
  - `omarchy agent`
  - `omarchy-menu-select`
- `gtk-launch` dan file `.desktop` berikut terpasang:
  - `code.desktop`
  - `WhatsApp.desktop`
  - `Discord.desktop`
  - `tetrio-desktop.desktop`
  - `obsidian.desktop`

## Usage

```
mode [code|relax|socialize|tetris|study|work|eat]
```

Jika argumen tidak diberikan, script memanggil `omarchy-menu-select` dengan daftar opsi `code relax socialize tetris study work eat` dan menunggu pilihan interaktif. Jika menu dibatalkan, script keluar dengan status 0 (`exit 0`).

Jika argumen tidak dikenali, script mencetak pesan usage ke stderr dan keluar dengan status 1.

## Metadata

```
# omarchy:summary=Open the app set for a work/relax/socialize mode
# omarchy:args=[work|relax|socialize]
```

Dua baris komentar di atas adalah metadata yang dibaca oleh Omarchy untuk menampilkan deskripsi command dan daftar argumen yang valid di UI-nya. Perlu dicatat metadata `args` hanya mencantumkan `work|relax|socialize`, tidak sinkron dengan opsi aktual di `case` (`code`, `tetris`, `study`, `eat` juga valid).

## Mode behavior

| Mode | Aksi |
|---|---|
| `code` | Buka browser ke GitHub profile, lalu Notion, lalu webapp pencarian YouTube (playlist rnb), jalankan `omarchy agent` di background, lalu jalankan VS Code |
| `relax` | Buka browser kosong, lalu webapp YouTube |
| `socialize` | Pilih genre musik acak dari array (`keshi`, `rnb`, `lany`, `2016 edm`), buka browser kosong, webapp pencarian YouTube sesuai genre, lalu WhatsApp dan Discord |
| `tetris` | Buka webapp video YouTube tertentu, lalu jalankan Tetr.io desktop |
| `study` | Buka browser ke GitHub profile, webapp YouTube, lalu Obsidian |
| `work` | Buka browser ke Gmail, GitHub profile, dan Notion, lalu webapp YouTube, lalu Obsidian |
| `eat` | Buka browser ke URL streaming tertentu |

Setiap blok `case` memakai `sleep 1` di antara beberapa pemanggilan `omarchy launch`/`gtk-launch` untuk menghindari race condition saat beberapa proses GUI dijalankan berurutan.

## Catatan implementasi

- Pemilihan genre acak pada mode `socialize` menggunakan `RANDOM % ${#genres[@]}` (bukan sumber acak kriptografis, cukup untuk keperluan ini).
- URL query YouTube dibangun dengan substitusi `${genre// /+}` untuk mengganti spasi jadi `+` sebelum digunakan sebagai query string.
- Semua URL, nama genre, dan nama file `.desktop` di-hardcode di dalam script; untuk mengubah aplikasi/URL per mode, edit langsung blok `case` yang bersangkutan.
- Tidak ada validasi apakah `gtk-launch` atau file `.desktop` yang direferensikan benar-benar ada di sistem; jika tidak ada, command akan gagal saat runtime karena `set -e`.
