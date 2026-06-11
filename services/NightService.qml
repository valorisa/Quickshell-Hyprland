// services/NightService.qml — Night mode via hyprsunset
// Singleton consumed by CCToggle

pragma Singleton
import Quickshell
import QtQuick

QtObject {
    id: root

    property bool enabled: false
    property int  temperature: 3500   // Kelvin

    function toggle() {
        enabled = !enabled
        if (enabled) {
            Process {
                command: ["hyprsunset", "-t", root.temperature.toString()]
                running: true
            }
        } else {
            Process {
                command: ["pkill", "hyprsunset"]
                running: true
            }
        }
    }
}
