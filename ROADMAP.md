# ROADMAP — Carsai OS

> Quadro de fases e do trem de versões. Os critérios de saída detalhados de
> cada fase vivem em [`docs/07-roadmap.md`](docs/07-roadmap.md); este ficheiro
> é o **estado actual**, actualizado a cada entrega.

Última actualização: 2026-11-12

## O que já está feito

### Fase 1 — Base ✅
- [x] ISO bootável compilada pelo CI em cada push (`Build ISO`, verde)
- [x] live-build sobre Debian 12 bookworm, amd64, XFCE, `--apt-recommends false`
- [x] Serviços aparados (cups/bluetooth/modemmanager/avahi), sysctl + zram

### Fase 2 — Identidade ✅
- [x] 4 temas completos (GTK3 + **xfwm4** gerado + esquemas de terminal)
- [x] `carsai-theme-selector` (GTK, xfwm4, wallpaper e terminal de uma vez)
- [x] Wallpapers por tema, logo, ASCII art; LightDM com marca
- [x] **Statusbar rico**: whiskermenu, pager, genmon (`carsai-statusbar`:
      CPU %, RAM %, rede ↓/↑), systemload, tray, volume, relógio com segundos
- [x] **Dock inferior** com intellihide e tasklist agrupada
- [x] **Atalhos estilo Windows**: Win (menu), Win+E/R/D/L/V, snap Win+setas,
      workspaces Ctrl+Win+setas / Win+1..4, Ctrl+Alt+Del, PrintScreen
- [x] Banner hacker no primeiro boot (ASCII, neofetch, cheat sheet)

### Fase 3 — Windows (.exe) ✅
- [x] Wine 64 bits **e 32 bits** (i386 multiarch activado no build) + winetricks
- [x] `carsai-exe app.exe` (terminal) e abrir .exe por duplo-clique no Thunar
- [x] Limitações documentadas (capítulo 04)

### Fase 4 — Android (.apk) 🔶 (em validação)
- [x] `scripts/install-waydroid.sh` (repo oficial do Waydroid + weston)
- [x] `carsai-android` — launcher estilo telefone em janela aninhada (X11)
- [ ] Validação em VM/hardware real (binder, kernel modules, GAPPS vs vanilla)

### Fase 5 — Instalador e refinamento 🔶 (em execução)
- [x] **Calamares** na ISO com marca `carsai` e launcher "Install Carsai OS"
- [x] `carsai-update` (actualização APT) e `carsai-doctor` (relatório p/ bugs)
- [x] Metas de memória revistas: **≤ 800 MB idle, mínimo 2 GB**
- [ ] Teste do instalador em VM (BIOS + UEFI)
- [ ] Medição oficial de idle (`free -m`) em VM de 2 GB
- [ ] Auditoria final de serviços e release **0.1.0-beta**

## Trem de versões

| Versão | Conteúdo planeado | Estado |
| --- | --- | --- |
| **v0.1.0-alpha** | Primeira ISO pública: shell Windows+hacker, Wine, statusbar, temas | ✅ publicada ([release](https://github.com/carsaimz/carsai-os/releases/tag/v0.1.0-alpha)) |
| **v0.1.1-alpha** | Instalador Calamares, `carsai-update`, `carsai-doctor`, metas de RAM revistas | 🚧 na `main` |
| **v0.1.2-alpha** | Validação Waydroid em VM, tema de ícones Carsai (override enxuto), galeria de screenshots | 📋 planeada |
| **v0.2.0-alpha** | Instalador testado (BIOS+UEFI), medição idle em VM 2 GB, ajustes de serviços | 📋 planeada |
| **v0.1.0-beta** | Fase 5 fechada: hardware real ≥ 2 máquinas, docs de utilizador, release pública com checksums | 📋 planeada |
| **1.0** | Primeira estável para o público geral (base Debian da época) | 🔭 visão |

## Próximos passos imediatos

1. Testar a ISO em VM: boot ao vivo, `free -m` em idle (meta ≤ 800 MB),
   instalador Calamares em disco virtual (BIOS e UEFI).
2. Validar Waydroid (`install-waydroid.sh` + `carsai-android`) numa VM com
   Wayland/X11 e registar resultados no capítulo 05.
3. Substituir o logo provisório pela arte oficial (basta sobrescrever
   `branding/logo/carsai-os-icon.svg`).
4. Publicar **v0.1.1-alpha**: `git tag v0.1.1-alpha && git push origin v0.1.1-alpha`
   (o workflow *Release ISO* anexa a ISO + sha256 ao release automaticamente).
5. Site oficial: <https://carsaios.vercel.app> (deploy na Vercel).

## Como decidimos o que entra

Critério anti-overengineering (capítulo 06): apt do Debian antes de empacotar
do zero; scripts em vez de daemons; container antes de VM; e nenhuma feature
que empurre o idle acima da meta sem decisão documentada. Uma fase só fecha
com números medidos, não sensações.
