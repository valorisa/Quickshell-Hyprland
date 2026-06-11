// services/BluetoothService.qml — Bluetooth power via bluetoothctl
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
            command: ["bluetoothctl", "power", root.enabled ? "on" : "off"]
            running: true
        }
    }

    // ─── Poll every 5 s ──────────────────────────────────────
    Timer {
        interval: 5000
        repeat:   true
        running:  true
        onTriggered: btProc.start()
    }

    Process {
        id: btProc
        command: ["bash", "-c",
            "bluetoothctl show | awk '/Powered:/{print $2}'"]
        running: true
        onExited: root.enabled = (stdout.trim() === "yes")
    }
}
