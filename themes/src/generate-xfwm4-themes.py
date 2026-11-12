#!/usr/bin/env python3
"""Carsai OS - xfwm4 window-decoration theme generator.

Generates flat, neon-styled xfwm4 themes (XPM format) for each Carsai
GTK theme, so the window borders match the rest of the desktop.

The generator is committed to the repository so the decorations can be
regenerated/tweaked without external tools:

    python3 themes/src/generate-xfwm4-themes.py

Output: themes/<theme>/xfwm4/*.xpm + themerc (consumed by
scripts/build-iso.sh when syncing into the ISO includes tree).
"""

from __future__ import annotations

import os

HERE = os.path.dirname(os.path.abspath(__file__))
THEMES_DIR = os.path.abspath(os.path.join(HERE, ".."))

# Per-theme palette (matches the GTK3 accent colours of each variant).
# bg        : title bar background (active windows)
# bg_i      : title bar background (inactive windows)
# prelight  : button background on mouse hover
# accent    : theme accent (border line + glyphs)
# text_a    : active title text colour
# text_i    : inactive title text colour
# close     : close-button glyph colour
# border_i  : inactive border line colour
PALETTES = {
    "carsai-neon": {
        "bg": "#0A0A12", "bg_i": "#13131F", "prelight": "#14141F",
        "accent": "#00E5FF", "text_a": "#00E5FF", "text_i": "#8A93B2",
        "close": "#FF5370", "border_i": "#262640",
    },
    "carsai-dark-minimal": {
        "bg": "#101418", "bg_i": "#161B21", "prelight": "#1B222A",
        "accent": "#4FC3F7", "text_a": "#C8D0D8", "text_i": "#7B8794",
        "close": "#EF5350", "border_i": "#262E37",
    },
    "carsai-retrowave": {
        "bg": "#170B26", "bg_i": "#20112F", "prelight": "#26163A",
        "accent": "#FF71CE", "text_a": "#FFD9EC", "text_i": "#B085C7",
        "close": "#FF5370", "border_i": "#3D2A55",
    },
    "carsai-light-tech": {
        "bg": "#EAEFF4", "bg_i": "#F0F3F6", "prelight": "#DCE3EA",
        "accent": "#0891B2", "text_a": "#24292F", "text_i": "#57606A",
        "close": "#D73A49", "border_i": "#D0D7DE",
    },
}

# Sizes (pixels). Flat colours make xfwm4's stretching invisible, so the
# exact frame heights only need to stay internally consistent.
TITLE_H = 22          # title bar height
TITLE_W = 8           # width of each title-N tile
FRAME = 2             # side/bottom border thickness
BTN = 11              # button size (odd -> centred glyphs)

BUTTONS = ("close", "hide", "maximize", "maximize-toggled",
           "menu", "shade", "shade-toggled", "stick", "stick-toggled")


class Grid:
    """Tiny pixel canvas producing XPM data."""

    def __init__(self, w, h, bg):
        self.w, self.h = w, h
        self.px = [[" " for _ in range(w)] for _ in range(h)]
        self.colors = {" ": bg}  # char -> hex
        self.counter = 0

    def char_for(self, hexcolor):
        for ch, c in self.colors.items():
            if c == hexcolor:
                return ch
        alphabet = "abcdefghijklmnopqrstuvwxyz0123456789"
        while True:
            self.counter += 1
            ch = alphabet[self.counter % len(alphabet)]
            if ch not in self.colors:
                self.colors[ch] = hexcolor
                return ch

    def set(self, x, y, color):
        if 0 <= x < self.w and 0 <= y < self.h:
            self.px[y][x] = self.char_for(color)

    def rect(self, x0, y0, x1, y1, color, fill=False):
        for y in range(y0, y1 + 1):
            for x in range(x0, x1 + 1):
                if fill or y in (y0, y1) or x in (x0, x1):
                    self.set(x, y, color)

    def hline(self, y, x0, x1, color):
        for x in range(x0, x1 + 1):
            self.set(x, y, color)

    def to_xpm(self, varname):
        chars = list(self.colors.keys())
        lines = ['"%d %d %d 1"' % (self.w, self.h, len(chars))]
        for ch in chars:
            # every pixel is covered by a char: solid colours, no transparency
            lines.append('"%s c %s"' % (ch, self.colors[ch]))
        for row in self.px:
            lines.append('"%s"' % "".join(row))
        body = ",\n".join(lines)
        return "/* XPM */\nstatic char * %s[] = {\n%s};\n" % (varname, body)


