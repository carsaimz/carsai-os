# 04 — Compatibilidade com Windows (.exe) — Fase futura

> Estado: **planeado (Fase 3 do roteiro)**. Nada disto está na ISO ainda;
> este capítulo fixa a abordagem antes de qualquer linha de código.

## 4.1 Tecnologia

**Wine** (camada de compatibilidade) e, opcionalmente, **Proton** (para jogos
via Steam).

O que será necessário:

- **Wine pré-instalado e configurado** com um prefixo padrão (`~/.wine`),
  com bibliotecas essenciais (`corefonts`, `vcrun`, etc.) via **winetricks**.
- **Bottles ou Lutris** como interface gráfica amigável para gerir aplicativos
  Windows, reduzindo a necessidade de linha de comandos.

## 4.2 Expectativa realista

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

## 4.3 Requisito de hardware

Como o Wine não emula hardware, o impacto extra de RAM/CPU é **baixo** —
compatível com a meta de < 4 GB. O consumo depende da aplicação Windows
em execução, não do Wine em idle.

| Cenário | RAM adicional típica |
| --- | --- |
| Wine + app de produtividade leve | +200–400 MB |
| Wine + app pesada (suite office) | +500 MB–1 GB |
| Proton + jogo | variável (depende do jogo) |

## 4.4 Plano de implementação (Fase 3)

1. Adicionar `wine` + `winetricks` + `bottles` à lista de pacotes (ou
   instalador opcional na pós-instalação, a decidir pelo peso da ISO).
2. Criar o prefixo padrão na primeira execução (autostart one-shot, só se o
   utilizador abrir o Bottles).
3. Documentar: aplicações testadas, limitações conhecidas, como reportar.

## 4.5 O que o Carsai OS **não** fará

- **Não** reescreverá APIs do Windows (inviável — ver capítulo 06).
- **Não** incluirá cracks/ferramentas de contorno de DRM, nunca.
- **Não** garantirá compatibilidade por versão do Wine sem testes reais.
