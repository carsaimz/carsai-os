#!/usr/bin/env bash
# install-waydroid.sh - add Android (.apk) support to an installed Carsai OS.
#
# Installs Waydroid (container-based Android, near-native performance) plus
# weston for the nested phone-style window on X11, and drops the
# carsai-android launcher into /usr/local/bin.
#
# NOT for the live ISO session: changes are lost on reboot in live mode.
# Run on an installed system with internet access.
set -euo pipefail

if [ "$(id -u)" -eq 0 ]; then SUDO=""; else SUDO="sudo"; fi

as_root() {
        if [ -n "$SUDO" ]; then "$SUDO" "$@"; else "$@"; fi
}

log() { printf '\n[carsai-waydroid] %s\n' "$*"; }

if ! grep -qiE 'debian|carsai' /etc/os-release; then
        log "aviso: este script foi feito para Debian/Carsai OS; continuar mesmo assim?"
        read -r -p "continuar? [s/N] " ans
        case "${ans,,}" in
                s*|y*) ;;
                *) exit 1 ;;
        esac
fi

log "instalando dependencias base..."
as_root apt-get update
as_root apt-get install -y --no-install-recommends \
        curl ca-certificates gnupg weston

log "adicionando o repositorio oficial do Waydroid..."
if [ ! -f /usr/share/keyrings/waydroid.gpg ]; then
        TMP_KEY="$(mktemp)"
        curl -fsSL https://repo.waydro.id/waydroid.gpg -o "$TMP_KEY"
        as_root gpg --dearmor -o /usr/share/keyrings/waydroid.gpg "$TMP_KEY"
        rm -f "$TMP_KEY"
fi
as_root tee /etc/apt/sources.list.d/waydroid.list >/dev/null <<'REPO'
deb [signed-by=/usr/share/keyrings/waydroid.gpg] https://repo.waydro.id/ bookworm main
REPO

log "instalando Waydroid..."
as_root apt-get update
as_root apt-get install -y --no-install-recommends waydroid

log "activando o servico do container..."
as_root systemctl enable --now waydroid-container 2>/dev/null || true

log "inicializando imagem Android (vanilla, sem Google Apps)..."
as_root waydroid init

log "instalando o launcher carsai-android..."
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -f "$SCRIPT_DIR/carsai-android" ]; then
        as_root install -m 0755 "$SCRIPT_DIR/carsai-android" /usr/local/bin/carsai-android
fi

log "concluido!"
log "uso:  carsai-android                (abre o Android em janela estilo telefone)"
log "apps:  waydroid app list | waydroid app launch <pacote>"
log "para Google Play: sudo waydroid init -s GAPPS   (depois reinicie o container)"
