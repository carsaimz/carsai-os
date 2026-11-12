# 07 — Roteiro de implementação

> [English](07-roadmap.en.md) | **Português**

Roteiro de alto nível, com critérios de saída por fase. Uma fase só é
considerada fechada quando **todos** os critérios são verificados e
documentados (com números, não sensações).

> **Estado actual e trem de versões:** veja o quadro vivo em
> [`ROADMAP.md`](../ROADMAP.md) (raiz do repo). Este capítulo mantém os
> critérios de saída detalhados.

## Estado actual do repositório (2026-11-12)

- [x] Documentação técnica completa (`docs/01`–`docs/09`)
- [x] Configuração live-build pronta para construir a ISO (`build/live/`)
- [x] Quatro temas GTK3 **+ xfwm4** + esquemas de terminal + seletor (`themes/`)
- [x] Wallpapers gerados por IA + logo provisório (`branding/`)
- [x] CI que compila a ISO a cada push relevante (`.github/workflows/`)
- [x] Release v0.1.0-alpha publicada com ISO + sha256
- [x] Shell Windows + Android estilo hacker (statusbar, dock, atalhos, Wine,
      Waydroid, banner) — capítulo 08

## Fase 1 — Base

**Objectivo**: remasterizar o Debian Stable com XFCE, aplicando o tema
"Carsai Neon" e a galeria de temas. **Ferramenta**: live-build (este repo usa
live-build; *Cubic* é uma alternativa gráfica para quem preferir).

**Já implementado no scaffold**: `auto/config` (bookworm, amd64, XFCE,
`--apt-recommends false`), lista de pacotes `carsai-os.list.chroot`, hook de
trimação de serviços, sysctl + zram, branding no LightDM, autostart de
primeiro arranque.

**Critérios de saída**:

- [x] ISO bootável produzida pelo CI e localmente (`build/live/*.iso`)
- [ ] Sessão XFCE entra com Carsai Neon aplicado (primeiro arranque)
- [ ] ≤ 800 MB de RAM em idle medidos pelo método oficial (capítulo 02)
- [ ] Instalação básica funciona em VM com 2 GB de RAM

> Boot pela CI confirmado; as medições em VM ficam para a Fase 5
> (ferramenta: `carsai-doctor` gera o relatório para anexar ao issue).

## Fase 2 — Identidade

**Objectivo**: empacotar temas, ícones, wallpapers e o seletor de temas;
testar em VM com 2 GB e 4 GB de RAM.

**Tarefas**:

- [x] Tema xfwm4 com barra de título desenhada (assets próprios)
- [ ] Tema de ícones Carsai (base enxuta, override pontual)
- [ ] Teste de fidelidade visual dos 4 temas em apps GTK3 do XFCE
- [ ] Applet/lançador do seletor no painel (opcional, UX)
- [ ] Suíte de screenshots de regressão visual

**Critérios de saída**: 4 temas completos sem quebras em apps-core do XFCE;
troca de tema pelo seletor < 5 s, sem logout.

## Fase 3 — Wine

**Objectivo**: pré-instalar Wine + Bottles/Lutris com bibliotecas essenciais
e documentar limitações.

**Tarefas**:

- [x] Decidir: dentro da ISO vs. instalador pós-instalação (**dentro da ISO**,
      com wine32:i386 activado no build — ISO ~1.3 GB)
- [ ] Prefixo padrão + winetricks core (corefonts, vcrun)
- [ ] Documento de compatibilidade (apps testados, o que falha e porquê)
- [ ] Benchmarks de RAM com app de produtividade típica

**Critérios de saída**: um .exe de produtividade real corre a partir do
Bottles sem comandos manuais; limitações documentadas.

## Fase 4 — Waydroid

**Objectivo**: avaliar a maturidade do Wayland no XFCE/Debian naquele
momento. Se viável, integrar o Waydroid como "Carsai Android" (opcional na
instalação).

**Tarefas**:

- [x] `scripts/install-waydroid.sh` + `carsai-android` (launcher em janela
      aninhada sobre X11 — implementado antes da avaliação formal)
- [ ] Relatório de estado do Wayland no XFCE (4.20+/Debian da altura)
- [ ] Protótipo: Waydroid numa sessão Wayland separada vs. integração X11
- [ ] Decisão documentada (cenário A do capítulo 05)

**Critérios de saída**: app Android abre como janela integrada OU decisão
fundamentada para adiar, com plano alternativo.

## Fase 5 — Refinamento

**Objectivo**: testes de estresse em hardware real com 2 GB e 4 GB, ajuste de
serviços (desabilitar o que não for essencial), documentação do utilizador.

**Tarefas**:

- [x] Instalador de disco (Calamares, marca `carsai`, docs/09)
- [x] `carsai-update` + `carsai-doctor` (manutenção e relatórios)
- [ ] Matriz de testes em hardware real (≥ 3 máquinas, com/sem SSD)
- [ ] Auditoria final de serviços activos em idle
- [ ] Manual do utilizador (instalar, actualizar, temas, compatibilidade)
- [ ] Release: primeira ISO 0.1.0-beta pública com checksums

**Critérios de saída**: release 0.1.0-beta publicada; sem regressões de RAM
vs. Fase 1; documentação de utilizador revista por um terceiro.

## Governança de versões

- `-alpha`: scaffold e fases experimentais (agora).
- `-beta`: Fase 5 concluída.
- `1.0`: primeira versão estável para o público geral.
