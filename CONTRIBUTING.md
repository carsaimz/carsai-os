# Contribuir para o Carsai OS

Obrigado pelo interesse em contribuir! Este documento define as regras básicas
para manter o projecto coeso.

## Código de conduta

Seja respeitoso. Estamos a construir algo público, de Moçambique para o mundo.
Críticas técnicas são bem-vindas; ataques pessoais, não.

## Áreas do repositório

| Área | O que é | Cuidados especiais |
| --- | --- | --- |
| `docs/` | Documentação técnica (em português) | Manter consistente com a realidade do código |
| `build/live/` | Configuração live-build da ISO | Não fazer commit de saídas geradas (`.build/`, `chroot/`, `*.iso`) |
| `themes/` | Temas GTK, esquemas de terminal, seletor | Um tema = uma pasta; nunca quebrar os nomes `Carsai-*` |
| `branding/` | Logo e wallpapers | O ícone oficial será substituído; não renomear ficheiros sem avisar |
| `scripts/` | Automação (build, instalação) | Testar localmente antes do PR |

## Convenção de commits

Usamos [Conventional Commits](https://www.conventionalcommits.org/pt-br/):

```
<tipo>(<escopo opcional>): <resumo em minúsculas>

exemplos:
docs(temas): adicionar esquema de cores do Tilix
build: reduzir lista de pacotes para cortar RAM em idle
themes: corrigir contraste do headerbar no Carsai Neon
ci: aumentar tempo limite do build da ISO
```

Tipos: `feat`, `fix`, `docs`, `build`, `themes`, `ci`, `chore`, `refactor`, `test`.

## Segurança (muito importante)

- **Nunca** faças commit de tokens, chaves API, passwords ou ficheiros `.env`.
- O `.gitignore` já bloqueia padrões comuns (`*.pem`, `*.key`, `.env`, `*token*`), mas não confies só nele: revê o teu `git diff --staged` antes do commit.
- Se expuseres acidentalmente uma credencial, revoga-a **imediatamente** no GitHub antes de qualquer outra coisa.

## Como testar localmente

### Construir a ISO

```bash
sudo apt-get install -y live-build debootstrap squashfs-tools xorriso
./scripts/build-iso.sh
```

A ISO aparece em `build/live/*.iso` (pode levar 30–60 minutos na primeira vez).

### Testar num VM (2 GB e 4 GB de RAM)

```bash
qemu-system-x86_64 -m 2048 -enable-kvm -cdrom build/live/carsai-os-*.iso
```

Testa sempre com **2 GB** e **4 GB** antes de propor mudanças que toquem na
lista de pacotes ou nos serviços. Mede o idle com:

```bash
free -m   # depois de 5 minutos de sessão parada
```

### Testar os temas sem construir a ISO

```bash
./scripts/install-themes.sh user   # instala em ~/.themes (sem root)
carsai-theme-selector              # menu interativo (se instalado em ~/.local/bin)
```

## Estilo de código

- Shell: `bash` com `set -euo pipefail`, compatível com `shellcheck` (o CI corre).
- Markdown: linhas até ~100 caracteres; títulos hierárquicos (`#`, `##`, `###`).
- Documentação em português; código, comentários e commits em inglês.

## Reportar bugs

Abre uma *issue* com: versão/teste usado (ISO ou commit), hardware ou VM
(RAM atribuída), passos para reproduzir e, se possível, saída de
`free -m`, `inxi -Fxz` ou logs relevantes.
