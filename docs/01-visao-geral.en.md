# 01 — Overview and philosophy
> **English** | [Português](01-visao-geral.md)

## 1.1 What is Carsai OS

Carsai OS is a custom Linux distribution, derived from **Debian
Stable**, designed to be light enough to run comfortably on machines with
**2–4 GB of RAM**, but with a modern and immersive visual identity — a
**tech / cyberpunk / neon** theme.

The goal is not to compete with general-purpose distros on resource count,
but to offer a **cohesive, stylish and efficient** experience on modest
hardware, with a planned path toward compatibility with **Windows (.exe)** and
**Android (.apk)** applications.

In short:

- **Lightness with personality**: every MB of RAM saved is an MB available to
  the user — but the system must never feel "cheap".
- **Visual coherence**: themes, icons, wallpapers, terminal and login screen
  share the same palette and the same language.
- **Path to compatibility**: Wine (.exe) and Waydroid (.apk) are on the
  roadmap, planned from the start so as not to violate the lightness goal.

## 1.2 Naming

| Name | Usage |
| --- | --- |
| **Carsai OS** | Name of the main product (the distribution) |
| Prefix `Carsai-*` | Individual components (themes, scripts, packages) |

The prefix is the identity; the suffix may vary depending on the context. This
gives freedom to create related sub-projects in the future
(e.g. *Carsai Studio*, *Carsai Mobile Tools*) without fragmenting the brand.

## 1.3 Target audience

1. **Users with modest hardware**: laptops and desktops with 2–4 GB of
   RAM that modern software has left behind.
2. **Users migrating from Windows** who need to run some .exe applications
   (Phase 3) without learning VM management.
3. **Enthusiasts of the tech/neon aesthetic** who want a desktop with a strong
   identity without assembling themes by hand.

## 1.4 What Carsai OS is **not**

- **It is not** a security/pen-testing distro or a specialized multimedia
  distro — it is a lightweight general-purpose desktop with its own identity.
- **It is not** a reimplementation of package managers or a customized kernel
  (see chapter 06 — anti-overengineering).
- **It is not** an emulator: the compatibility layers (.exe/.apk) use
  proven technologies (Wine, Waydroid), not heavy emulation.
- **It is not**, at this stage, a distro for servers.

## 1.5 Design principles

1. **Every service must justify its place.** If it is not essential for a
   desktop, it is disabled by default.
2. **Lightness is not traded away for aesthetics.** A well-built theme
   (CSS/GTK) costs ~0 RAM; it is free compared with heavy compositor effects.
3. **Standards before inventions.** Debian + XFCE + live-build + xfconf are
   mature tools; writing custom infrastructure is risk, not value.
4. **Everything documented.** Every decision with a justification (chapter 06)
   and every phase with an exit criterion (chapter 07).
