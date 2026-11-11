# 03 — Sistema de temas (identidade visual)

O grande diferencial do Carsai OS é a camada visual. A estratégia separa o
**tema padrão** (tech/cyberpunk/néon) de uma **galeria de temas prontos** que o
utilizador pode escolher com um seletor simples.

## 3.1 Tema padrão "Carsai Neon"

**Estética**: fundos escuros, acentos em ciano/magenta, elementos com brilho
subtil, tipografia monoespaçada em títulos.

**Componentes empacotados** (fontes de inspiração: projetos como *CyberHack*
e *Cyberpunk Neon*):

| Componente | Implementação neste repositório |
| --- | --- |
| Tema GTK (apps XFCE) | `themes/carsai-neon/gtk-3.0/gtk.css` — CSS GTK3 completo (janelas, headerbars, botões, entradas, sidebars, menus, scrollbars, tooltips, painel XFCE) |
| Papel de parede | `branding/wallpapers/carsai-neon.png` (gerado por IA, 1344×768) |
| Esquema do terminal | `themes/terminal/xfce4/carsai-neon.theme` (xfce4-terminal) + `themes/terminal/tilix/carsai-neon.json` (Tilix) |
| Ecrã de login (LightDM) | `build/live/config/includes.chroot/etc/lightdm/lightdm-gtk-greeter.conf` — tema + fundo com identidade Carsai |
| Ícones | Nesta fase usa-se Adwaita (embutido no GTK); um tema de ícones Carsai coeso está previsto na Fase 2 |

### Paleta de referência (Carsai Neon)

| Papel | Cor |
| --- | --- |
| Fundo principal | `#0A0A12` |
| Fundo secundário / superfícies | `#13131F` |
| Acento primário (ciano néon) | `#00E5FF` |
| Acento secundário (magenta néon) | `#FF2EC4` |
| Texto principal | `#E0E7FF` |
| Texto secundário | `#8A93B2` |
| Sucesso | `#00E676` |
| Aviso | `#FFD600` |
| Erro | `#FF1744` |

## 3.2 Galeria de temas (seleção pré-instalada)

O sistema vem com **4 temas completos** (incluindo o padrão), gerenciáveis
pelo seletor (`carsai-theme-selector`, instalado em `/usr/local/bin` na ISO e
em `~/.local/bin` no modo desenvolvimento):

| Tema | Direção estética | Pasta |
| --- | --- | --- |
| **Carsai Neon** (padrão) | Cyberpunk/néon escuro | `themes/carsai-neon/` |
| **Carsai Dark Minimal** | Escuro sóbrio, para produtividade | `themes/carsai-dark-minimal/` |
| **Carsai Retrowave** | Gradientes synthwave/outrun | `themes/carsai-retrowave/` |
| **Carsai Light Tech** | Claro com acentos tech, para ambientes iluminados | `themes/carsai-light-tech/` |

Cada pasta de tema contém `gtk-3.0/gtk.css` (a folha de estilos) e um
`index.theme` com metadados. Os nomes de pasta instalados em
`/usr/share/themes/` são `Carsai-Neon`, `Carsai-Dark-Minimal`,
`Carsai-Retrowave` e `Carsai-Light-Tech` (com hífen — é o nome que o xfconf
espera em `/Net/ThemeName`).

## 3.3 Implementação técnica

A implementação é deliberadamente **trivial e sem dependências novas**:

1. Os temas ficam em `/usr/share/themes` (via `includes.chroot` do live-build,
   sincronizado pelo `scripts/build-iso.sh` a partir de `themes/`).
2. Os wallpapers ficam em `/usr/share/backgrounds/carsai/`.
3. O seletor apenas **aplica configurações** — não instala nada:

```bash
# Tema GTK (xsettings):
xfconf-query -c xsettings -p /Net/ThemeName -s "Carsai-Neon"

# Wallpaper (xfdesktop) — todas as propriedades last-image encontradas:
xfconf-query -c xfce4-desktop -p "$prop" -s "/usr/share/backgrounds/carsai/carsai-neon.png"

# Cores do terminal: escrever ColorPalette*/ColorForeground/ColorBackground
# em ~/.config/xfce4/terminal/terminalrc
```

## 3.4 Seletor de temas (`carsai-theme-selector`)

Um único script bash, sem dependências para além do XFCE + xfconf-query:

| Modo | Comando | Efeito |
| --- | --- | --- |
| Menu interativo | `carsai-theme-selector` | Lista os 4 temas, aplica o escolhido |
| Directo | `carsai-theme-selector --set retrowave` | Aplica sem menu |
| Primeiro arranque | `carsai-theme-selector --first-run` | Aplica o Carsai Neon uma única vez (marca em `~/.config/carsai/first-run-done`) — usado pelo autostart da ISO |
| Listar | `carsai-theme-selector --list` | Mostra os temas disponíveis |

O que o seletor aplica: tema GTK (xsettings), wallpaper em todos os monitores
/ áreas de trabalho detectados via `xfconf-query -c xfce4-desktop -l`, e as
cores do xfce4-terminal.

## 3.5 Extensões futuras (Fase 2)

- **Tema xfwm4** com barra de título desenhada (requer assets XPM — previsto,
  não bloqueia a Fase 1).
- **Tema de ícones Carsai** coeso (a partir de uma base herdada, com override
  pontual dos ícones principais).
- **Tema GTK4/libadwaita** quando o XFCE migrar componentes para GTK4.
- **Mais temas** na galeria (contribuições aceites — ver CONTRIBUTING.md).
