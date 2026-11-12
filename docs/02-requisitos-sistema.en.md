# 02 — System requirements and base choice
> **English** | [Português](02-requisitos-sistema.md)

To reach the under-4 GB RAM goal with room to spare, the technical base needs
to be surgical. This chapter fixes the choices and the reference numbers.

## 2.1 Requirements table

| Layer | Recommended choice | Justification (with data) |
| --- | --- | --- |
| **Base** | Debian Stable (12 bookworm) | Proven stability, a vast ecosystem and long-term support. It is the base of MX Linux and antiX, both reference points for lightness. |
| **Graphical environment** | XFCE (primary) or LXQt (alternative) | XFCE is the ideal balance between low consumption and visual customization capability. LXQt is even lighter, but with less aesthetic flexibility. |
| **Target consumption (idle)** | ≤ 800 MB of RAM | Since v0.1.x Carsai ships a rich panel, 32+64-bit Wine and the hacker toolkit pre-installed — the session floor has gone up. With a 2 GB minimum and zram, 800 MB at idle leaves ~1.2 GB usable (real headroom; MX Linux, also XFCE, sits at ~600–700 MB). |
| **Absolute minimum requirement** | 2 GB of RAM for installation and basic use | As of v0.1.x the product assumes **2 GB as the floor** (decision 2026-11-12: up to 800 MB at idle is acceptable). With zram zstd at 25%, a 2 GB machine fits the session + browser with room to spare; 1 GB is no longer an official profile. |

## 2.2 Official product requirements

| Profile | RAM | Disk | Expected usage |
| --- | --- | --- | --- |
| **Minimum** | 2 GB | 8 GB | Install, basic XFCE session, 1–2 light apps |
| **Recommended** | 4 GB | 16 GB | Daily use: browser, office, light Wine |
| **Comfortable** | 8 GB | 32 GB | Heavy browsing + Wine + active Waydroid |

## 2.3 Architecture decision

**Focus on 64-bit (amd64)**, aligned with the majority of hardware with 2–4 GB
of RAM. Support for 32-bit (i386) remains a future possibility only if there is
real demand, because:

- the ecosystem has migrated to 64-bit (modern browsers and apps no longer
  publish i386 builds);
- Debian maintains i386 only partially (as a compatibility library, not as a
  first-class architecture);
- maintaining two architectures doubles the cost of testing the ISO.

## 2.4 How the 800 MB goal is reached

Idle consumption is the sum of (a) kernel + initramfs, (b) system services,
(c) graphical session. The plan per layer:

1. **Kernel**: use the generic Debian `linux-image-amd64` — fine tuning
   (preemption, timer frequency) is done through boot parameters, not by
   recompiling (see chapter 06).
2. **Services**: a build hook disables desktop services that are not
   essential (cups, bluetooth, modemmanager, avahi). APT recommends are turned
   off (`--apt-recommends false`) to avoid pulling in heavy "friendly"
   dependencies.
3. **Session**: XFCE without a heavy compositor by default; static wallpaper
   (not animated); no background file indexing. The rich statusbar
   (genmon + systemload + dock) costs ~30–50 MB — already counted in the goal.
4. **Smart memory**: `zram` (zram-tools) with zstd at 25% of RAM —
   it compresses instead of swapping to disk, easing machines with 2 GB.
5. **Tuned sysctl**: `vm.swappiness=15` and `vm.vfs_cache_pressure=50`
   (provided in `build/live/config/includes.chroot/etc/sysctl.d/`).

## 2.5 Community reference numbers (to calibrate expectations)

> Reference values published by the respective projects; they serve to
> calibrate goals, not as an official benchmark.

| System | Environment | Approximate idle RAM |
| --- | --- | --- |
| antiX 26 | IceWM | < 500 MB |
| Lubuntu | LXQt | ~400 MB |
| MX Linux | XFCE | ~600–700 MB |
| **Carsai OS (goal)** | Lean XFCE + rich panel | **≤ 800 MB** |

The project's official measurement method (for all comparable tests):

1. Live boot (ISO) or installed session, with no active network.
2. 5 minutes of idle session, with no apps open.
3. `free -m` → the value of the `available` column subtracted from total RAM.

## 2.6 Why XFCE and not LXQt, by default

- XFCE has **customization maturity** (xfconf, xfwm4, modular panels) that
  makes it possible to apply the Neon theme to the entire desktop in a
  reliable, programmatic way.
- Carsai's differentiator is the visual layer; LXQt saves ~100–150 MB, but
  makes that same visual fidelity harder to achieve.
- The LXQt alternative remains on the roadmap as a future variation for even
  older hardware, with a simplified aesthetic; it is out of the scope of the
  current product (2 GB minimum).
