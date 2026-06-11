// modules/ControlCenter/CCNetworkInfo.qml
// Shows current SSID (or "Disconnected") and local IP address

import Quickshell
import QtQuick
import QtQuick.Layouts
import "../../config"

RowLayout {
    id: root
    spacing: 8

    // ─── SSID ───────────────────────────────────────────────
    RowLayout {
        spacing: 4
        Layout.fillWidth: true

        Text {
            text:  "󰤨"
            color: ssidProc.stdout.trim() !== "" ? Colors.colBlue : Colors.colFgMuted
            font.pixelSize: Sizes.fontMd
        }

        Text {
            text: {
                var s = ssidProc.stdout.trim()
                return s !== "" ? s : "Disconnected"
            }
            color: Colors.colFg
            font.pixelSize: Sizes.fontSm
            elide: Text.ElideRight
            Layout.fillWidth: true
        }
    }

    // ─── Local IP ───────────────────────────────────────────
    RowLayout {
        spacing: 4

        Text {
            text:  "󰩟"
            color: Colors.colFgMuted
            font.pixelSize: Sizes.fontMd
        }

        Text {
            text: {
                var ip = ipProc.stdout.trim()
                return ip !== "" ? ip : "—"
            }
            color: Colors.colFgMuted
            font.pixelSize: Sizes.fontSm
        }
    }

    // ─── Processes ─────────────────────────────────────────
    Process {
        id: ssidProc
        command: ["bash", "-c",
            "nmcli -t -f active,ssid dev wifi 2>/dev/null | grep '^yes' | cut -d: -f2 | head -1"]
        running: true
        Timer { interval: 10000; repeat: true; running: true; onTriggered: ssidProc.start() }
    }

    Process {
        id: ipProc
        command: ["bash", "-c",
            "ip -4 addr show $(ip route | awk '/default/{print $5;exit}') " +
            "2>/dev/null | awk '/inet /{print $2}' | cut -d/ -f1 | head -1"]
        running: true
        Timer { interval: 15000; repeat: true; running: true; onTriggered: ipProc.start() }
    }
}
