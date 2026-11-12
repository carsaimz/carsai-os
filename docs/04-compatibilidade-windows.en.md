# 04 — Windows Compatibility (.exe)
> **English** | [Português](04-compatibilidade-windows.md)

> Status: **in the ISO since the alpha**. Wine (32 + 64 bit) and winetricks
> come pre-installed; this chapter sets the approach and the expectations.

## 4.1 Technology

**Wine** (compatibility layer), included in the ISO:

- `wine` + `wine64` from the package list, and **`wine32:i386`** installed by the
  `0110-wine32-multilib.hook.chroot` hook (multiarch enabled at build time)
  — most Windows programs are 32-bit, so full support comes out of the box;
- **winetricks** + `fonts-wine` + `cabextract` for common DLLs/fonts;
- default `~/.wine` prefix created automatically on first run.

Optional graphical interface: **Bottles or Lutris** can be installed via apt by
the user; the system's default flow is the `carsai-exe` command.

## 4.2 How to use

```bash
carsai-exe ~/Downloads/programa.exe        # via terminal (fluxo hacker)
# ou: duplo clique no .exe no Thunar (associação do Wine)
winetricks corefonts                       # adicionar fontes/DLLs
winecfg                                    # configuração do Wine
```

The first `.exe` you run takes a few extra seconds (creation of the
`~/.wine` prefix).

## 4.3 Realistic expectation

- Wine offers **near-native performance** for many productivity apps and older
  software, **without virtualization overhead** — Wine does not emulate
  hardware, it translates API calls.
- **Not 100% compatible.** These may fail:
  - software with **strict DRM**;
  - games with **kernel-level anti-cheat** (e.g., some recent multiplayer
    titles);
  - applications that depend on specific **proprietary drivers**.

This limitation is inherent to the approach (and shared by the entire industry);
the Carsai OS answer is to **document what works** and not promise what we do
not control.

## 4.4 Hardware requirement

Since Wine does not emulate hardware, the extra RAM/CPU impact is **low** —
compatible with the < 4 GB target. Consumption depends on the Windows app
being run, not on Wine at idle.

| Scenario | Typical additional RAM |
| --- | --- |
| Wine + light productivity app | +200–400 MB |
| Wine + heavy app (office suite) | +500 MB–1 GB |
| Proton + game | variable (depends on the game) |

## 4.5 What Carsai OS will **not** do

- **Will not** rewrite Windows APIs (infeasible — see chapter 06).
- **Will not** include cracks/DRM circumvention tools, ever.
- **Will not** guarantee compatibility per Wine version without real testing.
