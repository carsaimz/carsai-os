# 05 — Android Compatibility (.apk)
> **English** | [Português](05-compatibilidade-android.md)

> Status: **official path defined and automated**. Waydroid does not come
> in the ISO (it requires a kernel with LXC/binder modules and consumes its
> own RAM); instead, an official script installs it on an **installed**
> system.

## 5.0 Official installation (installed system)

```bash
sudo scripts/install-waydroid.sh   # repo oficial + waydroid + weston
carsai-android                     # abre o Android em janela estilo telefone
```

The `install-waydroid.sh` script adds the official Waydroid repository (GPG
key in `/usr/share/keyrings/waydroid.gpg`), installs `waydroid` + `weston`,
enables the container service and runs `waydroid init` (*vanilla* image,
without Google Apps — for the Play Store: `sudo waydroid init -s GAPPS`).

The `carsai-android` launcher solves the XFCE (X11) graphical prerequisite:
it starts a **nested Weston** (720×1280 phone-style window) and opens the
Waydroid UI inside it. In real Wayland sessions, it opens directly.

> The live ISO session does not persist changes; install Carsai OS before
> using Waydroid.

## 5.1 Technology on Linux: Waydroid

**Waydroid** is an **LXC** container that runs a full Android system
**sharing the Linux kernel**, without emulation. The result is:

- near-native performance;
- significantly lower memory consumption than traditional emulators (which
  load an entire Android kernel into a VM).

> Note: Anbox, the conceptual predecessor, is archived; Waydroid is the
> most mature and active solution for Android on Linux.

## 5.2 Critical prerequisite: Wayland

Waydroid depends on **Wayland** for smooth graphical integration. XFCE is
mostly X11, so the official path uses **nested Weston** (a phone-style window
inside X11 — see 5.0). When Wayland support in XFCE/Debian matures (XFCE
4.20+), the nested Weston will no longer be needed and Android windows
become native with no changes to the script.

## 5.3 Desktop integration

Once installed, Android apps appear **in the applications menu as native
windows**, thanks to Waydroid's integration layer — the user does not need
to manage the container manually.

## 5.4 Resource expectation

On a system with 4 GB of RAM, running Waydroid alongside the Linux desktop
is **feasible**, but it requires memory management (Android consumes its own
memory):

| Scenario | Estimated total RAM |
| --- | --- |
| Carsai desktop (idle) | ≤ 800 MB |
| Desktop + Waydroid idle | +700 MB – 1.2 GB |
| Desktop + Waydroid + heavy Android app | 2.5–3.5 GB |

The container can be **stopped** when not in use (there is no idle cost),
which keeps the lightweight target intact.

## 5.5 "Android inside Linux or Windows" — conceptual scenarios

The idea of having Android "inside" the system can be interpreted in two
ways, and the documentation separates them explicitly:

### Scenario A — Carsai OS (Linux) with Android (Waydroid) ✅

This is the scenario described in this chapter: Carsai OS is the Linux host
and Waydroid provides the containerized Android environment. **It is the
official route of the project**, aligned with the philosophy (lightweight +
compatibility), because it does not require a heavy virtual machine.

### Scenario B — Windows hosting Android, managed from Carsai (external) ⚠️

If the goal is "using Android inside Windows" while you are in the Carsai
ecosystem, that is a scenario **outside the scope of the operating system**.
On Windows, the historical solution was **WSA (Windows Subsystem for
Android)**, discontinued by Microsoft; the community maintains
**WSABuilds** (a fork that preserves the Play Store).

Carsai OS **cannot "embed" Android in Windows**, but it can document that
path for users who dual boot or use Windows as the host. It is an
**informational note**, not an OS feature.

### Recommendation

Treat **Waydroid as the official Carsai OS solution for Android**
(Scenario A). The Windows scenario (B) remains only as supporting
documentation.
