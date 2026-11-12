# 04 — Compatibilidade com Windows (.exe)

> Estado: **na ISO desde a alpha**. O Wine (32 + 64 bits) e o winetricks
> vêm pré-instalados; este capítulo fixa a abordagem e as expectativas.

## 4.1 Tecnologia

**Wine** (camada de compatibilidade), incluído na ISO:

- `wine` + `wine64` da lista de pacotes, e **`wine32:i386`** instalado pelo
  hook `0110-wine32-multilib.hook.chroot` (multiarch activada em tempo de
  build) — a maioria dos programas Windows é 32-bit, portanto o suporte
  completo vem de fábrica;
- **winetricks** + `fonts-wine` + `cabextract` para DLLs/fontes comuns;
- prefixo padrão `~/.wine` criado automaticamente na primeira execução.

Interface gráfica opcional: **Bottles ou Lutris** podem ser instalados via
apt pelo utilizador; o fluxo padrão do sistema é o comando `carsai-exe`.

## 4.2 Como usar

```bash
carsai-exe ~/Downloads/programa.exe        # via terminal (fluxo hacker)
# ou: duplo clique no .exe no Thunar (associação do Wine)
winetricks corefonts                       # adicionar fontes/DLLs
winecfg                                    # configuração do Wine
```

O primeiro `.exe` executado demora mais alguns segundos (criação do
prefixo `~/.wine`).

## 4.3 Expectativa realista

- O Wine oferece **desempenho próximo do nativo** para muitos aplicativos de
  produtividade e softwares mais antigos, **sem overhead de virtualização** —
  o Wine não emula hardware, traduz chamadas de API.
- **Não é 100% compatível.** Podem falhar:
  - softwares com **DRM rígido**;
  - jogos com **anti-cheat em nível de kernel** (ex.: alguns títulos
    multiplayer recentes);
  - aplicações que dependem de **drivers proprietários** específicos.

Esta limitação é inerente à abordagem (e partilhada por toda a indústria);
a resposta do Carsai OS é **documentar o que funciona** e não prometer o que
não controlamos.

## 4.4 Requisito de hardware

Como o Wine não emula hardware, o impacto extra de RAM/CPU é **baixo** —
compatível com a meta de < 4 GB. O consumo depende da aplicação Windows
em execução, não do Wine em idle.

| Cenário | RAM adicional típica |
| --- | --- |
| Wine + app de produtividade leve | +200–400 MB |
| Wine + app pesada (suite office) | +500 MB–1 GB |
| Proton + jogo | variável (depende do jogo) |

## 4.5 O que o Carsai OS **não** fará

- **Não** reescreverá APIs do Windows (inviável — ver capítulo 06).
- **Não** incluirá cracks/ferramentas de contorno de DRM, nunca.
- **Não** garantirá compatibilidade por versão do Wine sem testes reais.
