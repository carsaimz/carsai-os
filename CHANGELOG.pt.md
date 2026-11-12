# Registo de alterações — Carsai OS
> [English](CHANGELOG.md) | **Português**
>
> Nota: este ficheiro é um espelho em português — actualizar primeiro o [CHANGELOG.md](CHANGELOG.md) canónico.

Todas as alterações notáveis deste projecto são documentadas aqui.
Formato baseado em [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); o versionamento usa [SemVer](https://semver.org/) com os sufixos `-alpha` / `-beta` durante as fases iniciais.

## [Unreleased]

### Adicionado
- Tema de ícones `Carsai` — sobreposição leve do Adwaita (ícones de pasta,
  pasta pessoal, área de trabalho e os ícones mime do Windows/.exe),
  gerado por `themes/src/generate-carsai-icons.py`; aplicado por omissão
  via xsettings e trocado em conjunto com o resto do tema pelo selector.

## [0.1.1-alpha] - 2026-11-12

### Adicionado
- `ROADMAP.md` (raiz do repositório) — quadro de estado das fases e trem de versões.
- Instalador em disco: Calamares pré-instalado com a marca `carsai` e um
  lançador de área de trabalho "Instalar o Carsai OS" (docs/09).
- `carsai-update` (APT update/upgrade/clean) e `carsai-doctor` (relatório do
  sistema para relatórios de erros).

### Alterado
- Metas de memória relaxadas: em idle ≤ **800 MB** (antes 600 MB) e RAM mínima
  elevada para **2 GB** (antes 1 GB); recomendados 4 GB, confortáveis 8 GB.
- READMEs e documentação: identidade de projecto neutra (menções à organização
  removidas, créditos mantidos); ligação do site simplificada.
- Metadados de editor da ISO definidos como "Carsai OS".

## [0.1.0-alpha] - 2026-11-12

Primeira alfa pública: uma live ISO bootável de Debian 12 (bookworm) com a
identidade Carsai OS, uma shell estilo Windows + hacker e suporte a .exe.

### Adicionado
- Estrutura base do projecto: README bilingue (EN/PT), licença MIT, guia de contribuição.
- Documentação técnica em português (`docs/01`–`docs/08`).
- Configuração live-build para Debian 12 (bookworm), amd64, XFCE: lista de
  pacotes personalizada (`carsai-os.list.chroot`), hook de aparagem de
  serviços, hook wine32-multilib, afinação de sysctl/zram, identidade do
  greeter LightDM, autostart do tema na primeira utilização, fuso horário
  live Africa/Maputo.
- Camada de temas com quatro temas (GTK3 **+ decorações de janela xfwm4
  correspondentes**): `Carsai-Neon` (padrão), `Carsai-Dark-Minimal`,
  `Carsai-Retrowave`, `Carsai-Light-Tech`.
- Esquemas de cores de terminal para o xfce4-terminal e o Tilix (um por tema).
- CLI `carsai-theme-selector` (aplica o tema GTK, o tema xfwm4, papel de
  parede e paleta do terminal; modo `--first-run` para a predefinição
  live/instalação).
- Statusbar rico (painel superior): botão de início do whiskermenu com o
  ícone Carsai, pager de workspaces, feed de sistema do genmon
  (`carsai-statusbar`: CPU %, RAM %, rede ↓/↑), carga do sistema, bandeja,
  áudio, relógio com segundos.
- Dock inferior: lançadores fixados (terminal, ficheiros, navegador,
  editor), lista de tarefas agrupada, mostrar área de trabalho, intellihide.
- Atalhos de teclado estilo Windows: Win (menu iniciar), Win+E/R/D/L/V,
  snap via Win+setas, workspaces via Ctrl+Win+setas / Win+1..4, gestor de
  tarefas em Ctrl+Alt+Del, variantes do PrintScreen.
- Banner de boas-vindas hacker no primeiro boot (arte ASCII, neofetch, cola
  de atalhos); mostrado uma vez por conta.
- Comandos de sistema: `carsai-exe` (programas do Windows via Wine), além
  de `carsai-statusbar` / `carsai-welcome` / `carsai-banner` internos.
- Compatibilidade com .exe do Windows: Wine 64 bits + **wine32:i386**
  (multiarch i386 activado em tempo de compilação), winetricks, fonts-wine,
  cabextract.
- Caminho Android: `scripts/install-waydroid.sh` (repositório oficial do
  Waydroid + weston) e o launcher `carsai-android` (janela aninhada estilo
  telefone).
- Kit de ferramentas de terminal hacker: btop, neofetch, tmux, ranger, ncdu,
  cmatrix, xdotool, wmctrl; Firefox ESR como navegador por omissão.
- Identidade visual: papéis de parede gerados por IA (um por tema), ícone
  SVG placeholder (a substituir pela arte oficial), arte ASCII.
- CI: compilação da ISO em cada push que toque em build/themes/branding
  (com concorrência de compilação), lint de shell e um workflow de release
  que compila e anexa a ISO + sha256 ao GitHub Release em cada tag `v*`.

### Alterado
- Predefinições do xfwm4: composição activa, janelas inactivas a 90% de
  opacidade, 4 workspaces, fonte de título JetBrains Mono.

## [Unreleased-compare]: https://github.com/carsaimz/carsai-os/compare/v0.1.1-alpha...HEAD
[0.1.1-alpha]: https://github.com/carsaimz/carsai-os/releases/tag/v0.1.1-alpha
[0.1.0-alpha]: https://github.com/carsaimz/carsai-os/releases/tag/v0.1.0-alpha
