// services/BrightnessService.qml — Backlight control via brightnessctl
// Singleton consumed by CCSlider and OSD

pragma Singleton
import Quickshell
import QtQuick

QtObject {
    id: root

    property real brightness: 100   // 0–100 %

    // ─── Set brightness ──────────────────────────────────────
    function setBrightness(v) {
        var clamped = Math.max(1, Math.min(v, 100))
        brightness  = clamped
        Process {
            command: ["brightnessctl", "set", Math.round(clamped) + "%"]
            running: true
        }
    }

    // ─── Poll every 3 s ──────────────────────────────────────
    Timer {
        interval: 3000
        repeat:   true
        running:  true
        onTriggered: brightProc.start()
    }

    Process {
        id: brightProc
        command: ["bash", "-c",
            "brightnessctl -m | awk -F, '{gsub(/%/,\"\",$4); print $4}'"]
        running: true
        onExited: {
            var v = parseFloat(stdout.trim())
            if (!isNaN(v)) root.brightness = v
        }
    }
}
