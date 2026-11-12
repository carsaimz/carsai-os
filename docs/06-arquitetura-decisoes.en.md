# 06 — Architecture Decisions (what NOT to do)
> **English** | [Português](06-arquitetura-decisoes.md)

Just as important as what we build is what we **refuse to build**. This
chapter lists the project's anti-overengineering decisions, each with its
technical justification. If a PR proposes reverting one of these decisions,
it needs new data (benchmarks, upstream changes) to do so.

## 6.1 Do not create a custom package manager

**Decision**: use Debian's `apt`. Repackaging or building our own system is
unnecessary and risky effort.

- apt has 25+ years of maturity, battle-tested dependency resolution,
  repositories with thousands of packages and continuous security updates.
- A custom manager would duplicate the work and create an entire class of
  bugs that Debian has already solved.
- Carsai customization stays in the **configuration layer** (what gets
  installed, how it is tuned), not in the tool.

## 6.2 Do not build a custom kernel from scratch

**Decision**: use the Debian generic kernel (`linux-image-amd64`).

- The Debian kernel is already optimized enough and **receives security
  updates automatically** — a custom kernel would force the team to track
  CVEs and rebuild manually, forever.
- Fine tuning (preemption, timer frequency) can be done via **boot
  parameters**, if needed — no fork.
- Negative cost/benefit: the RAM/speed gain of a hand-tuned kernel is
  marginal compared to the maintenance risk.

## 6.3 Do not emulate Android via a full virtual machine

**Decision**: Waydroid (LXC container) instead of Android emulators/VMs.

- An Android VM carries a full Android kernel + init + daemons: hundreds of
  extra MB at idle, incompatible with the lightweight goal.
- Waydroid shares the host kernel (LXC): near-native performance and much
  lower consumption.
- Details in chapter 05.

## 6.4 Do not implement native .exe support

**Decision**: Wine/Proton as the compatibility layer; no rewriting of
Windows APIs.

- Rewriting the Windows APIs is infeasible for a project of this size (Wine
  has existed since 1993 precisely because this is a gigantic problem).
- Wine is established, active and lightweight (call translation, no
  emulation).
- The Carsai effort focuses on **pre-configuration** (prefix, winetricks,
  Bottles) and **documenting limitations**, not on reinvention.

## 6.5 Cross-cutting principle

Every new component must answer one question:

> "Does this improve the end user's experience more than it increases the
> team's maintenance surface?"

If the answer is not an obvious "yes" backed by data, the answer is **no**.

## 6.6 Summary table

| Temptation | Decision | Alternative adopted |
| --- | --- | --- |
| Custom package manager | ❌ Rejected | Debian's apt |
| Kernel built from scratch | ❌ Rejected | Debian kernel + boot parameters |
| Android in a full VM | ❌ Rejected | Waydroid (LXC container) |
| Native .exe support | ❌ Rejected | Wine/Proton + Bottles/Lutris |
| Heavy 3D compositor by default | ❌ Rejected | XFCE without effects; static wallpaper |
| Giant icon theme (300+ MB) | ❌ Rejected | Adwaita for now; lean custom theme in Phase 2 |
