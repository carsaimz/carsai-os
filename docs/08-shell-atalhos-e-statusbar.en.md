# 08 — Shell: shortcuts, rich statusbar, and the Windows + Android experience
> **English** | [Português](08-shell-atalhos-e-statusbar.md)

> Status: **implemented in the ISO (alpha)**. This chapter describes the
> Carsai shell: how XFCE was configured to feel familiar to people coming
> from Windows, fluid for people coming from Android — while keeping the
> hacker aesthetic (terminal at the center, monospace, neon).

## 8.1 Shell philosophy

Three deliberate influences, one per layer:

| Layer | Influence | Implementation |
| --- | --- | --- |
| Navigation | **Windows** | Start menu, Win+E/R/D/L/V, snap with Win+arrows, taskbar with grouped icons |
| Movement | **Android** | Auto-hiding bottom dock, workspaces as "home screens", touch apps via Waydroid (ch. 05) |
| Identity | **Hacker** | Terminal as a first-class citizen, monospace fonts (JetBrains Mono), statusbar with system metrics, ASCII banner on first boot |

Everything is configurable via xfconf — nothing was forked or patched; it
is stock XFCE with a cohesive configuration (anti-overengineering, see
ch. 06).

## 8.2 Panels: statusbar (top) + dock (bottom)

**Panel 1 — rich statusbar (top, 30 px):**

| Slot | Widget | Function |
| --- | --- | --- |
| 1 | Whisker Menu | Start menu with the Carsai icon |
| 2 | Pager | Workspaces (4 by default) — "home screens" style |
| 3 | Stretch separator | Pushes the rest to the right |
| 4 | **Genmon** | `carsai-statusbar` feed: CPU %, RAM %, network ↓/↑ in real time |
| 5 | System Load | CPU/RAM/swap bars with a detailed tooltip |
| 6 | System tray | NetworkManager, clipboard, etc. |
| 7 | PulseAudio | Volume control |
| 8 | Digital clock | `%H:%M:%S` (visible seconds — hacker rhythm) |

**Panel 2 — dock (bottom, 46 px, auto-hiding):**

- Pinned launchers: Terminal, Files (Thunar), Firefox ESR, Mousepad;
- Grouped tasklist (open windows, icons without labels);
- "Show desktop" button in the corner.

Intellihide dock: it hides when a window overlaps it and reappears when the
mouse approaches the edge — behavior familiar from Android/Windows 11.

### 8.2.1 The `carsai-statusbar` feed

Script at `/usr/local/bin/carsai-statusbar`, called by the **Generic
Monitor** plugin every 3 seconds. No dependencies beyond `awk`:

- **CPU**: deltas from `/proc/stat`;
- **RAM**: `MemTotal - MemAvailable` from `/proc/meminfo`;
- **Network**: counters from `/sys/class/net/<iface>/statistics/` (interface
  of the default route), converted into a per-second rate;
- **Tooltip**: kernel, IP, uptime;
- **Click**: opens `btop`.

State between runs: one line in `/tmp/carsai-statusbar.state`.

## 8.3 Keyboard shortcuts (Windows style)

Deltas on top of the XFCE defaults (which remain active: Alt+F4, Alt+Tab,
F12, ...). Defined in
`includes.chroot/etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml`.

| Shortcut | Action |
| --- | --- |
| `Win` | Start menu (Whisker) |
| `Win+E` | File manager (Thunar) |
| `Win+R` | Run application (collapsed appfinder) |
| `Win+D` | Show desktop (toggle) |
| `Win+L` | Lock screen (xflock4) |
| `Win+V` | Clipboard history (Clipman) |
| `Win+arrows` | Snap: left/right, maximize/minimize |
| `Ctrl+Win+←/→` | Previous/next workspace (Windows style) |
| `Ctrl+Alt+←/→` | Previous/next workspace (classic) |
| `Win+1..4` | Jump directly to workspace N |
| `Ctrl+Alt+T` or `Win+Enter` | Terminal |
| `Ctrl+Alt+Del` | Task manager |
| `Print` / `Alt+Print` / `Shift+Print` | Screenshot: screen / window / region |

## 8.4 Windows: xfwm4 with Carsai decorations

Each GTK theme has a **matching xfwm4 theme** (title bar and generated XPM
buttons, accents identical to the GTK ones — see
`themes/src/generate-xfwm4-themes.py`). The selector applies both together.

Window manager defaults (`xfwm4.xml`):

- compositor enabled with 90% opacity on inactive windows and 85% on
  title bars — depth at no perceptible cost;
- 4 workspaces;
- title bar font: JetBrains Mono Bold 10.

## 8.5 First boot: hacker banner

On the first login (only on the first — marker `~/.config/carsai/welcome-done`):

1. the autostart opens xfce4-terminal with `carsai-banner`;
2. the banner prints the Carsai ASCII art + `neofetch`;
3. list of shortcuts and commands (`carsai-theme-selector`, `carsai-exe`,
   `btop`, `ranger`);
4. in parallel, the selector applies the default Neon theme (existing
   autostart, silent).

From the second boot on, no terminal opens automatically.

## 8.6 Carsai OS system commands

| Command | Function |
| --- | --- |
| `carsai-theme-selector` | Interactive theme menu (GTK + wallpaper + terminal + windows) |
| `carsai-theme-selector --set KEY` | Applies directly (`neon|dark|retrowave|light`) |
| `carsai-exe programa.exe` | Runs Windows programs via Wine (prefix created on first use) |
| `carsai-update [--clean]` | Updates the system (apt update + full-upgrade; `--clean` removes orphans) |
| `carsai-doctor` | System report (idle RAM, zram, services, themes) for issues |
| `carsai-statusbar` | (internal) feeds the panel's genmon widget |
| `carsai-welcome` | (internal) opens the banner only once |
| `carsai-android` | Opens the Android environment (after `scripts/install-waydroid.sh`) |

## 8.7 Testing the shell without building the ISO

```bash
./scripts/install-themes.sh user         # temas + seletor em ~/.themes
cp -r build/live/config/includes.chroot/etc/skel/.config/xfce4 ~/.config/
xfce4-panel -r                           # recarrega painéis com o layout Carsai
```

(In a test XFCE session; `carsai-statusbar` needs to be in
`$PATH` — for example `~/.local/bin`.)
