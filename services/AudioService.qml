// services/AudioService.qml — PipeWire volume & mute via pactl
// Singleton consumed by CCSlider and OSD

pragma Singleton
import Quickshell
import QtQuick

QtObject {
    id: root

    // ─── State ──────────────────────────────────────────────
    property real volume: 50
    property bool muted:  false

    // ─── Public API ─────────────────────────────────────────
    function setVolume(v) {
        var clamped = Math.max(0, Math.min(v, 100))
        volume = clamped
        Process {
            command: ["pactl", "set-sink-volume", "@DEFAULT_SINK@",
                      Math.round(clamped) + "%"]
            running: true
        }
    }

    function toggleMute() {
        muted = !muted
        Process {
            command: ["pactl", "set-sink-mute", "@DEFAULT_SINK@", "toggle"]
            running: true
        }
    }

    // ─── Poll current volume every 2 s ───────────────────────
    Timer {
        interval: 2000
        repeat:   true
        running:  true
        onTriggered: volProc.start()
    }

    Process {
        id: volProc
        command: ["bash", "-c",
            "pactl get-sink-volume @DEFAULT_SINK@ | " +
            "awk '/Volume:/{gsub(/%/,\"\"); print $5; exit}'"]
        running: true
        onExited: {
            var v = parseFloat(stdout.trim())
            if (!isNaN(v)) root.volume = v
        }
    }

    Process {
        id: muteProc
        command: ["bash", "-c",
            "pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}'"]
        running: true
        onExited: root.muted = (stdout.trim() === "yes")
        Timer { interval: 2000; repeat: true; running: true; onTriggered: muteProc.start() }
    }
}
