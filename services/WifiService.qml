// services/WifiService.qml — WiFi enable/disable via nmcli
// Singleton consumed by CCToggle

pragma Singleton
import Quickshell
import QtQuick

QtObject {
    id: root

    property bool enabled: false

    function toggle() {
        enabled = !enabled
        Process {
            command: ["nmcli", "radio", "wifi", root.enabled ? "on" : "off"]
            running: true
        }
    }

    // ─── Poll every 5 s ──────────────────────────────────────
    Timer {
        interval: 5000
        repeat:   true
        running:  true
        onTriggered: wifiProc.start()
    }

    Process {
        id: wifiProc
        command: ["nmcli", "radio", "wifi"]
        running: true
        onExited: root.enabled = (stdout.trim() === "enabled")
    }
}
