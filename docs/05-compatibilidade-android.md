# 05 — Compatibilidade com Android (.apk)

> [English](05-compatibilidade-android.en.md) | **Português**

> Estado: **caminho oficial definido e automatizado**. O Waydroid não vem
> na ISO (exige kernel com módulos LXC/binder e consome RAM própria); em
> vez disso, um script oficial instala-o num sistema **instalado**.

## 5.0 Instalação oficial (sistema instalado)

```bash
sudo scripts/install-waydroid.sh   # repo oficial + waydroid + weston
carsai-android                     # abre o Android em janela estilo telefone
```

O script `install-waydroid.sh` adiciona o repositório oficial do Waydroid
(chave GPG em `/usr/share/keyrings/waydroid.gpg`), instala `waydroid` +
`weston`, activa o serviço do container e corre `waydroid init` (imagem
*vanilla*, sem Google Apps — para Play Store: `sudo waydroid init -s GAPPS`).

O launcher `carsai-android` resolve o pré-requisito gráfico do XFCE (X11):
inicia um **Weston aninhado** (janela 720×1280, tipo telefone) e abre a UI
do Waydroid dentro dele. Em sessões Wayland reais, abre directamente.

> A sessão live da ISO não persiste alterações; instale o Carsai OS antes
> de usar o Waydroid.

## 5.1 Tecnologia no Linux: Waydroid

O **Waydroid** é um container **LXC** que roda um sistema Android completo
**partilhando o kernel do Linux**, sem emulação. O resultado é:

- desempenho quase nativo;
- consumo de memória significativamente menor que emuladores tradicionais
  (que carregam um kernel Android inteiro numa VM).

> Nota: o Anbox, antecessor conceptual, está arquivado; o Waydroid é a
> solução mais madura e activa para Android em Linux.

## 5.2 Pré-requisito crítico: Wayland

O Waydroid depende do **Wayland** para integração gráfica suave. O XFCE é
maioritariamente X11, por isso o caminho oficial usa **Weston aninhado**
(janela tipo telefone dentro do X11 — ver 5.0). Quando o suporte a Wayland
do XFCE/Debian amadurecer (XFCE 4.20+), o Weston aninhado deixa de ser
necessário e as janelas Android tornam-se nativas sem mudanças no script.

## 5.3 Integração no desktop

Após instalado, os apps Android aparecem **no menu de aplicativos como
janelas nativas**, graças à camada de integração do Waydroid — o utilizador
não precisa de gerir o container manualmente.

## 5.4 Expectativa de recursos

Para um sistema com 4 GB de RAM, rodar o Waydroid junto com o desktop Linux é
**viável**, mas exige gestão de memória (o Android consome memória própria):

| Cenário | RAM total estimada |
| --- | --- |
| Desktop Carsai (idle) | ≤ 800 MB |
| Desktop + Waydroid idle | +700 MB – 1.2 GB |
| Desktop + Waydroid + app Android pesada | 2.5–3.5 GB |

O container pode ser **parado** quando não é usado (não há custo em idle),
o que mantém a meta de leveza.

## 5.5 "Android dentro de Linux ou Windows" — cenários conceptuais

A ideia de ter Android "dentro" do sistema pode ser interpretada de duas
formas, e a documentação separa-as explicitamente:

### Cenário A — Carsai OS (Linux) com Android (Waydroid) ✅

É o cenário descrito neste capítulo: o Carsai OS é o hospedeiro Linux e o
Waydroid fornece o ambiente Android containerizado. **É a rota oficial do
projecto**, alinhada com a filosofia (leveza + compatibilidade), pois não
exige uma máquina virtual pesada.

### Cenário B — Windows a hospedar Android, gerido a partir do Carsai (externo) ⚠️

Se o objectivo for "usar Android dentro do Windows" enquanto se está no
ecossistema Carsai, isso é um cenário **fora do âmbito do sistema
operacional**. No Windows, a solução histórica era o **WSA (Windows Subsystem
for Android)**, descontinuado pela Microsoft; a comunidade mantém o
**WSABuilds** (fork que preserva a Play Store).

O Carsai OS **não pode "embutir" Android no Windows**, mas pode documentar
esse caminho para utilizadores que fazem dual boot ou usam Windows como
host. É uma **nota informativa**, não um recurso do SO.

### Recomendação

Tratar o **Waydroid como a solução oficial do Carsai OS para Android**
(Cenário A). O cenário Windows (B) fica apenas como documentação auxiliar.
