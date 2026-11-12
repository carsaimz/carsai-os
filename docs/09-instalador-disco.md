# 09 — Instalador de disco (Calamares)

> [English](09-instalador-disco.en.md) | **Português**

> A ISO é *live*, mas o Carsai OS é um sistema para instalar. Este capítulo
> documenta o instalador de disco: o que está configurado, como é executado
> e os limites deliberados da v0.1.x.

## 9.1 Escolha da ferramenta

**Calamares** (pacote `calamares` do Debian bookworm, 3.2.61). Critérios:

- é o instalador padrão de distros derivadas (KDE neon, Manjaro, Debian live
  não-oficiais) — maduro, modular e configurável por YAML;
- roda a partir da sessão live, copiando o squashfs para o disco — o alvo
  instalado é **byte-a-byte o sistema live já validado** (temas, Wine,
  statusbar, atalhos);
- segue o princípio anti-overengineering (cap. 06): nada de instalador
  caseiro, nada de reescrever o que o Debian já resolve.

O pacote `calamares-settings-debian` **não** é instalado (traria branding e
módulos custom do Debian). A sequência usa apenas módulos padrão do pacote
`calamares`, com configuração própria em
`build/live/config/includes.chroot/etc/calamares/`.

## 9.2 Como o utilizador instala

1. Arrancar a ISO (live) — entra no XFCE com Carsai Neon;
2. Abrir **"Instalar o Carsai OS"** (menu Whisker → Sistema) — o lançador
   `carsai-installer.desktop` executa `pkexec calamares`
   (`policykit-1-gnome` fornece o agente de autenticação);
3. Assistente: idioma → teclado → particionamento → utilizador → resumo →
   instalar (o slideshow mostra o logo e o lema do produto);
4. No fim, "Reiniciar agora" (checkbox opcional) e arrancar o sistema
   instalado.

## 9.3 O que a configuração faz

| Ficheiro (`etc/calamares/`) | Papel |
| --- | --- |
| `settings.conf` | Sequência só com módulos padrão; branding `carsai` |
| `modules/welcome.conf` | Exige **6 GiB** de disco e **2 GiB** de RAM (metas do cap. 02); verifica root |
| `modules/unpackfs.conf` | Copia `/run/live/medium/live/filesystem.squashfs` → alvo |
| `modules/partition.conf` | EFI 512 MiB recomendado; ext4 por omissão; sem LUKS automático |
| `modules/fstab.conf` | `noatime` + `discard` em SSD (herdado do settings Debian) |
| `modules/users.conf` | Utilizador em `sudo`, `netdev`, `plugdev`, etc.; sem password de root |
| `modules/displaymanager.conf` | Configura o **LightDM** no sistema instalado |
| `modules/bootloader.conf` | GRUB2 (BIOS + EFI), `efiBootLoader: "grub"`, sem fallback i386 |
| `modules/finished.conf` | Reinício opcional no fim |
| `branding/carsai/branding.desc` | Identidade: logo, cores do sidebar, URLs do projecto |
| `branding/carsai/show.qml` | Slideshow mínimo (logo + texto neon) |

Pacotes acrescentados à ISO (ver
`build/live/config/package-lists/calamares.list.chroot`): `calamares`,
`policykit-1` + `policykit-1-gnome` (pkexec + agente), `sudo`, `rsync`
(necessário ao `unpackfs`), `dosfstools` (partição EFI), `os-prober`
(detecta Windows existente no GRUB), `grub-efi-amd64-bin` e `grub-pc-bin`
(instalar nos dois modos de boot).

## 9.4 Limites deliberados (v0.1.x)

- **Sem LUKS/LVM/btrfs** na criação de partições: o alvo é ext4 simples;
  particionamento manual continua possível (o módulo `partition` aceita
  tabelas existentes);
- **Secure Boot**: o GRUB instalado não é *signed* (não há `shim-signed`);
  desactivar Secure Boot na máquina alvo. Está no roteiro para 0.2.x;
- **Sem dual-boot assistido**: o `os-prober` detecta outros SOs no GRUB, mas
  o assistente não redimensiona Windows — o utilizador usa "Manual";
- A versão mostrada no branding é fixa (`branding.desc`) — actualizar junto
  com cada tag.

## 9.5 Como testar (matriz mínima)

1. **VM BIOS** (VirtualBox/QEMU, disco 16 GB): instalar tudo automático,
   reiniciar, confirmar GRUB → LightDM → sessão Carsai;
2. **VM UEFI** (QEMU com OVMF): mesma validação + verificar `/boot/efi`;
3. **Medir idle** no sistema instalado com `free -m` (método do cap. 02,
   meta ≤ 800 MB) e anexar o relatório do `carsai-doctor` ao issue;
4. Falha de qualquer passo → issue com o `/var/log/installation.log`
   (Calamares regista em `/root/.cache/calamares/` na sessão live).
