# 06 — Decisões de arquitectura (o que NÃO fazer)

Tão importante quanto o que construimos é o que **recusamos construir**. Este
capítulo lista as decisões anti-overengineering do projecto, cada uma com a
justificação técnica. Se um PR proponha reverter uma destas decisões, precisa
de dados novos (benchmarks, mudanças upstream) para o fazer.

## 6.1 Não criar um gestor de pacotes próprio

**Decisão**: usar o `apt` do Debian. Reempacotar ou criar um sistema próprio é
esforço desnecessário e arriscado.

- O apt tem 25+ anos de maturidade, resolução de dependências testada,
  repositórios com milhares de pacotes e atualizações de segurança contínuas.
- Um gestor próprio duplicaria o trabalho e criaria uma classe inteira de
  bugs que o Debian já resolveu.
- A personalização do Carsai fica na **camada de configuração** (o que é
  instalado, como está afinado), não na ferramenta.

## 6.2 Não compilar um kernel customizado do zero

**Decisão**: usar o kernel genérico do Debian (`linux-image-amd64`).

- O kernel Debian já é optimizado o suficiente e **recebe atualizações de
  segurança automaticamente** — um kernel próprio obrigaria a equipa a
  acompanhar CVEs e a reconstruir manualmente, para sempre.
- Ajustes finos (preemption, timer frequency) podem ser feitos via
  **parâmetros de boot**, se necessário — sem fork.
- Custo/benefício negativo: o ganho de RAM/velocidade de um kernel afinado
  à mão é marginal comparado com o risco de manutenção.

## 6.3 Não emular Android via máquina virtual completa

**Decisão**: Waydroid (container LXC) em vez de emuladores/VMs Android.

- Uma VM Android carrega kernel + init + daemon Android completos: centenas
  de MB extra em idle, incompatível com a meta de leveza.
- O Waydroid partilha o kernel do hospedeiro (LXC): desempenho quase nativo
  e consumo muito inferior.
- Detalhes no capítulo 05.

## 6.4 Não implementar suporte nativo a .exe

**Decisão**: Wine/Proton como camada de compatibilidade; sem reescrita de
APIs do Windows.

- Reescrever as APIs do Windows é inviável para um projecto desta dimensão
  (o Wine existe desde 1993 precisamente porque isto é um problema
  gigantesco).
- O Wine é consolidado, activo e leve (tradução de chamadas, sem emulação).
- O esforço do Carsai concentra-se em **pré-configuração** (prefixo, winetricks,
  Bottles) e **documentação de limitações**, não em reinvenção.

## 6.5 Princípio transversal

Cada componente novo tem de responder a uma pergunta:

> "Isto melhora a experiência do utilizador final mais do que aumenta a
> superfície de manutenção da equipa?"

Se a resposta não for um "sim" óbvio com dados, a resposta é **não**.

## 6.6 Tabela-resumo

| Tentação | Decisão | Alternativa adoptada |
| --- | --- | --- |
| Gestor de pacotes próprio | ❌ Rejeitado | apt do Debian |
| Kernel compilado do zero | ❌ Rejeitado | kernel Debian + parâmetros de boot |
| Android em VM completa | ❌ Rejeitado | Waydroid (container LXC) |
| Suporte nativo a .exe | ❌ Rejeitado | Wine/Proton + Bottles/Lutris |
| Compositor 3D pesado por omissão | ❌ Rejeitado | XFCE sem efeitos; wallpaper estático |
| Tema de ícones gigantesco (300+ MB) | ❌ Rejeitado | Adwaita por agora; tema próprio enxuto na Fase 2 |
