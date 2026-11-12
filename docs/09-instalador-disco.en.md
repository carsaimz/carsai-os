# 09 — Disk installer (Calamares)
> **English** | [Português](09-instalador-disco.md)

> The ISO is *live*, but Carsai OS is a system meant to be installed. This
> chapter documents the disk installer: what is configured, how it is run
> and the deliberate limits of v0.1.x.

## 9.1 Tool choice

**Calamares** (the `calamares` package from Debian bookworm, 3.2.61).
Criteria:

- it is the standard installer of derivative distros (KDE neon, Manjaro,
  unofficial Debian live) — mature, modular and configurable via YAML;
- it runs from the live session, copying the squashfs to the disk — the
  installed target is **byte-for-byte the already validated live system**
  (themes, Wine, statusbar, shortcuts);
- it follows the anti-overengineering principle (ch. 06): no homegrown
  installer, no rewriting what Debian already solves.

The `calamares-settings-debian` package is **not** installed (it would
bring Debian's own branding and custom modules). The sequence uses only
standard modules from the `calamares` package, with its own configuration
in `build/live/config/includes.chroot/etc/calamares/`.

## 9.2 How the user installs

1. Boot the ISO (live) — it enters XFCE with Carsai Neon;
2. Open **"Install Carsai OS"** (Whisker Menu → System) — the
   `carsai-installer.desktop` launcher runs `pkexec calamares`
   (`policykit-1-gnome` provides the authentication agent);
3. Wizard: language → keyboard → partitioning → user → summary → install
   (the slideshow shows the product logo and motto);
4. At the end, "Restart now" (optional checkbox) and boot the installed
   system.

## 9.3 What the configuration does

| File (`etc/calamares/`) | Role |
| --- | --- |
| `settings.conf` | Sequence with only standard modules; `carsai` branding |
| `modules/welcome.conf` | Requires **6 GiB** of disk and **2 GiB** of RAM (targets from ch. 02); checks root |
| `modules/unpackfs.conf` | Copies `/run/live/medium/live/filesystem.squashfs` → target |
| `modules/partition.conf` | 512 MiB EFI recommended; ext4 by default; no automatic LUKS |
| `modules/fstab.conf` | `noatime` + `discard` on SSD (inherited from Debian settings) |
| `modules/users.conf` | User in `sudo`, `netdev`, `plugdev`, etc.; no root password |
| `modules/displaymanager.conf` | Configures **LightDM** in the installed system |
| `modules/bootloader.conf` | GRUB2 (BIOS + EFI), `efiBootLoader: "grub"`, no i386 fallback |
| `modules/finished.conf` | Optional reboot at the end |
| `branding/carsai/branding.desc` | Identity: logo, sidebar colors, project URLs |
| `branding/carsai/show.qml` | Minimal slideshow (logo + neon text) |

Packages added to the ISO (see
`build/live/config/package-lists/calamares.list.chroot`): `calamares`,
`policykit-1` + `policykit-1-gnome` (pkexec + agent), `sudo`, `rsync`
(required by `unpackfs`), `dosfstools` (EFI partition), `os-prober`
(detects an existing Windows in GRUB), `grub-efi-amd64-bin` and
`grub-pc-bin` (to install in both boot modes).

## 9.4 Deliberate limits (v0.1.x)

- **No LUKS/LVM/btrfs** in partition creation: the target is plain ext4;
  manual partitioning remains possible (the `partition` module accepts
  existing tables);
- **Secure Boot**: the installed GRUB is not *signed* (there is no
  `shim-signed`); disable Secure Boot on the target machine. It is on the
  roadmap for 0.2.x;
- **No assisted dual-boot**: `os-prober` detects other OSes in GRUB, but
  the wizard does not resize Windows — the user uses "Manual";
- The version shown in the branding is fixed (`branding.desc`) — update it
  along with each tag.

## 9.5 How to test (minimum matrix)

1. **BIOS VM** (VirtualBox/QEMU, 16 GB disk): install with everything
   automatic, reboot, confirm GRUB → LightDM → Carsai session;
2. **UEFI VM** (QEMU with OVMF): same validation + check `/boot/efi`;
3. **Measure idle** in the installed system with `free -m` (method from
   ch. 02, target ≤ 800 MB) and attach the `carsai-doctor` report to the
   issue;
4. Failure of any step → issue with `/var/log/installation.log`
   (Calamares logs to `/root/.cache/calamares/` in the live session).
