#!/usr/bin/env bash
# Carsai OS - install themes on a running system (for development/testing
# without building the whole ISO).
#
# Usage:
#   ./scripts/install-themes.sh user    install to ~/.themes, ~/.local/... (no root)
#   ./scripts/install-themes.sh system  install to /usr/share/... (needs root/sudo)
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MODE="${1:-user}"

declare -A THEMES=(
	[carsai-neon]=Carsai-Neon
	[carsai-dark-minimal]=Carsai-Dark-Minimal
	[carsai-retrowave]=Carsai-Retrowave
	[carsai-light-tech]=Carsai-Light-Tech
)

log() { printf '[carsai] %s\n' "$*"; }

case "$MODE" in
	system)
		if [ "$(id -u)" -eq 0 ]; then SUDO=""; else SUDO="sudo"; fi
		THEME_DIR="/usr/share/themes"
		WALL_DIR="/usr/share/backgrounds/carsai"
		SCHEME_DIR="/usr/share/carsai/terminal"
		BIN_DIR="/usr/local/bin"
		as_root() {
			if [ -n "$SUDO" ]; then "$SUDO" "$@"; else "$@"; fi
		}
		;;
	user)
		THEME_DIR="$HOME/.themes"
		WALL_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/backgrounds/carsai"
		SCHEME_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/carsai/terminal"
		BIN_DIR="${XDG_DATA_HOME:-$HOME/.local/bin}"
		as_root() { "$@"; }
		;;
	*)
		echo "usage: $0 [user|system]" >&2
		exit 1
		;;
esac

as_root mkdir -p -- "${THEME_DIR:?}" "${WALL_DIR:?}" "${SCHEME_DIR:?}" "${BIN_DIR:?}"

for src in "${!THEMES[@]}"; do
	dest="${THEMES[$src]}"
	log "theme: $src -> $THEME_DIR/$dest"
	as_root rm -rf -- "${THEME_DIR:?}/$dest"
	as_root cp -r "$ROOT/themes/$src" "$THEME_DIR/$dest"
done

log "wallpapers -> $WALL_DIR"
as_root cp "$ROOT"/branding/wallpapers/*.png "${WALL_DIR:?}/"

log "terminal schemes -> $SCHEME_DIR"
as_root cp "$ROOT"/themes/terminal/xfce4/*.theme "${SCHEME_DIR:?}/"

log "selector -> $BIN_DIR/carsai-theme-selector"
as_root install -m 0755 "$ROOT/themes/selector/carsai-theme-selector" "${BIN_DIR:?}/"

log "done. run: $BIN_DIR/carsai-theme-selector"
log "(note: xfconf-query only works inside an XFCE session)"
