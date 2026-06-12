# Changelog

All notable changes to this project will be documented here.

Format: [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)  
Versioning: [Semantic Versioning](https://semver.org/)

---

## [Unreleased]

### Planned

- pywal dynamic color integration
- Custom shaders for blur/glow effects

---

## [0.3.0] — 2026-06-12

### Added

- `services/MediaService.qml` — MPRIS media control singleton via `playerctl`
  (status, title, artist, player name; play/pause/next/previous)
- `services/qmldir` — registered `MediaService` singleton
- `modules/Bar/MediaControl.qml` — MPRIS widget (track info + transport controls),
  fully collapses to zero width when no player is active
- `modules/Bar/MCButton.qml` — reusable circular icon button (prev/play-pause/next)
- `modules/Bar/Bar.qml` — wired `MediaControl` between Workspaces and Clock
- README — new "MediaControl" walkthrough sections (FR/EN), updated architecture
  diagrams, dependency tables, and roadmap

---

## [0.2.0] — 2026-06-11

### Added

- `modules/ControlCenter/ControlCenter.qml` — slide-down panel (top-right)
- `modules/ControlCenter/CCToggle.qml` — pill toggle (WiFi, Bluetooth, DND, Night)
- `modules/ControlCenter/CCSlider.qml` — draggable slider (audio, brightness)
- `modules/ControlCenter/CCNetworkInfo.qml` — SSID + local IP display
- `modules/ControlCenter/CCActionButton.qml` — power/reboot/logout actions
- `services/AudioService.qml` — PipeWire volume & mute singleton
- `services/BrightnessService.qml` — backlight control via brightnessctl
- `services/WifiService.qml` — NetworkManager wifi toggle singleton
- `services/BluetoothService.qml` — bluetoothctl power toggle singleton
- `services/NightService.qml` — hyprsunset night mode singleton
- `services/qmldir` — singleton registration for all services
- Bar toggle button to open/close ControlCenter
- `shell.qml` updated to wire ControlCenter ↔ Bar

---

## [0.1.0] — 2026-06-10

### Added

- Initial repository structure
- `shell.qml` — entry point (Bar, OSD, Notifications)
- `modules/Bar` — status bar with Workspaces, Clock, SystemStats
- `modules/OSD` — volume & brightness on-screen display
- `modules/Notifications` — DBus notification toasts
- `config/Colors.qml` — centralized color palette (Catppuccin Macchiato defaults)
- `config/Sizes.qml` — dimensions, spacing, animation durations
- `scripts/setup.sh` — automated install for Arch & Debian
- `scripts/reload.sh` — IPC-first QuickShell reload
- `scripts/wal-gen.sh` — pywal color generation helper
- `scripts/backup.sh` — config backup utility
- `hyprland-layer-config.conf` — layer rules & blur config
- GitHub Actions CI (ShellCheck, markdownlint, qmllint)
- Bilingual README (EN/FR)
