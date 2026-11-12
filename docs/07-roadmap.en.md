# 07 — Implementation Roadmap
> **English** | [Português](07-roadmap.md)

High-level roadmap, with exit criteria per phase. A phase is only considered
closed when **all** criteria are verified and documented (with numbers, not
feelings).

> **Current status and release train:** see the live picture in
> [`ROADMAP.md`](../ROADMAP.en.md) (repo root). This chapter keeps the
> detailed exit criteria.

## Current repository state (2026-11-12)

- [x] Complete technical documentation (`docs/01`–`docs/09`)
- [x] live-build configuration ready to build the ISO (`build/live/`)
- [x] Four GTK3 themes **+ xfwm4** + terminal color schemes + selector (`themes/`)
- [x] AI-generated wallpapers + provisional logo (`branding/`)
- [x] CI that builds the ISO on every relevant push (`.github/workflows/`)
- [x] v0.1.0-alpha release published with ISO + sha256
- [x] Hacker-style Windows + Android shell (statusbar, dock, shortcuts, Wine,
      Waydroid, banner) — chapter 08

## Phase 1 — Foundation

**Objective**: remaster Debian Stable with XFCE, applying the "Carsai Neon"
theme and the theme gallery. **Tool**: live-build (this repo uses live-build;
*Cubic* is a graphical alternative for those who prefer one).

**Already implemented in the scaffold**: `auto/config` (bookworm, amd64,
XFCE, `--apt-recommends false`), package list `carsai-os.list.chroot`,
service trimming hook, sysctl + zram, LightDM branding, first-boot autostart.

**Exit criteria**:

- [x] Bootable ISO produced by CI and locally (`build/live/*.iso`)
- [ ] XFCE session starts with Carsai Neon applied (first boot)
- [ ] ≤ 800 MB of idle RAM measured by the official method (chapter 02)
- [ ] Basic installation works in a VM with 2 GB of RAM

> Boot via CI confirmed; VM measurements are left for Phase 5
> (tool: `carsai-doctor` generates the report to attach to the issue).

## Phase 2 — Identity

**Objective**: package themes, icons, wallpapers and the theme selector;
test in a VM with 2 GB and 4 GB of RAM.

**Tasks**:

- [x] xfwm4 theme with custom-drawn title bar (own assets)
- [ ] Carsai icon theme (lean base, targeted overrides)
- [ ] Visual fidelity testing of the 4 themes in XFCE GTK3 apps
- [ ] Selector applet/launcher in the panel (optional, UX)
- [ ] Visual regression screenshot suite

**Exit criteria**: 4 complete themes with no breakage in XFCE core apps;
theme switching via the selector < 5 s, without logout.

## Phase 3 — Wine

**Objective**: pre-install Wine + Bottles/Lutris with essential libraries
and document limitations.

**Tasks**:

- [x] Decide: inside the ISO vs. post-install installer (**inside the ISO**,
      with wine32:i386 enabled at build time — ISO ~1.3 GB)
- [ ] Default prefix + winetricks core (corefonts, vcrun)
- [ ] Compatibility document (tested apps, what fails and why)
- [ ] RAM benchmarks with a typical productivity app

**Exit criteria**: a real productivity .exe runs from Bottles without manual
commands; limitations documented.

## Phase 4 — Waydroid

**Objective**: assess the maturity of Wayland on XFCE/Debian at that point.
If viable, integrate Waydroid as "Carsai Android" (optional at install).

**Tasks**:

- [x] `scripts/install-waydroid.sh` + `carsai-android` (launcher in a nested
      window on X11 — implemented before the formal assessment)
- [ ] Wayland status report for XFCE (4.20+/Debian of the time)
- [ ] Prototype: Waydroid in a separate Wayland session vs. X11 integration
- [ ] Documented decision (Scenario A of chapter 05)

**Exit criteria**: Android app opens as an integrated window OR a justified
decision to postpone, with an alternative plan.

## Phase 5 — Refinement

**Objective**: stress tests on real hardware with 2 GB and 4 GB, service
tuning (disable whatever is not essential), user documentation.

**Tasks**:

- [x] Disk installer (Calamares, `carsai` brand, docs/09)
- [x] `carsai-update` + `carsai-doctor` (maintenance and reports)
- [ ] Real-hardware test matrix (≥ 3 machines, with/without SSD)
- [ ] Final audit of services active at idle
- [ ] User manual (install, update, themes, compatibility)
- [ ] Release: first public 0.1.0-beta ISO with checksums

**Exit criteria**: 0.1.0-beta release published; no RAM regressions vs.
Phase 1; user documentation reviewed by a third party.

## Version governance

- `-alpha`: scaffold and experimental phases (now).
- `-beta`: Phase 5 completed.
- `1.0`: first stable release for the general public.
