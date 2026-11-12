# Carsai OS — camada de temas

> [English](README.en.md) | **Português**

A identidade visual do Carsai OS vive aqui. Quatro temas GTK3 completos,
um tema de ícones próprio, esquemas de cores de terminal e um seletor sem
dependências externas.

## Estrutura

```
themes/
├── carsai-neon/            # tema padrão (cyberpunk/néon escuro)
├── carsai-dark-minimal/    # escuro sóbrio (produtividade)
├── carsai-retrowave/       # synthwave/outrun
├── carsai-light-tech/      # claro com acentos tech
│   ├── gtk-3.0/gtk.css     # folha de estilos GTK3
│   ├── xfwm4/              # decorações de janela (XPMs gerados)
│   └── index.theme         # metadados
├── terminal/
│   ├── xfce4/*.theme       # esquemas de cores do xfce4-terminal
│   └── tilix/*.json        # esquemas de cores do Tilix
├── icons/
│   └── carsai/             # tema de ícones (override enxuto sobre Adwaita)
├── selector/
│   └── carsai-theme-selector   # CLI: aplica GTK + xfwm4 + ícones + wallpaper + terminal
└── src/
    ├── generate-xfwm4-themes.py # gerador das decorações xfwm4
    └── generate-carsai-icons.py # gerador do tema de ícones
```

## Nomes instalados

Na ISO (via `scripts/build-iso.sh`), os temas são instalados com nome com
hífen — o nome que o xfconf espera em `/Net/ThemeName`:

| Pasta no repo | Nome instalado |
| --- | --- |
| `themes/carsai-neon` | `/usr/share/themes/Carsai-Neon` |
| `themes/carsai-dark-minimal` | `/usr/share/themes/Carsai-Dark-Minimal` |
| `themes/carsai-retrowave` | `/usr/share/themes/Carsai-Retrowave` |
| `themes/carsai-light-tech` | `/usr/share/themes/Carsai-Light-Tech` |
| `themes/icons/carsai` | `/usr/share/icons/carsai` (tema de ícones) |

## Seletor

```bash
carsai-theme-selector            # menu interativo
carsai-theme-selector --set neon # aplicação directa (neon|dark|retrowave|light)
carsai-theme-selector --list     # listar
```

O seletor aplica **todos os lados** do tema: GTK (`/Net/ThemeName`), as
decorações de janela xfwm4 (`/general/theme`), o tema de ícones `Carsai`
(`/Net/IconThemeName`, quando instalado) — o tema instalado contém os
sub-diretórios `gtk-3.0/` e `xfwm4/`.

Na ISO, `/usr/local/bin/carsai-theme-selector` corre com `--first-run` no
primeiro login (autostart do skel) e aplica o **Carsai Neon** uma única vez.

## Testar sem construir a ISO

```bash
./scripts/install-themes.sh user    # instala em ~/.themes etc. (sem root)
~/.local/bin/carsai-theme-selector
```

## Como acrescentar um tema novo

1. Copia uma pasta existente (`cp -r themes/carsai-dark-minimal themes/carsai-meu-tema`).
2. Edita as `@define-color` no `gtk-3.0/gtk.css` (a paleta no topo controla tudo).
3. Acrescenta o mapeamento em `themes/selector/carsai-theme-selector` (array
   `THEMES`), em `scripts/build-iso.sh` (mapa `THEMES`) e em
   `scripts/install-themes.sh`.
4. Acrescenta a paleta do tema em `themes/src/generate-xfwm4-themes.py` e
   corre o gerador para criar as decorações de janela.
5. Cria o wallpaper correspondente em `branding/wallpapers/carsai-meu-tema.png`
   e o esquema de terminal (pode derivar de um existente).

## Limitações conhecidas (Fase 2 no roteiro)

- **GTK4/libadwaita**: não incluído nesta fase (XFCE é GTK3).
- **Ícones**: Adwaita por omissão; tema de ícones Carsai previsto na Fase 2.
