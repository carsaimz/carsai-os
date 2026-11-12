# Build directory — Carsai OS ISO (live-build)

> [English](README.en.md) | **Português**

Esta pasta contém a **receita** da ISO do Carsai OS (não os artefactos
gerados — saídas de build nunca são versionadas).

## Estrutura

```
build/live/
├── auto/                      # entry-points do live-build (config/build/clean)
├── config/
│   ├── package-lists/         # lista de pacotes do Carsai OS
│   ├── hooks/live/            # hooks executados no chroot (trimação de serviços)
│   └── includes.chroot/       # ficheiros injetados no sistema de ficheiros da ISO
│       ├── etc/sysctl.d/      # afinação de RAM (swappiness, vfs_cache_pressure)
│       ├── etc/default/       # config do zram (zstd, 25%)
│       ├── etc/lightdm/       # branding do ecrã de login
│       └── etc/skel/          # autostart de primeiro arranque (tema Neon)
```

O `scripts/build-iso.sh` sincroniza `themes/` e `branding/` para dentro de
`config/includes.chroot/usr/share/` antes de invocar o live-build — por isso
os temas existem **uma só vez** no repositório (em `themes/`).

## Como construir

Na raiz do repositório:

```bash
sudo apt-get install -y live-build debootstrap squashfs-tools xorriso
./scripts/build-iso.sh
```

A ISO é gerada em `build/live/*.iso` (nome típico:
`live-image-amd64.hybrid.iso`). O log completo fica em
`build/carsai-os-build.log`.

## Notas

- `--apt-recommends false` mantém a imagem enxuta; se um pacote precisar de
  recomendados, adiciona-o explicitamente na lista.
- `--debian-installer none`: o instalador de disco entra no roteiro (Fase 2);
  a Fase 1 valida a ISO live.
- `--archive-areas` inclui `non-free-firmware` para Wi-Fi/GPU em hardware real.
