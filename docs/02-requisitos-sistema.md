# 02 — Requisitos de sistema e escolha da base

> [English](02-requisitos-sistema.en.md) | **Português**

Para atingir a meta de RAM abaixo de 4 GB com folga, a base técnica precisa de
ser cirúrgica. Este capítulo fixa as escolhas e os números de referência.

## 2.1 Tabela de requisitos

| Camada | Escolha recomendada | Justificação (com dados) |
| --- | --- | --- |
| **Base** | Debian Stable (12 bookworm) | Estabilidade comprovada, ecossistema vasto e suporte de longo prazo. É a base do MX Linux e do antiX, referências em leveza. |
| **Ambiente gráfico** | XFCE (principal) ou LXQt (alternativa) | XFCE é o equilíbrio ideal entre consumo baixo e capacidade de personalização visual. LXQt é ainda mais leve, mas com menor flexibilidade estética. |
| **Consumo alvo (idle)** | ≤ 800 MB de RAM | Desde v0.1.x o Carsai traz painel rico, Wine 32+64 bits e o toolkit hacker pré-instalados — o piso da sessão subiu. Com mínimo de 2 GB e zram, 800 MB em idle deixam ~1.2 GB utilizáveis (folga real; o MX Linux, também XFCE, fica em ~600–700 MB). |
| **Requisito mínimo absoluto** | 2 GB de RAM para instalação e uso básico | A partir de v0.1.x o produto assume **2 GB como piso** (decisão 2026-11-12: até 800 MB em idle é aceitável). Com zram zstd a 25 %, uma máquina de 2 GB comporta a sessão + navegador com folga; 1 GB deixa de ser perfil oficial. |

## 2.2 Requisitos oficiais do produto

| Perfil | RAM | Disco | Uso esperado |
| --- | --- | --- | --- |
| **Mínimo** | 2 GB | 8 GB | Instalar, sessão XFCE básica, 1–2 apps leves |
| **Recomendado** | 4 GB | 16 GB | Uso diário: navegador, office, Wine leve |
| **Confortável** | 8 GB | 32 GB | Navegação pesada + Wine + Waydroid activo |

## 2.3 Decisão de arquitectura

**Foco em 64 bits (amd64)**, alinhado com a maioria do hardware com 2–4 GB de
RAM. O suporte a 32 bits (i386) fica como possibilidade futura apenas se houver
demanda real, porque:

- o ecossistema está migrado para 64 bits (browsers e apps modernos já não
  publicam builds i386);
- o Debian mantém i386 parcialmente (como biblioteca de compatibilidade, não
  como arquitectura de primeira classe);
- manter duas arquitecturas duplica o custo de teste da ISO.

## 2.4 Como a meta de 800 MB é atingida

O consumo em idle é a soma de (a) kernel + initramfs, (b) serviços de sistema,
(c) sessão gráfica. O plano por camada:

1. **Kernel**: usar o `linux-image-amd64` genérico do Debian — a optimização
   fina (preemption, timer frequency) faz-se por parâmetros de boot, não por
   recompilação (ver capítulo 06).
2. **Serviços**: hook de build desactiva serviços de desktop que não são
   essenciais (cups, bluetooth, modemmanager, avahi). Recomendados do APT
   desligados (`--apt-recommends false`) para não arrastar dependências
   "amigáveis" pesadas.
3. **Sessão**: XFCE sem compositor pesado por omissão; wallpaper estático
   (não animado); sem indexação de ficheiros em background. O statusbar rico
   (genmon + systemload + dock) custa ~30–50 MB — já contado na meta.
4. **Memória inteligente**: `zram` (zram-tools) com zstd a 25% da RAM —
   comprime em vez de trocar para disco, aliviando máquinas com 2 GB.
5. **Sysctl afiado**: `vm.swappiness=15` e `vm.vfs_cache_pressure=50`
   (fornecidos em `build/live/config/includes.chroot/etc/sysctl.d/`).

## 2.5 Números de referência da comunidade (para calibrar expectativas)

> Valores de referência divulgados pelos projectos respectivos; servem para
> calibrar metas, não como benchmark oficial.

| Sistema | Ambiente | RAM em idle aproximada |
| --- | --- | --- |
| antiX 26 | IceWM | < 500 MB |
| Lubuntu | LXQt | ~400 MB |
| MX Linux | XFCE | ~600–700 MB |
| **Carsai OS (meta)** | XFCE enxuto + painel rico | **≤ 800 MB** |

O método de medição oficial do projecto (para todos os testes comparáveis):

1. Boot ao vivo (ISO) ou sessão instalada, sem rede activa.
2. 5 minutos de sessão parada, sem apps abertas.
3. `free -m` → valor da coluna `available` subtraído à RAM total.

## 2.6 Porquê XFCE e não LXQt, por omissão

- XFCE tem **maturidade de personalização** (xfconf, xfwm4, painéis
  modulares) que permite aplicar o tema Neon a todo o desktop de forma
  fiável e programática.
- O diferencial do Carsai é a camada visual; LXQt poupa ~100–150 MB, mas
  dificulta a mesma fidelidade visual.
- A alternativa LXQt permanece no roteiro como variação futura para
  hardware ainda mais antigo, com estética simplificada; está fora do
  escopo do produto actual (mínimo 2 GB).
