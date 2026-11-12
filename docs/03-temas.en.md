# 03 — Theming system (visual identity)
> **English** | [Português](03-temas.md)

The big differentiator of Carsai OS is the visual layer. The strategy separates
the **default theme** (tech/cyberpunk/neon) from a **gallery of ready-made
themes** that the user can pick with a simple selector.

## 3.1 Default theme "Carsai Neon"

**Aesthetics**: dark backgrounds, cyan/magenta accents, elements with a subtle
glow, monospaced typography in titles.

**Packaged components** (sources of inspiration: projects such as *CyberHack*
and *Cyberpunk Neon*):

| Component | Implementation in this repository |
| --- | --- |
| GTK theme (XFCE apps) | `themes/carsai-neon/gtk-3.0/gtk.css` — complete GTK3 CSS (windows, headerbars, buttons, entries, sidebars, menus, scrollbars, tooltips, XFCE panel) |
| Wallpaper | `branding/wallpapers/carsai-neon.png` (AI-generated, 1344×768) |
| Terminal scheme | `themes/terminal/xfce4/carsai-neon.theme` (xfce4-terminal) + `themes/terminal/tilix/carsai-neon.json` (Tilix) |
| Login screen (LightDM) | `build/live/config/includes.chroot/etc/lightdm/lightdm-gtk-greeter.conf` — theme + background with the Carsai identity |
| Icons | At this stage Adwaita is used (built into GTK); a cohesive Carsai icon theme is planned for Phase 2 |

### Reference palette (Carsai Neon)

| Role | Color |
| --- | --- |
| Main background | `#0A0A12` |
| Secondary background / surfaces | `#13131F` |
| Primary accent (neon cyan) | `#00E5FF` |
| Secondary accent (neon magenta) | `#FF2EC4` |
| Main text | `#E0E7FF` |
| Secondary text | `#8A93B2` |
| Success | `#00E676` |
| Warning | `#FFD600` |
| Error | `#FF1744` |

## 3.2 Theme gallery (pre-installed selection)

The system ships with **4 complete themes** (including the default), managed by
the selector (`carsai-theme-selector`, installed at `/usr/local/bin` on the ISO
and at `~/.local/bin` in development mode):

| Theme | Aesthetic direction | Folder |
| --- | --- | --- |
| **Carsai Neon** (default) | Dark cyberpunk/neon | `themes/carsai-neon/` |
| **Carsai Dark Minimal** | Sober dark, for productivity | `themes/carsai-dark-minimal/` |
| **Carsai Retrowave** | Synthwave/outrun gradients | `themes/carsai-retrowave/` |
| **Carsai Light Tech** | Light with tech accents, for well-lit environments | `themes/carsai-light-tech/` |

Each theme folder contains `gtk-3.0/gtk.css` (the stylesheet) and an
`index.theme` with metadata. The folder names installed under
`/usr/share/themes/` are `Carsai-Neon`, `Carsai-Dark-Minimal`,
`Carsai-Retrowave` and `Carsai-Light-Tech` (with hyphen — that is the name
xfconf expects in `/Net/ThemeName`).

## 3.3 Technical implementation

The implementation is deliberately **trivial and with no new dependencies**:

1. The themes live in `/usr/share/themes` (via the live-build `includes.chroot`,
   synced by `scripts/build-iso.sh` from `themes/`).
2. The wallpapers live in `/usr/share/backgrounds/carsai/`.
3. The selector only **applies settings** — it installs nothing:

```bash
# Tema GTK (xsettings):
xfconf-query -c xsettings -p /Net/ThemeName -s "Carsai-Neon"

# Wallpaper (xfdesktop) — todas as propriedades last-image encontradas:
xfconf-query -c xfce4-desktop -p "$prop" -s "/usr/share/backgrounds/carsai/carsai-neon.png"

# Cores do terminal: escrever ColorPalette*/ColorForeground/ColorBackground
# em ~/.config/xfce4/terminal/terminalrc
```

## 3.4 Theme selector (`carsai-theme-selector`)

A single bash script, with no dependencies beyond XFCE + xfconf-query:

| Mode | Command | Effect |
| --- | --- | --- |
| Interactive menu | `carsai-theme-selector` | Lists the 4 themes and applies the chosen one |
| Direct | `carsai-theme-selector --set retrowave` | Applies without a menu |
| First boot | `carsai-theme-selector --first-run` | Applies Carsai Neon exactly once (marks it in `~/.config/carsai/first-run-done`) — used by the ISO autostart |
| List | `carsai-theme-selector --list` | Shows the available themes |

What the selector applies: the GTK theme (xsettings), the matching xfwm4
decorations, the `Carsai` icon theme (when installed), the wallpaper on every
monitor / workspace detected via `xfconf-query -c xfce4-desktop -l`, and the
xfce4-terminal colors.

## 3.5 Icon theme (`Carsai`)

The system ships its own icon theme, **lean**: instead of drawing a complete
collection, the `Carsai` theme inherits from **Adwaita** (`Inherits=Adwaita`)
and overlays only the icons that define the identity:

| Icon | Context | Design |
| --- | --- | --- |
| `folder` | places | dark folder with a cyan outline |
| `user-home` | places | house with a magenta door |
| `user-desktop` | places | monitor with a terminal prompt |
| `application-x-executable` | mimetypes | window with a green "run" triangle |
| `application-x-msdos-program` | mimetypes | window with a Windows-style grid (the `.exe`) |

- Generator source: `themes/src/generate-carsai-icons.py` — the same approach
  as the xfwm4 themes: edit the script and regenerate, never edit the SVGs by
  hand.
- Installation: `/usr/share/icons/carsai` (ISO and `install-themes.sh system`)
  or `~/.local/share/icons/carsai` (`install-themes.sh user`).
- Enabled by default in the skel (`xsettings.xml` → `/Net/IconThemeName`) and
  applied by the theme selector on every switch.
- All remaining icons keep coming from Adwaita, with no duplication —
  the whole theme takes up less than 4 KB.

## 3.6 Future extensions

- **GTK4/libadwaita theme** when XFCE migrates components to GTK4.
- **More themes** in the gallery (contributions accepted — see CONTRIBUTING.md).
