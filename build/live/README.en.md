# Build directory — Carsai OS ISO (live-build)
> **English** | [Português](README.md)

This directory contains the **recipe** for the Carsai OS ISO (not the
generated artifacts — build outputs are never committed to version
control).

## Structure

```
build/live/
├── auto/                      # entry-points do live-build (config/build/clean)
├── config/
│   ├── package-lists/         # lista de pacotes do Carsai OS
│   ├── hooks/live/            # hooks executados no chroot (trimação de serviços)
│   └── includes.chroot/       # ficheiros injetados no sistema de ficheiros da ISO
│       ├── etc/sysctl.d/      # afinação de RAM (swappiness, vfs_cache_pressure)
│       ├── etc/default/       # config do zram (zstd, 25%)
│       ├── etc/lightdm/       # branding do ecrã de login
│       └── etc/skel/          # autostart de primeiro arranque (tema Neon)
```

`scripts/build-iso.sh` syncs `themes/` and `branding/` into
`config/includes.chroot/usr/share/` before invoking live-build — so the
themes exist **only once** in the repository (in `themes/`).

## How to build

From the repository root:

```bash
sudo apt-get install -y live-build debootstrap squashfs-tools xorriso
./scripts/build-iso.sh
```

The ISO is generated at `build/live/*.iso` (typical name:
`live-image-amd64.hybrid.iso`). The full log is at
`build/carsai-os-build.log`.

## Notes

- `--apt-recommends false` keeps the image lean; if a package needs
  recommends, add it explicitly to the list.
- `--debian-installer none`: the disk installer is on the roadmap
  (Phase 2); Phase 1 validates the live ISO.
- `--archive-areas` includes `non-free-firmware` for Wi-Fi/GPU on real
  hardware.
