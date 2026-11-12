# Technical documentation — Carsai OS
> **English** | [Português](README.md)

> Carsai OS · Lightweight Debian-based Linux distribution

This documentation describes the architecture, the technical decisions and the
roadmap of Carsai OS. It is written in Portuguese; the code, the comments and
the commits are in English.

## Index

| Chapter | Content |
| --- | --- |
| [01 — Overview and philosophy](01-visao-geral.en.md) | What Carsai OS is, what it is not, naming, target audience |
| [02 — System requirements and base choice](02-requisitos-sistema.en.md) | Debian + XFCE, RAM goals, amd64 architecture |
| [03 — Theming system (visual identity)](03-temas.en.md) | Carsai Neon, theme gallery, selector, implementation |
| [04 — Windows compatibility (.exe)](04-compatibilidade-windows.en.md) | 32+64-bit Wine on the ISO, winetricks, realistic expectations |
| [05 — Android compatibility (.apk)](05-compatibilidade-android.en.md) | Waydroid, official installation script, scenario A vs. scenario B |
| [06 — Architecture decisions](06-arquitetura-decisoes.en.md) | What we deliberately will **not** do, and why |
| [07 — Implementation roadmap](07-roadmap.en.md) | Phases 1–5, exit criteria, current status |
| [08 — Shell: shortcuts, statusbar and Windows+Android experience](08-shell-atalhos-e-statusbar.en.md) | Panels, dock, keyboard shortcuts, xfwm4, banner, Carsai commands |
| [09 — Disk installer (Calamares)](09-instalador-disco.en.md) | Disk installation, module configuration, limits and test matrix |

## One-page summary

- **Base:** Debian 12 (bookworm) stable, amd64.
- **Desktop:** XFCE (LXQt as a future lightweight alternative).
- **RAM goal:** ≤ 800 MB at idle; absolute minimum of 2 GB to install and use (4 GB recommended).
- **Identity:** dark tech/cyberpunk/neon themes — the default theme is *Carsai Neon*, with a gallery of 4 ready-made themes and a simple selector.
- **Hacker-style Windows + Android shell:** rich statusbar with system metrics, bottom dock, Windows-style shortcuts (Win+E, snap, ...) and an ASCII banner on first boot (ch. 08).
- **Compatibility:** pre-installed 32+64-bit Wine (.exe) and the official Waydroid script (.apk) — always respecting the lightness goal.
- **Anti-overengineering:** Debian apt, generic kernel, a container instead of a VM, a compatibility layer instead of API rewriting.

## How this repository maps to the product

```
docs/      →  a "lei" do projecto: decisões e roteiro
build/     →  a receita da ISO (live-build sobre Debian bookworm)
themes/    →  a camada visual (GTK, terminal, seletor)
branding/  →  identidade (logo, wallpapers)
scripts/   →  automação (construir ISO, instalar temas em desenvolvimento)
```
