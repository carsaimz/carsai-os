# Carsai OS — theme layer
> **English** | [Português](README.md)

The visual identity of Carsai OS lives here. Four complete GTK3 themes, a
dedicated icon theme, terminal color schemes and a selector with no
external dependencies.

## Structure

```
themes/
├── carsai-neon/            # tema padrão (cyberpunk/néon escuro)
├── carsai-dark-minimal/    # escuro sóbrio (produtividade)
├── carsai-retrowave/       # synthwave/outrun
├── carsai-light-tech/      # claro com acentos tech
│   ├── gtk-3.0/gtk.css     # folha de estilos GTK3
│   ├── xfwm4/              # decorações de janela (XPMs gerados)
│   └── index.theme         # metadados
├── terminal/
│   ├── xfce4/*.theme       # esquemas de cores do xfce4-terminal
│   └── tilix/*.json        # esquemas de cores do Tilix
├── icons/
│   └── carsai/             # tema de ícones (override enxuto sobre Adwaita)
├── selector/
│   └── carsai-theme-selector   # CLI: aplica GTK + xfwm4 + ícones + wallpaper + terminal
└── src/
    ├── generate-xfwm4-themes.py # gerador das decorações xfwm4
    └── generate-carsai-icons.py # gerador do tema de ícones
```

## Installed names

In the ISO (via `scripts/build-iso.sh`), the themes are installed with
hyphenated names — the names xfconf expects in `/Net/ThemeName`:

| Directory in the repo | Installed name |
| --- | --- |
| `themes/carsai-neon` | `/usr/share/themes/Carsai-Neon` |
| `themes/carsai-dark-minimal` | `/usr/share/themes/Carsai-Dark-Minimal` |
| `themes/carsai-retrowave` | `/usr/share/themes/Carsai-Retrowave` |
| `themes/carsai-light-tech` | `/usr/share/themes/Carsai-Light-Tech` |
| `themes/icons/carsai` | `/usr/share/icons/carsai` (icon theme) |

## Selector

```bash
carsai-theme-selector            # menu interativo
carsai-theme-selector --set neon # aplicação directa (neon|dark|retrowave|light)
carsai-theme-selector --list     # listar
```

The selector applies **all sides** of the theme: GTK (`/Net/ThemeName`), the
xfwm4 window decorations (`/general/theme`), the `Carsai` icon theme
(`/Net/IconThemeName`, when installed) — the installed theme contains the
`gtk-3.0/` and `xfwm4/` subdirectories.

In the ISO, `/usr/local/bin/carsai-theme-selector` runs with `--first-run` at
the first login (skel autostart) and applies **Carsai Neon** only once.

## Testing without building the ISO

```bash
./scripts/install-themes.sh user    # instala em ~/.themes etc. (sem root)
~/.local/bin/carsai-theme-selector
```

## How to add a new theme

1. Copy an existing folder (`cp -r themes/carsai-dark-minimal themes/carsai-meu-tema`).
2. Edit the `@define-color` entries in `gtk-3.0/gtk.css` (the palette at the
   top controls everything).
3. Add the mapping in `themes/selector/carsai-theme-selector` (the `THEMES`
   array), in `scripts/build-iso.sh` (the `THEMES` map) and in
   `scripts/install-themes.sh`.
4. Add the theme palette in `themes/src/generate-xfwm4-themes.py` and run
   the generator to create the window decorations.
5. Create the matching wallpaper at `branding/wallpapers/carsai-meu-tema.png`
   and the terminal scheme (it can be derived from an existing one).

## Known limitations (Phase 2 on the roadmap)

- **GTK4/libadwaita**: not included in this phase (XFCE is GTK3).
- **Icons**: Adwaita by default; the Carsai icon theme is planned for
  Phase 2.
