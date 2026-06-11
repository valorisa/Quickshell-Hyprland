# 🐚 QuickShell + Hyprland Setup

> Une configuration **modulaire, customizable et performante** de QuickShell pour Hyprland.  
> A **modular, customizable, and performant** QuickShell configuration for Hyprland.

![Hyprland](https://img.shields.io/badge/Hyprland-Wayland-blue?logo=wayland)
![QuickShell](https://img.shields.io/badge/QuickShell-v0.2+-purple)
![Qt](https://img.shields.io/badge/Qt-6.x-blue?logo=qt)
![License](https://img.shields.io/badge/License-MIT-green)
![CI](https://github.com/valorisa/quickshell-hyprland/actions/workflows/ci.yml/badge.svg)

---

<!-- FR -->

## 🇫🇷 Français

### ✨ Fonctionnalités

| Fonctionnalité | Description |
| --- | --- |
| 🎨 **Thème dynamique** | Intégration `pywal` pour palette basée sur le wallpaper |
| 🧩 **Modulaire** | Composants isolés et réutilisables |
| 🔔 **Notifications** | Toasts DBus avec auto-dismiss |
| ⌨️ **OSD** | Affichage volume & luminosité on-screen |
| 📊 **Stats système** | CPU, RAM, batterie en temps réel |
| ✨ **Animations** | Transitions hardware-accelerated |

### 🛠️ Prérequis

#### Arch Linux

```bash
yay -S quickshell qt6-base qt6-declarative qt6-wayland hyprland \
        python-pywal pipewire wireplumber networkmanager \
        bluez bluez-utils upower grim slurp playerctl
```

#### Ubuntu / Debian

Voir [`docs/INSTALLATION.md`](docs/INSTALLATION.md)

### 🚀 Installation FR

```bash
# 1. Cloner dans ~/.config/quickshell
git clone https://github.com/valorisa/quickshell-hyprland.git \
    ~/.config/quickshell

# 2. Lancer le setup automatique
cd ~/.config/quickshell
chmod +x scripts/setup.sh
./scripts/setup.sh

# 3. Générer la palette depuis votre wallpaper
wal -i /chemin/vers/wallpaper.jpg

# 4. Démarrer QuickShell
quickshell
```

### 🔧 Personnalisation

**Couleurs** — `config/Colors.qml`

```qml
readonly property color colBg:     "#282c38"
readonly property color colAccent: "#8aadf4"
```

**Hauteur de barre** — `config/Sizes.qml`

```qml
readonly property int barHeight: 40
```

### 📂 Structure du projet

```text
~/.config/quickshell/
├── assets/           # Icons, shaders, ressources
├── components/       # Éléments UI réutilisables
├── config/           # Couleurs, tailles, comportement
├── modules/          # Widgets (Bar, OSD, Notifications)
├── services/         # Logique backend (Hyprland IPC)
├── scripts/          # Setup, reload, wal-gen, backup
└── shell.qml         # Point d'entrée
```

### 🐛 Dépannage

| Problème | Solution |
| --- | --- |
| Couleurs manquantes | Lancer `wal -i /chemin/wallpaper` |
| Animations saccadées | Vérifier `hyprland-layer-config.conf` sourcé |
| Audio absent | Vérifier `pipewire` + `wireplumber` actifs |
| WiFi non affiché | Vérifier `networkmanager` actif |

---

<!-- EN -->

## 🇬🇧 English

### ✨ Features

| Feature | Description |
| --- | --- |
| 🎨 **Dynamic theming** | `pywal` integration for wallpaper-based color schemes |
| 🧩 **Modular** | Isolated, reusable QML components |
| 🔔 **Notifications** | DBus notification toasts with auto-dismiss |
| ⌨️ **OSD** | Volume & brightness on-screen display |
| 📊 **System stats** | Real-time CPU, RAM, battery |
| ✨ **Animations** | Hardware-accelerated transitions |

### 🛠️ Prerequisites

#### Arch Linux (EN)

```bash
yay -S quickshell qt6-base qt6-declarative qt6-wayland hyprland \
        python-pywal pipewire wireplumber networkmanager \
        bluez bluez-utils upower grim slurp playerctl
```

#### Ubuntu / Debian (EN)

See [`docs/INSTALLATION.md`](docs/INSTALLATION.md)

### 🚀 Installation EN

```bash
# 1. Clone into ~/.config/quickshell
git clone https://github.com/valorisa/quickshell-hyprland.git \
    ~/.config/quickshell

# 2. Run automated setup
cd ~/.config/quickshell
chmod +x scripts/setup.sh
./scripts/setup.sh

# 3. Generate palette from your wallpaper
wal -i /path/to/wallpaper.jpg

# 4. Start QuickShell
quickshell
```

### 🔧 Customization

**Colors** — `config/Colors.qml`

```qml
readonly property color colBg:     "#282c38"
readonly property color colAccent: "#8aadf4"
```

**Bar height** — `config/Sizes.qml`

```qml
readonly property int barHeight: 40
```

### 📂 Project structure

```text
~/.config/quickshell/
├── assets/           # Icons, shaders, resources
├── components/       # Reusable UI elements
├── config/           # Colors, sizes, behavior
├── modules/          # Widgets (Bar, OSD, Notifications)
├── services/         # Backend logic (Hyprland IPC)
├── scripts/          # Setup, reload, wal-gen, backup
└── shell.qml         # Entry point
```

### 🐛 Troubleshooting

| Problem | Solution |
| --- | --- |
| Missing colors | Run `wal -i /path/to/wallpaper` |
| Jerky animations | Verify `hyprland-layer-config.conf` is sourced |
| No audio widget | Check `pipewire` + `wireplumber` running |
| WiFi not showing | Check `networkmanager` running |

---

## 🗺️ Roadmap

- [x] Bar — Workspaces, Clock, SystemStats
- [x] OSD — Volume & Brightness
- [x] Notifications — DBus toasts
- [ ] ControlCenter — WiFi, Bluetooth, audio, brightness
- [ ] MediaControl — MPRIS (Spotify, mpv)
- [ ] pywal dynamic color reload
- [ ] Custom shaders

## 📄 License

MIT — see [LICENSE](LICENSE)

## 🤝 Contributing

Issues and PRs welcome. See [docs/INSTALLATION.md](docs/INSTALLATION.md) for dev setup.

---

**Author**: [valorisa](https://github.com/valorisa)
