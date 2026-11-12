# 01 — Visão geral e filosofia

> [English](01-visao-geral.en.md) | **Português**

## 1.1 O que é o Carsai OS

O Carsai OS é uma distribuição Linux personalizada, derivada do **Debian
Stable**, projectada para ser leve o suficiente para rodar confortavelmente em
máquinas com **2–4 GB de RAM**, mas com uma identidade visual moderna e
imersiva — temática **tech / cyberpunk / néon**.

O objectivo não é competir com distros generalistas em quantidade de recursos,
mas oferecer uma experiência **coesa, estilosa e eficiente** em hardware
modesto, com um caminho planeado para compatibilidade com aplicativos
**Windows (.exe)** e **Android (.apk)**.

Em resumo:

- **Leveza com personalidade**: cada MB de RAM poupado é um MB disponível para
  o utilizador — mas o sistema nunca deve parecer "pobre".
- **Coerência visual**: temas, ícones, wallpapers, terminal e ecrã de login
  partilham a mesma paleta e a mesma linguagem.
- **Caminho para compatibilidade**: Wine (.exe) e Waydroid (.apk) estão no
  roteiro, planeados desde o início para não violar a meta de leveza.

## 1.2 Nomenclatura

| Nome | Uso |
| --- | --- |
| **Carsai OS** | Nome do produto principal (a distribuição) |
| Prefixo `Carsai-*` | Componentes individuais (temas, scripts, pacotes) |

O prefixo é a identidade; o sufixo pode variar consoante o contexto. Isto dá
liberdade para criar, no futuro, sub-projectos relacionados
(ex.: *Carsai Studio*, *Carsai Mobile Tools*) sem fragmentar a marca.

## 1.3 Público-alvo

1. **Utilizadores com hardware modesto**: portáteis e desktops com 2–4 GB de
   RAM que o software moderno deixou para trás.
2. **Utilizadores que migram de Windows** e precisam de executar alguns
   aplicativos .exe (Fase 3) sem aprender gestão de VMs.
3. **Entusiastas da estética tech/neon** que querem um desktop com identidade
   forte sem montar temas à mão.

## 1.4 O que o Carsai OS **não** é

- **Não é** uma distro de segurança/pen-test nem uma distro multimédia
  especializada — é um desktop geralista leve com identidade própria.
- **Não é** uma reimplementação de gestores de pacotes nem um kernel
  customizado (ver capítulo 06 — anti-overengineering).
- **Não é** um emulador: as camadas de compatibilidade (.exe/.apk) usam as
  tecnologias consolidadas (Wine, Waydroid), não emulação pesada.
- **Não é**, nesta fase, uma distro para servidores.

## 1.5 Princípios de design

1. **Cada serviço tem de justificar o seu lugar.** Se não é essencial para um
   desktop, está desligado por omissão.
2. **A leveza não é negociação para a estética.** Um tema bem construído
   (CSS/GTK) custa ~0 RAM; é gratuito comparado com efeitos de composição
   pesados.
3. **Padrões antes de invenções.** Debian + XFCE + live-build + xfconf são
   ferramentas maduras; escrever infra-estrutura própria é risco, não valor.
4. **Tudo documentado.** Cada decisão com justificação (capítulo 06) e cada
   fase com critério de saída (capítulo 07).
