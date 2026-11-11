# Changelog — Carsai OS

All notable changes to this project are documented here.
Format based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versioning uses [SemVer](https://semver.org/) with `-alpha` / `-beta` suffixes during the early phases.

## [Unreleased]

### Added
- Project scaffold: bilingual README (EN/PT), MIT license, contributing guide.
- Technical documentation in Portuguese (`docs/01`–`docs/07`).
- live-build configuration targeting Debian 12 (bookworm), amd64, XFCE:
  custom package list (`carsai-os.list.chroot`), service-trim hook,
  sysctl/zram tuning, LightDM greeter branding, first-run theme autostart.
- Theme layer with four GTK3 themes: `Carsai-Neon` (default),
  `Carsai-Dark-Minimal`, `Carsai-Retrowave`, `Carsai-Light-Tech`.
- Terminal colour schemes for xfce4-terminal and Tilix (one per theme).
- `carsai-theme-selector` CLI (applies GTK theme, wallpaper and terminal
  palette; `--first-run` mode for the live/install default).
- Branding: AI-generated wallpapers (one per theme) + placeholder SVG icon
  (to be replaced by official artwork).
- CI: GitHub Actions workflow that builds the ISO on every push touching
  build/themes/branding (plus shellcheck lint).

## [0.1.0-alpha] - 2026-11-12

### Added
- Initial public repository `carsaimz/carsai-os`.

[Unreleased]: https://github.com/carsaimz/carsai-os/compare/v0.1.0-alpha...HEAD
[0.1.0-alpha]: https://github.com/carsaimz/carsai-os/releases/tag/v0.1.0-alpha
