// config/Colors.qml — Centralized color palette, with live pywal reload
//
// All properties below start with the static Catppuccin Macchiato palette
// (the "fallback" values). If `~/.cache/wal/colors.json` exists, it is
// read on startup and re-applied automatically whenever it changes
// (detected via mtime polling every 2s) — no QuickShell restart needed.
//
// Generate/refresh the palette with:
//   wal -i /path/to/wallpaper.jpg
//   (or: ./scripts/wal-gen.sh /path/to/wallpaper.jpg)
//
// To go back to the static fallback palette, remove or rename
// ~/.cache/wal/colors.json and wait ~2s.

pragma Singleton
import Quickshell
import QtQuick

QtObject {
    id: root

    // ─── Base ───────────────────────────────────────────────
    property color colBg:      "#282c38"   // Background
    property color colBgAlt:   "#1e2030"   // Darker bg (bars, inputs)
    property color colSurface: "#363a4f"   // Card / widget surface
    property color colBorder:  "#494d64"   // Borders

    // ─── Foreground ─────────────────────────────────────────
    property color colFg:      "#cad3f5"   // Primary text
    property color colFgMuted: "#8087a2"   // Subdued text

    // ─── Accent ─────────────────────────────────────────────
    property color colAccent:  "#8aadf4"   // Primary accent (blue)
    property color colBlue:    "#8aadf4"
    property color colGreen:   "#a6da95"
    property color colYellow:  "#eed49f"
    property color colRed:     "#ed8796"
    property color colError:   "#5b3344"   // Critical notif bg

    // ─── Opacity helpers ────────────────────────────────────
    function withAlpha(c, a) { return Qt.rgba(c.r, c.g, c.b, a) }

    // ─── pywal dynamic reload ──────────────────────────────────
    // true once a pywal palette has been successfully applied
    property bool walActive: false

    // last seen mtime of colors.json, used for change detection
    property string _lastMtime: ""

    function _applyWalPalette(json) {
        try {
            var p = JSON.parse(json)
            var c = p.colors
            var s = p.special

            colBg      = s.background
            colFg      = s.foreground
            colBgAlt   = c.color0
            colSurface = c.color8
            colBorder  = c.color7
            colFgMuted = c.color7
            colAccent  = c.color12
            colBlue    = c.color4
            colGreen   = c.color2
            colYellow  = c.color3
            colRed     = c.color1
            colError   = c.color1

            walActive = true
        } catch (e) {
            console.warn("Colors: failed to parse pywal colors.json — " + e)
        }
    }

    function _resetToStatic() {
        colBg      = "#282c38"
        colBgAlt   = "#1e2030"
        colSurface = "#363a4f"
        colBorder  = "#494d64"
        colFg      = "#cad3f5"
        colFgMuted = "#8087a2"
        colAccent  = "#8aadf4"
        colBlue    = "#8aadf4"
        colGreen   = "#a6da95"
        colYellow  = "#eed49f"
        colRed     = "#ed8796"
        colError   = "#5b3344"
        walActive  = false
    }

    // ─── Poll colors.json mtime every 2 s ──────────────────────
    Timer {
        interval: 2000
        repeat:   true
        running:  true
        triggeredOnStart: true
        onTriggered: mtimeProc.start()
    }

    Process {
        id: mtimeProc
        command: ["bash", "-c",
            "f=\"$HOME/.cache/wal/colors.json\"; " +
            "if [ -f \"$f\" ]; then stat -c %Y \"$f\"; else echo ''; fi"]
        running: true
        onExited: {
            var m = stdout.trim()

            if (m === "") {
                if (root.walActive) root._resetToStatic()
                return
            }

            if (m !== root._lastMtime) {
                root._lastMtime = m
                readProc.start()
            }
        }
    }

    Process {
        id: readProc
        command: ["bash", "-c", "cat \"$HOME/.cache/wal/colors.json\""]
        running: false
        onExited: root._applyWalPalette(stdout)
    }
}
