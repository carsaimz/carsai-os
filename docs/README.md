# Documentação técnica — Carsai OS

> Projeto Carsai Mozambique · Distribuição Linux leve baseada em Debian

Esta documentação descreve a arquitectura, as decisões técnicas e o roteiro do
Carsai OS. Está escrita em português porque o projecto nasce em Moçambique; o
código, os comentários e os commits seguem em inglês.

## Índice

| Capítulo | Conteúdo |
| --- | --- |
| [01 — Visão geral e filosofia](01-visao-geral.md) | O que é o Carsai OS, o que não é, nomenclatura, público-alvo |
| [02 — Requisitos de sistema e escolha da base](02-requisitos-sistema.md) | Debian + XFCE, metas de RAM, arquitetura amd64 |
| [03 — Sistema de temas (identidade visual)](03-temas.md) | Carsai Neon, galeria de temas, seletor, implementação |
| [04 — Compatibilidade com Windows (.exe)](04-compatibilidade-windows.md) | Wine/Proton, Bottles/Lutris, expectativas realistas (fase futura) |
| [05 — Compatibilidade com Android (.apk)](05-compatibilidade-android.md) | Waydroid, Wayland, cenário A vs. cenário B (fase futura) |
| [06 — Decisões de arquitectura](06-arquitetura-decisoes.md) | O que deliberadamente **não** vamos fazer, e porquê |
| [07 — Roteiro de implementação](07-roadmap.md) | Fases 1–5, critérios de saída, estado actual |

## Resumo em uma página

- **Base:** Debian 12 (bookworm) stable, amd64.
- **Desktop:** XFCE (LXQt como alternativa leve futura).
- **Meta de RAM:** ≤ 600 MB em idle; mínimo absoluto 1 GB para instalar e usar.
- **Identidade:** temas escuros tech/cyberpunk/néon — o tema padrão é o *Carsai Neon*, com uma galeria de 4 temas prontos e um seletor simples.
- **Fases futuras:** Wine (.exe) e Waydroid (.apk), sempre respeitando a meta de leveza.
- **Anti-overengineering:** apt do Debian, kernel genérico, container em vez de VM, camada de compatibilidade em vez de reescrita de APIs.

## Como este repositório mapeia para o produto

```
docs/      →  a "lei" do projecto: decisões e roteiro
build/     →  a receita da ISO (live-build sobre Debian bookworm)
themes/    →  a camada visual (GTK, terminal, seletor)
branding/  →  identidade (logo, wallpapers)
scripts/   →  automação (construir ISO, instalar temas em desenvolvimento)
```
