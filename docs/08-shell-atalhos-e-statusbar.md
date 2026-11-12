# 08 — Shell: atalhos, statusbar rico e a experiência Windows + Android

> Estado: **implementado na ISO (alpha)**. Este capítulo descreve o shell
> Carsai: como o XFCE foi configurado para parecer familiar para quem vem
> do Windows, fluido para quem vem do Android — mantendo a estética hacker
> (terminal no centro, monospace, néon).

## 8.1 Filosofia do shell

Três influências deliberadas, uma por camada:

| Camada | Influência | Implementação |
| --- | --- | --- |
| Navegação | **Windows** | Menu iniciar, Win+E/R/D/L/V, snap com Win+setas, taskbar com ícones agrupados |
| Movimento | **Android** | Dock inferior auto-ocultável, workspaces como "ecrãs iniciais", apps de toque via Waydroid (cap. 05) |
| Identidade | **Hacker** | Terminal como cidadão de primeira classe, fontes monospace (JetBrains Mono), statusbar com métricas do sistema, banner ASCII no primeiro boot |

Tudo é configurável via xfconf — nada foi forkado nem remendado; é o XFCE
stock com uma configuração coesa (anti-overengineering, ver cap. 06).

## 8.2 Painéis: statusbar (topo) + dock (base)

**Painel 1 — statusbar rico (topo, 30 px):**

| Slot | Widget | Função |
| --- | --- | --- |
| 1 | Whisker Menu | Menu iniciar com o ícone Carsai |
| 2 | Pager | Workspaces (4 por omissão) — estilo "ecrãs iniciais" |
| 3 | Separador elástico | Empurra o resto para a direita |
| 4 | **Genmon** | Feed `carsai-statusbar`: CPU %, RAM %, rede ↓/↑ em tempo real |
| 5 | System Load | Barras CPU/RAM/swap com tooltip detalhado |
| 6 | Bandeja do sistema | NetworkManager, área de transferência, etc. |
| 7 | PulseAudio | Controlo de volume |
| 8 | Relógio digital | `%H:%M:%S` (segundos visíveis — ritmo hacker) |

**Painel 2 — dock (base, 46 px, auto-oculta):**

- Launchers fixados: Terminal, Ficheiros (Thunar), Firefox ESR, Mousepad;
- Tasklist agrupada (janelas abertas, ícones sem rótulos);
- Botão "mostrar ambiente" no canto.

O dock intellihide: esconde-se quando uma janela o invade e reaparece ao
aproximar o rato da borda — comportamento familiar do Android/Windows 11.

### 8.2.1 O feed `carsai-statusbar`

Script em `/usr/local/bin/carsai-statusbar`, chamado pelo plugin **Generic
Monitor** a cada 3 segundos. Sem dependências além de `awk`:

- **CPU**: deltas de `/proc/stat`;
- **RAM**: `MemTotal - MemAvailable` de `/proc/meminfo`;
- **Rede**: contadores de `/sys/class/net/<iface>/statistics/` (interface
  da rota por omissão), convertidos em taxa por segundo;
- **Tooltip**: kernel, IP, uptime;
- **Clique**: abre o `btop`.

Estado entre execuções: uma linha em `/tmp/carsai-statusbar.state`.

## 8.3 Atalhos de teclado (estilo Windows)

Deltas sobre os padrões do XFCE (que continuam activos: Alt+F4, Alt+Tab,
F12, ...). Definidos em
`includes.chroot/etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml`.

| Atalho | Acção |
| --- | --- |
| `Win` | Menu iniciar (Whisker) |
| `Win+E` | Gestor de ficheiros (Thunar) |
| `Win+R` | Executar aplicação (appfinder recolhido) |
| `Win+D` | Mostrar ambiente (alternar) |
| `Win+L` | Bloquear ecran (xflock4) |
| `Win+V` | Histórico da área de transferência (Clipman) |
| `Win+setas` | Snap: esquerda/direita, maximizar/minimizar |
| `Ctrl+Win+←/→` | Workspace anterior/seguinte (estilo Windows) |
| `Ctrl+Alt+←/→` | Workspace anterior/seguinte (clássico) |
| `Win+1..4` | Salto directo ao workspace N |
| `Ctrl+Alt+T` ou `Win+Enter` | Terminal |
| `Ctrl+Alt+Del` | Gestor de tarefas |
| `Print` / `Alt+Print` / `Shift+Print` | Screenshot: tela / janela / região |

## 8.4 Janelas: xfwm4 com decorações Carsai

Cada tema GTK tem um **tema xfwm4 correspondente** (barra de título e
botões XPM gerados, acentos idênticos aos do GTK — ver
`themes/src/generate-xfwm4-themes.py`). O seletor aplica os dois juntos.

Predefinições do gestor de janelas (`xfwm4.xml`):

- compositor activo com opacidade 90 % nas janelas inactivas e 85 % nas
  barras de título — profundidade sem custo perceptível;
- 4 workspaces;
- fonte da barra de título: JetBrains Mono Bold 10.

## 8.5 Primeiro boot: banner hacker

No primeiro login (só no primeiro — marcador `~/.config/carsai/welcome-done`):

1. o autostart abre o xfce4-terminal com `carsai-banner`;
2. o banner imprime a arte ASCII Carsai + `neofetch`;
3. lista de atalhos e comandos (`carsai-theme-selector`, `carsai-exe`,
   `btop`, `ranger`);
4. em paralelo, o seletor aplica o tema Neon por omissão (autostart
   existente, silencioso).

A partir do segundo boot, nenhum terminal abre automaticamente.

## 8.6 Comandos do sistema Carsai

| Comando | Função |
| --- | --- |
| `carsai-theme-selector` | Menu interativo de temas (GTK + wallpaper + terminal + janelas) |
| `carsai-theme-selector --set KEY` | Aplica directamente (`neon|dark|retrowave|light`) |
| `carsai-exe programa.exe` | Executa programas Windows via Wine (prefixo criado à primeira) |
| `carsai-update [--clean]` | Actualiza o sistema (apt update + full-upgrade; `--clean` remove órfãos) |
| `carsai-doctor` | Relatório do sistema (RAM idle, zram, serviços, temas) para issues |
| `carsai-statusbar` | (interno) alimenta o widget genmon do painel |
| `carsai-welcome` | (interno) abre o banner uma única vez |
| `carsai-android` | Abre o ambiente Android (após `scripts/install-waydroid.sh`) |

## 8.7 Testar o shell sem construir a ISO

```bash
./scripts/install-themes.sh user         # temas + seletor em ~/.themes
cp -r build/live/config/includes.chroot/etc/skel/.config/xfce4 ~/.config/
xfce4-panel -r                           # recarrega painéis com o layout Carsai
```

(Numa sessão XFCE de teste; o `carsai-statusbar` precisa de estar em
`$PATH` — por exemplo `~/.local/bin`.)
