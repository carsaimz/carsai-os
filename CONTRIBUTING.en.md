# Contributing to Carsai OS
> **English** | [Português](CONTRIBUTING.md)

Thanks for your interest in contributing! This document defines the basic
rules for keeping the project cohesive.

## Code of conduct

Be respectful. We are building something public and open to the world.
Technical criticism is welcome; personal attacks are not.

## Repository areas

| Area | What it is | Special care |
| --- | --- | --- |
| `docs/` | Technical documentation (in Portuguese) | Keep it consistent with the actual code |
| `build/live/` | live-build configuration for the ISO | Do not commit generated outputs (`.build/`, `chroot/`, `*.iso`) |
| `themes/` | GTK themes, terminal color schemes, selector | One theme = one folder; never break the `Carsai-*` names |
| `branding/` | Logo and wallpapers | The official icon will be replaced; do not rename files without notice |
| `scripts/` | Automation (build, installation) | Test locally before the PR |

## Commit convention

We use [Conventional Commits](https://www.conventionalcommits.org/pt-br/):

```
<tipo>(<escopo opcional>): <resumo em minúsculas>

exemplos:
docs(temas): adicionar esquema de cores do Tilix
build: reduzir lista de pacotes para cortar RAM em idle
themes: corrigir contraste do headerbar no Carsai Neon
ci: aumentar tempo limite do build da ISO
```

Types: `feat`, `fix`, `docs`, `build`, `themes`, `ci`, `chore`, `refactor`, `test`.

## Security (very important)

- **Never** commit tokens, API keys, passwords or `.env` files.
- The `.gitignore` already blocks common patterns (`*.pem`, `*.key`, `.env`,
  `*token*`), but do not rely on it alone: review your `git diff --staged`
  before committing.
- If you accidentally expose a credential, revoke it **immediately** on
  GitHub before anything else.

## How to test locally

### Building the ISO

```bash
sudo apt-get install -y live-build debootstrap squashfs-tools xorriso
./scripts/build-iso.sh
```

The ISO appears in `build/live/*.iso` (it can take 30–60 minutes the first
time).

### Testing in a VM (2 GB and 4 GB of RAM)

```bash
qemu-system-x86_64 -m 2048 -enable-kvm -cdrom build/live/carsai-os-*.iso
```

Always test with **2 GB** and **4 GB** before proposing changes that touch
the package list or the services. Measure idle with:

```bash
free -m   # depois de 5 minutos de sessão parada
```

### Testing the themes without building the ISO

```bash
./scripts/install-themes.sh user   # instala em ~/.themes (sem root)
carsai-theme-selector              # menu interativo (se instalado em ~/.local/bin)
```

## Code style

- Shell: `bash` with `set -euo pipefail`, compatible with `shellcheck` (the
  CI runs it).
- Markdown: lines up to ~100 characters; hierarchical headings
  (`#`, `##`, `###`).
- Documentation in Portuguese; code, comments and commits in English.

## Reporting bugs

Open an *issue* with: the version/build used (ISO or commit), hardware or VM
(assigned RAM), steps to reproduce and, if possible, the output of
**`carsai-doctor`** (ready-made report: idle RAM, zram, services, themes) or,
alternatively, `free -m` / `inxi -Fxz` / relevant logs.
