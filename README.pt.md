<div align="center">

<img src="branding/logo/carsai-os-icon.svg" width="120" alt="Ícone Carsai OS"/>

# Carsai OS

**Uma distribuição Linux leve, baseada em Debian, com identidade tech/neon.**

[![Build ISO](https://github.com/carsaimz/carsai-os/actions/workflows/build-iso.yml/badge.svg)](https://github.com/carsaimz/carsai-os/actions/workflows/build-iso.yml)
![Licença: MIT](https://img.shields.io/badge/Licen%C3%A7a-MIT-00e5ff.svg)
![Base: Debian](https://img.shields.io/badge/base-Debian%2012%20Bookworm-A81D33.svg)
![Desktop: XFCE](https://img.shields.io/badge/desktop-XFCE-2284f2.svg)
[![English](https://img.shields.io/badge/language-English-00e5ff.svg)](README.md)

</div>

---

O **Carsai OS** é uma distribuição Linux personalizada, derivada do **Debian Stable**, projectada para rodar confortavelmente em máquinas com **menos de 4 GB de RAM**, com uma identidade visual moderna e imersiva (**tech / cyberpunk / néon**).

Não é objectivo competir com distros generalistas em quantidade de recursos: a meta é uma experiência **coesa, estilosa e eficiente** em hardware modesto, com um caminho planeado para compatibilidade com aplicações **Windows (.exe)** e **Android (.apk)**.

> "Carsai" é o guarda-chuva do projecto (**Carsai Mozambique**) e não tem relação com IA. Os artefactos podem chamar-se *Carsai OS* (produto) ou *Carsai LinuOs* (variação); o prefixo é a identidade.

## Metas

| Métrica | Alvo |
| --- | --- |
| Consumo de RAM em idle (sessão XFCE) | ≤ 600 MB |
| RAM mínima para instalação / uso básico | 1 GB |
| RAM confortável | 2–4 GB |
| Arquitectura (inicial) | 64 bits (amd64) |
| Base | Debian 12 "Bookworm" |
| Ambiente gráfico | XFCE (principal), LXQt (alternativa futura) |

A justificação e os dados por detrás destes alvos estão na [documentação](docs/README.md).

## Galeria de temas (pré-instalados)

O tema padrão é o **Carsai Neon**. Outros três temas completos vêm com o sistema e podem ser trocados com o seletor de temas integrado.

| Tema | Estética |
| --- | --- |
| **Carsai Neon** (padrão) | Escuro, acentos ciano/magenta, brilho subtil, títulos monoespaçados |
| **Carsai Dark Minimal** | Escuro sóbrio, para produtividade |
| **Carsai Retrowave** | Gradientes synthwave / outrun |
| **Carsai Light Tech** | Claro com acentos tech, para ambientes iluminados |

| Neon | Dark Minimal |
| --- | --- |
| ![Wallpaper Carsai Neon](branding/wallpapers/carsai-neon.png) | ![Wallpaper Carsai Dark Minimal](branding/wallpapers/carsai-dark-minimal.png) |
| **Retrowave** | **Light Tech** |
| ![Wallpaper Carsai Retrowave](branding/wallpapers/carsai-retrowave.png) | ![Wallpaper Carsai Light Tech](branding/wallpapers/carsai-light-tech.png) |

## Estrutura do repositório

```
carsai-os/
├── build/live/          # configuração live-build (receita da ISO)
├── branding/            # logo + wallpapers
├── docs/                # documentação técnica (português)
├── scripts/             # build-iso.sh, install-themes.sh
└── themes/              # temas GTK, esquemas de terminal, seletor de temas
```

## Construir a ISO

Requisitos: um Linux hospedeiro com Docker ou root, ~15 GB livres de disco e internet.

```bash
git clone https://github.com/carsaimz/carsai-os.git
cd carsai-os
sudo apt-get install -y live-build debootstrap squashfs-tools xorriso
./scripts/build-iso.sh
# A ISO fica em build/live/*.iso
```

O workflow do GitHub Actions (**Build ISO**) produz o mesmo artefacto a cada push em `main` que toque em `build/`, `themes/` ou `branding/` — descarrega-o no separador *Actions* (*Artifacts*, guardados 7 dias).

## Testar numa máquina virtual

```bash
qemu-system-x86_64 -m 2048 -enable-kvm -cdrom build/live/carsai-os-*.iso
```

## Roteiro

- [x] Scaffold do projecto: documentação, config live-build, temas, branding, CI
- [ ] **Fase 1 — Base**: ISO bootável, ≤ 600 MB em idle (XFCE + Carsai Neon)
- [ ] **Fase 2 — Identidade**: temas empacotados, ícones, wallpapers, seletor; testes em VM com 2 GB / 4 GB
- [ ] **Fase 3 — Wine**: Wine + Bottles/Lutris pré-instalados, limitações documentadas
- [ ] **Fase 4 — Waydroid**: avaliar maturidade do Wayland no XFCE/Debian; "Carsai Android" opcional
- [ ] **Fase 5 — Refinamento**: testes em hardware real com 2 GB / 4 GB, ajuste de serviços, docs do utilizador

Detalhes em [docs/07-roadmap.md](docs/07-roadmap.md).

## Documentação

A documentação técnica está escrita em português:

1. [Visão geral e filosofia](docs/01-visao-geral.md)
2. [Requisitos de sistema e escolha da base](docs/02-requisitos-sistema.md)
3. [Sistema de temas (identidade visual)](docs/03-temas.md)
4. [Compatibilidade com Windows (.exe)](docs/04-compatibilidade-windows.md)
5. [Compatibilidade com Android (.apk)](docs/05-compatibilidade-android.md)
6. [Decisões de arquitectura (o que não fazer)](docs/06-arquitetura-decisoes.md)
7. [Roteiro de implementação](docs/07-roadmap.md)

## Contribuir

Pull requests são bem-vindos! Lê primeiro o [CONTRIBUTING.md](CONTRIBUTING.md) (convenções de commit, como testar, áreas do repositório).

## Licença

[MIT](LICENSE) © Carsai Mozambique (CarsaiMz)

O trabalho a montante (Debian, XFCE, live-build, ...) mantém as suas próprias licenças.
