# ROADMAP — Carsai OS
> **English** | [Português](ROADMAP.md)

> Board of phases and the version train. The detailed exit criteria of
> each phase live in [`docs/07-roadmap.en.md`](docs/07-roadmap.en.md); this
> file is the **current status**, updated with each delivery.

Last updated: 2026-11-12

## What is already done

### Phase 1 — Base ✅
- [x] Bootable ISO built by CI on every push (`Build ISO`, green)
- [x] live-build on Debian 12 bookworm, amd64, XFCE, `--apt-recommends false`
- [x] Trimmed services (cups/bluetooth/modemmanager/avahi), sysctl + zram

### Phase 2 — Identity ✅
- [x] 4 complete themes (GTK3 + generated **xfwm4** + terminal schemes)
- [x] `carsai-theme-selector` (GTK, xfwm4, wallpaper and terminal in one go)
- [x] Per-theme wallpapers, logo, ASCII art; branded LightDM
- [x] **Rich statusbar**: whiskermenu, pager, genmon (`carsai-statusbar`:
      CPU %, RAM %, network ↓/↑), systemload, tray, volume, clock with seconds
- [x] **Bottom dock** with intellihide and grouped tasklist
- [x] **Windows-style shortcuts**: Win (menu), Win+E/R/D/L/V, snap Win+arrows,
      workspaces Ctrl+Win+arrows / Win+1..4, Ctrl+Alt+Del, PrintScreen
- [x] Hacker banner on first boot (ASCII, neofetch, cheat sheet)

### Phase 3 — Windows (.exe) ✅
- [x] 64-bit **and 32-bit** Wine (i386 multiarch enabled in the build) + winetricks
- [x] `carsai-exe app.exe` (terminal) and opening .exe files by double-click in Thunar
- [x] Limitations documented (chapter 04)

### Phase 4 — Android (.apk) 🔶 (under validation)
- [x] `scripts/install-waydroid.sh` (official Waydroid repo + weston)
- [x] `carsai-android` — phone-style launcher in a nested window (X11)
- [ ] Validation on VM/real hardware (binder, kernel modules, GAPPS vs vanilla)

### Phase 5 — Installer and refinement 🔶 (in progress)
- [x] **Calamares** in the ISO with `carsai` branding and an "Install Carsai OS" launcher
- [x] `carsai-update` (APT update) and `carsai-doctor` (bug report)
- [x] Revised memory targets: **≤ 800 MB idle, minimum 2 GB**
- [ ] Installer testing in a VM (BIOS + UEFI)
- [ ] Official idle measurement (`free -m`) in a 2 GB VM
- [ ] Final services audit and **0.1.0-beta** release

## Version train

| Version | Planned content | Status |
| --- | --- | --- |
| **v0.1.0-alpha** | First public ISO: Windows+hacker shell, Wine, statusbar, themes | ✅ released ([release](https://github.com/carsaimz/carsai-os/releases/tag/v0.1.0-alpha)) |
| **v0.1.1-alpha** | Calamares installer, `carsai-update`, `carsai-doctor`, revised RAM targets | ✅ released ([release](https://github.com/carsaimz/carsai-os/releases/tag/v0.1.1-alpha)) |
| **v0.1.2-alpha** | Waydroid validation on VM, Carsai icon theme, xfwm4 tech strokes, bilingual documentation, screenshots gallery | 🚧 icons + xfwm4 + bilingual docs on `main` |
| **v0.2.0-alpha** | Tested installer (BIOS+UEFI), idle measurement in a 2 GB VM, services tuning | 📋 planned |
| **v0.1.0-beta** | Phase 5 closed: real hardware ≥ 2 machines, user docs, public release with checksums | 📋 planned |
| **1.0** | First stable for the general public (Debian base of the time) | 🔭 vision |

## Immediate next steps

1. Test the v0.1.1-alpha ISO in a VM: live boot, `free -m` at idle
   (target ≤ 800 MB), Calamares installer on a virtual disk (BIOS and UEFI).
2. Validate Waydroid (`install-waydroid.sh` + `carsai-android`) in a VM with
   Wayland/X11 and record the results in chapter 05.
3. Replace the provisional logo with the official artwork (just overwrite
   `branding/logo/carsai-os-icon.svg`).
4. Publish **v0.1.2-alpha** once the Waydroid validation and the screenshots
   gallery close (the *Release ISO* workflow attaches the ISO + sha256).
5. Official site live: <https://carsaios.vercel.app> (deploy on Vercel).

## How we decide what gets in

Anti-overengineering criterion (chapter 06): Debian apt before packaging
from scratch; scripts instead of daemons; container before VM; and no
feature that pushes idle above the target without a documented decision.
A phase only closes with measured numbers, not feelings.
