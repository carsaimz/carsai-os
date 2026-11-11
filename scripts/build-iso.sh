#!/usr/bin/env bash
# Carsai OS - ISO build orchestrator.
#
# 1. Syncs themes + branding into the live-build includes tree
#    (single source of truth stays in themes/ and branding/).
# 2. Runs lb build (requires root or sudo).
#
# Output: build/live/*.iso + build/carsai-os-build.log
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BUILD_DIR="$ROOT/build/live"
THEMES_SRC="$ROOT/themes"
BRANDING_SRC="$ROOT/branding"
INC="$BUILD_DIR/config/includes.chroot"

# repo-src-name -> installed-name (installed names must match ThemeName)
declare -A THEMES=(
        [carsai-neon]=Carsai-Neon
        [carsai-dark-minimal]=Carsai-Dark-Minimal
        [carsai-retrowave]=Carsai-Retrowave
        [carsai-light-tech]=Carsai-Light-Tech
)

log() { printf '\n[carsai-os] %s\n' "$*"; }

if [ "$(id -u)" -eq 0 ]; then SUDO=""; else SUDO="sudo"; fi

as_root() {
        if [ -n "$SUDO" ]; then
                "$SUDO" "$@"
        else
                "$@"
        fi
}

log "Syncing GTK themes into includes tree..."
mkdir -p "$INC/usr/share/themes"
for src in "${!THEMES[@]}"; do
        dest="${THEMES[$src]}"
        rm -rf "$INC/usr/share/themes/$dest"
        cp -r "$THEMES_SRC/$src" "$INC/usr/share/themes/$dest"
done

log "Syncing wallpapers..."
mkdir -p "$INC/usr/share/backgrounds/carsai"
cp "$BRANDING_SRC"/wallpapers/*.png "$INC/usr/share/backgrounds/carsai/"

log "Installing theme selector to /usr/local/bin..."
mkdir -p "$INC/usr/local/bin"
install -m 0755 "$THEMES_SRC/selector/carsai-theme-selector" \
        "$INC/usr/local/bin/carsai-theme-selector"

log "Installing terminal colour schemes..."
mkdir -p "$INC/usr/share/carsai/terminal"
cp "$THEMES_SRC"/terminal/xfce4/*.theme "$INC/usr/share/carsai/terminal/"
cp "$THEMES_SRC"/terminal/tilix/*.json "$INC/usr/share/carsai/terminal/"

log "Applying live-build configuration..."
chmod +x "$BUILD_DIR/auto/config" "$BUILD_DIR/auto/build" "$BUILD_DIR/auto/clean"
(cd "$BUILD_DIR" && as_root ./auto/config)

log "Running live-build (30-60 min on the first run)..."
cd "$BUILD_DIR"
as_root lb build 2>&1 | tee "$ROOT/build/carsai-os-build.log"

log "Done. ISO:"
ls -lh "$BUILD_DIR"/*.iso
