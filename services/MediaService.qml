// services/MediaService.qml — MPRIS media player control via playerctl
// Singleton consumed by modules/Bar/MediaControl.qml
//
// playerctl talks to any MPRIS-compatible player (Spotify, mpv, VLC,
// Firefox, Chromium…) over DBus. We poll its status every second and
// expose simple properties + control functions.

pragma Singleton
import Quickshell
import QtQuick

QtObject {
    id: root

    // ─── State ──────────────────────────────────────────────
    property bool   available: false   // true if any MPRIS player is found
    property string status:    ""      // "Playing" | "Paused" | "Stopped"
    property string title:     ""
    property string artist:    ""
    property string playerName: ""     // e.g. "spotify", "mpv"

    readonly property bool playing: status === "Playing"

    // ─── Public API — controls ───────────────────────────────
    function playPause() {
        Process { command: ["playerctl", "play-pause"]; running: true }
    }

    function next() {
        Process { command: ["playerctl", "next"]; running: true }
    }

    function previous() {
        Process { command: ["playerctl", "previous"]; running: true }
    }

    // ─── Poll every 1 s ───────────────────────────────────────
    Timer {
        interval: 1000
        repeat:   true
        running:  true
        triggeredOnStart: true
        onTriggered: metaProc.start()
    }

    // Single call retrieves status, title, artist and player name,
    // separated by a unit separator (\x1f) to avoid ambiguity with
    // metadata that may itself contain pipes or colons.
    Process {
        id: metaProc
        command: ["bash", "-c",
            "playerctl metadata --format " +
            "'{{status}}\\u001f{{title}}\\u001f{{artist}}\\u001f{{playerName}}' " +
            "2>/dev/null"]
        running: true

        onExited: {
            var out = stdout.trim()

            if (out === "") {
                root.available = false
                root.status    = ""
                root.title     = ""
                root.artist    = ""
                root.playerName = ""
                return
            }

            var parts = out.split("\u001f")
            root.available  = true
            root.status     = parts[0] || ""
            root.title      = parts[1] || ""
            root.artist     = parts[2] || ""
            root.playerName = parts[3] || ""
        }
    }
}
