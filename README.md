<div align="center">

<img src="branding/logo/carsai-os-icon.svg" width="120" alt="Carsai OS icon"/>

# Carsai OS

**A lightweight, Debian-based Linux distribution with a tech/neon identity.**

[![Build ISO](https://github.com/carsaimz/carsai-os/actions/workflows/build-iso.yml/badge.svg)](https://github.com/carsaimz/carsai-os/actions/workflows/build-iso.yml)
![License: MIT](https://img.shields.io/badge/License-MIT-00e5ff.svg)
![Platform: Debian](https://img.shields.io/badge/base-Debian%2012%20Bookworm-A81D33.svg)
![Desktop: XFCE](https://img.shields.io/badge/desktop-XFCE-2284f2.svg)
![Website](https://img.shields.io/badge/site-carsaios.vercel.app-ff2bd6.svg)
[![Português](https://img.shields.io/badge/idioma-Portugu%C3%AAs-00e5ff.svg)](README.pt.md)

</div>

---

**Carsai OS** is a custom Linux distribution derived from **Debian Stable**, designed to run comfortably on machines with **2–4 GB of RAM**, wrapped in a modern, immersive **tech / cyberpunk / neon** visual identity.

It does not try to compete with general-purpose distros on feature count. The goal is a **cohesive, stylish and efficient** experience on modest hardware, with a planned path for **Windows (.exe)** and **Android (.apk)** application compatibility.

> "Carsai" is the umbrella name of the project (**Carsai Mozambique**) and has no relation to AI. Artifacts may be named *Carsai OS* (product) or *Carsai LinuOs* (variant); the prefix is the identity.

> Official website: **https://carsaios.vercel.app** (repo: `carsai-os-site`, private).

## Goals

| Metric | Target |
| --- | --- |
| Idle RAM usage (XFCE session) | ≤ 800 MB |
| Minimum RAM for install / basic use | 2 GB |
| Recommended RAM | 4 GB |
| Architecture (initial) | 64-bit (amd64) |
| Base | Debian 12 "Bookworm" |
| Desktop | XFCE (main), LXQt (future alternative) |

For the rationale and benchmarks behind these targets, see the [documentation](docs/README.md).

## What is in the box (v0.1.0-alpha)

- **Windows-like shell, hacker aesthetic** — start menu with the Carsai icon,
  taskbar/dock, `Win+E` / `Win+R` / `Win+D` / `Win+L` / `Win+V`, window snap
  with `Win+arrows`, workspaces via `Ctrl+Win+arrows` or `Win+1..4`,
  `Ctrl+Alt+Del` task manager, PrintScreen variants (full chapter:
  [docs/08](docs/08-shell-atalhos-e-statusbar.md)).
- **Rich statusbar** — top panel with live CPU %, RAM % and network
  down/up rates (zero-dependency genmon feed), system load bars, tray,
  volume, seconds clock, workspace pager.
- **.exe support out of the box** — Wine 64-bit **and 32-bit** (i386
  multiarch built into the ISO), winetricks, fonts; `carsai-exe app.exe`
  from the terminal or double-click in Thunar.
- **Android path** — one-command installer (`scripts/install-waydroid.sh`)
  plus the `carsai-android` launcher (nested phone-style window on X11).
- **xfwm4 neon decorations** — generated title bars/buttons matching each
  of the four themes (GTK + window decorations switch together).
- **First-boot welcome** — ASCII-art banner with neofetch, shortcut cheat
  sheet and the Carsai command hints; shows once, never again.
- **Hacker toolkit pre-installed** — btop, neofetch, tmux, ranger, ncdu,
  cmatrix, xdotool, wmctrl, plus Firefox ESR as the browser.

## Landed on main (next release: v0.1.1-alpha)

- **Disk installer** — Calamares with the `carsai` branding and an
  "Install Carsai OS" launcher; full config + limits in [docs/09](docs/09-instalador-disco.md).
- **`carsai-update`** — apt update + full-upgrade (plus `--clean`).
- **`carsai-doctor`** — one-shot system report (idle RAM vs target, zram,
  services, themes) to attach to bug reports.
- **Memory targets revised** — ≤ 800 MB idle, 2 GB minimum RAM (was 600 MB / 1 GB).

## Releases

Every git tag builds a release ISO automatically:

```bash
git tag v0.1.1-alpha && git push origin v0.1.1-alpha
# the Release ISO workflow attaches carsai-os-<version>-amd64.iso + .sha256
# to the GitHub Release for that tag
```

Grab the latest image from the
[Releases page](https://github.com/carsaimz/carsai-os/releases). Non-tag
code still produces a 7-day artifact from the *Build ISO* workflow.

## Theme gallery (pre-installed)

The default theme is **Carsai Neon**. Three more complete themes ship with the system and can be switched with the built-in theme selector.

| Theme | Mood |
| --- | --- |
| **Carsai Neon** (default) | Dark, cyan/magenta accents, subtle glow, monospace titles |
| **Carsai Dark Minimal** | Sober dark, for productivity |
| **Carsai Retrowave** | Synthwave / outrun gradients |
| **Carsai Light Tech** | Light with tech accents, for bright rooms |

| Neon | Dark Minimal |
| --- | --- |
| ![Carsai Neon wallpaper](branding/wallpapers/carsai-neon.png) | ![Carsai Dark Minimal wallpaper](branding/wallpapers/carsai-dark-minimal.png) |
| **Retrowave** | **Light Tech** |
| ![Carsai Retrowave wallpaper](branding/wallpapers/carsai-retrowave.png) | ![Carsai Light Tech wallpaper](branding/wallpapers/carsai-light-tech.png) |

## Repository layout

```
carsai-os/
├── build/live/          # live-build configuration (ISO recipe)
├── branding/            # logo, wallpapers, ASCII art
├── docs/                # technical documentation (Portuguese)
├── scripts/             # build-iso.sh, install-themes.sh, Waydroid, system scripts
└── themes/              # GTK + xfwm4 themes, terminal schemes, theme selector
```

## Build the ISO yourself

Requirements: any Linux host with Docker or root, ~15 GB free disk, internet.

```bash
git clone https://github.com/carsaimz/carsai-os.git
cd carsai-os
sudo apt-get install -y live-build debootstrap squashfs-tools xorriso
./scripts/build-iso.sh
# ISO lands in build/live/*.iso
```

The GitHub Actions workflow (**Build ISO**) produces the same artifact on every push to `main` that touches `build/`, `themes/` or `branding/` — download it from the *Actions* tab (*Artifacts*, kept for 7 days).

## Test in a virtual machine

```bash
qemu-system-x86_64 -m 2048 -enable-kvm -cdrom build/live/carsai-os-*.iso
```

## Roadmap

- [x] Project scaffold: documentation, live-build config, themes, branding, CI
- [x] **Phase 1 — Base**: bootable ISO built in CI (green build, artifact)
- [x] **Phase 2 — Identity**: 4 themes (GTK + xfwm4), wallpapers, selector,
      rich statusbar + dock, Windows-style shortcuts, welcome banner
- [x] **Phase 3 — Wine**: Wine 32+64-bit pre-installed, carsai-exe, documented limits
- [ ] **Phase 4 — Waydroid**: installer script ready; evaluate on real Wayland-capable XFCE
- [~] **Phase 5 — Refinement**: Calamares installer + carsai-update/carsai-doctor
      landed; VM tests (idle RAM, BIOS/UEFI install) pending

Details in [ROADMAP.md](ROADMAP.md) (status board) and
[docs/07-roadmap.md](docs/07-roadmap.md) (exit criteria).

## Documentation

The technical documentation is written in Portuguese:

1. [Visão geral e filosofia](docs/01-visao-geral.md)
2. [Requisitos de sistema e escolha da base](docs/02-requisitos-sistema.md)
3. [Sistema de temas (identidade visual)](docs/03-temas.md)
4. [Compatibilidade com Windows (.exe)](docs/04-compatibilidade-windows.md)
5. [Compatibilidade com Android (.apk)](docs/05-compatibilidade-android.md)
6. [Decisões de arquitectura (o que não fazer)](docs/06-arquitetura-decisoes.md)
7. [Roteiro de implementação](docs/07-roadmap.md)
8. [Shell: atalhos, statusbar e a experiência Windows + Android](docs/08-shell-atalhos-e-statusbar.md)
9. [Instalador de disco (Calamares)](docs/09-instalador-disco.md)

## Contributing

Pull requests are welcome! Read [CONTRIBUTING.md](CONTRIBUTING.md) first (commit conventions, how to test, repo areas).

## License

[MIT](LICENSE) © Carsai Mozambique (CarsaiMz)

Upstream work (Debian, XFCE, live-build, ...) keeps its own licenses.