def title_grid(pal, active):
    g = Grid(TITLE_W, TITLE_H, pal["bg"] if active else pal["bg_i"])
    line = pal["accent"] if active else pal["border_i"]
    for x in range(TITLE_W):
        g.set(x, TITLE_H - 1, line)
    return g


def frame_grid(w, h, pal, active):
    bg = pal["bg"] if active else pal["bg_i"]
    return Grid(w, h, bg)


def button_grid(name, pal, state):
    if state == "pressed":
        bg, glyph = pal["accent"], pal["bg"]
    elif state == "prelight":
        bg, glyph = pal["prelight"], pal["accent"]
    elif state == "inactive":
        bg, glyph = pal["bg_i"], pal["text_i"]
    else:  # active
        bg, glyph = pal["bg"], pal["accent"]
    if name == "close" and state != "pressed":
        glyph = pal["close"]
    g = Grid(BTN, BTN, bg)
    c = glyph
    if name == "close":
        for i in range(2, 9):
            g.set(i, i, c)
            g.set(10 - i, i, c)
    elif name == "hide":
        g.hline(8, 2, 8, c)
    elif name == "maximize":
        g.rect(2, 2, 8, 8, c)
    elif name == "maximize-toggled":
        g.rect(2, 2, 8, 8, c)
        g.rect(4, 4, 8, 8, c, fill=True)
    elif name == "menu":
        g.hline(3, 2, 8, c)
        g.hline(5, 2, 8, c)
        g.hline(7, 2, 8, c)
    elif name == "shade":
        for i, y in enumerate((6, 5, 4, 3, 4, 5, 6)):
            g.set(2 + i, y, c)
    elif name == "shade-toggled":
        for i, y in enumerate((3, 4, 5, 6, 5, 4, 3)):
            g.set(2 + i, y, c)
    elif name == "stick":
        g.rect(4, 4, 6, 6, c, fill=True)
    elif name == "stick-toggled":
        g.rect(3, 3, 7, 7, c)
        g.rect(4, 4, 6, 6, bg, fill=True)
        g.rect(4, 4, 6, 6, c)
    return g


THEMERC = """\
active_text_color={text_a}
inactive_text_color={text_i}
active_text_shadow_color={bg}
inactive_text_shadow_color={bg_i}
button_offset=2
button_spacing=2
full_width_title=true
frame_border_top=0
maximized_offset=0
show_app_icon=true
shadow_delta_height=4
shadow_delta_width=2
shadow_delta_x=0
shadow_delta_y=6
shadow_opacity=50
title_horizontal_offset=1
title_shadow_active=false
title_shadow_inactive=false
title_vertical_offset_active=1
title_vertical_offset_inactive=1
"""


def generate(theme_key, pal):
    out = os.path.join(THEMES_DIR, theme_key, "xfwm4")
    os.makedirs(out, exist_ok=True)

    def write(fname, grid):
        var = fname.replace("-", "_").replace(".xpm", "") + "_xpm"
        with open(os.path.join(out, fname), "w", encoding="ascii") as fh:
            fh.write(grid.to_xpm(var))

    for active, suffix in ((True, "active"), (False, "inactive")):
        for n in range(1, 6):
            write("title-%d-%s.xpm" % (n, suffix), title_grid(pal, active))
        write("top-left-%s.xpm" % suffix, frame_grid(FRAME, TITLE_H, pal, active))
        write("top-right-%s.xpm" % suffix, frame_grid(FRAME, TITLE_H, pal, active))
        write("left-%s.xpm" % suffix, frame_grid(FRAME, TITLE_H, pal, active))
        write("right-%s.xpm" % suffix, frame_grid(FRAME, TITLE_H, pal, active))
        write("bottom-%s.xpm" % suffix, frame_grid(TITLE_W, FRAME, pal, active))
        write("bottom-left-%s.xpm" % suffix, frame_grid(FRAME, FRAME, pal, active))
        write("bottom-right-%s.xpm" % suffix, frame_grid(FRAME, FRAME, pal, active))
        for btn in BUTTONS:
            for state in ("active", "inactive", "prelight", "pressed"):
                write("%s-%s.xpm" % (btn, state), button_grid(btn, pal, state))

    with open(os.path.join(out, "themerc"), "w", encoding="utf-8") as fh:
        fh.write(THEMERC.format(**pal))
    print("generated: themes/%s/xfwm4/" % theme_key)


def main():
    for key, pal in PALETTES.items():
        generate(key, pal)
    print("done.")


if __name__ == "__main__":
    main()
