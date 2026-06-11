// modules/ControlCenter/ControlCenter.qml
// Main control center panel — toggled from the Bar
// Contains: WiFi, Bluetooth, DND toggles + Audio + Brightness sliders

import Quickshell
import QtQuick
import QtQuick.Layouts
import "../../config"
import "."

PanelWindow {
    id: root

    // ─── Visibility & toggle ────────────────────────────────
    property bool open: false

    function toggle() { open = !open }

    visible: open || slideAnim.running

    // ─── Layer Shell positioning (top-right) ────────────────
    anchors { top: true; right: true }
    topMargin:   Sizes.barHeight + 8
    rightMargin: 8

    width:  320
    height: contentCol.implicitHeight + Sizes.padding * 2

    color: "transparent"

    // ─── Slide-down animation ────────────────────────────────
    transform: Translate { id: slideAnim; y: open ? 0 : -(root.height + 16) }

    Behavior on open {
        // drive the Translate via a NumberAnimation on y
    }

    NumberAnimation {
        id: slideAnim
        target: slideAnim
        property: "y"
        to:       root.open ? 0 : -(root.height + 16)
        duration: Sizes.animSlow
        easing.type: Easing.OutCubic
        running: true
    }

    // ─── Panel background ────────────────────────────────────
    Rectangle {
        anchors.fill: parent
        radius: Sizes.radius
        color:  Colors.colBg
        border.color: Colors.colBorder
        border.width: 1

        // ─── Content layout ──────────────────────────────────
        ColumnLayout {
            id: contentCol
            anchors {
                top:    parent.top
                left:   parent.left
                right:  parent.right
                margins: Sizes.padding
            }
            spacing: Sizes.padding

            // ── Header ──────────────────────────────────────
            Text {
                text:  "Control Center"
                color: Colors.colFg
                font.pixelSize: Sizes.fontLg
                font.bold: true
                Layout.fillWidth: true
            }

            // ── Toggle row ──────────────────────────────────
            RowLayout {
                Layout.fillWidth: true
                spacing: 8

                CCToggle {
                    id: wifiToggle
                    icon:    "󰤨"
                    label:   "Wi-Fi"
                    activeColor: Colors.colBlue
                    onClicked: WifiService.toggle()
                    active: WifiService.enabled
                }

                CCToggle {
                    id: btToggle
                    icon:    "󰂯"
                    label:   "BT"
                    activeColor: Colors.colBlue
                    onClicked: BluetoothService.toggle()
                    active: BluetoothService.enabled
                }

                CCToggle {
                    id: dndToggle
                    icon:    "󰂛"
                    label:   "DND"
                    activeColor: Colors.colYellow
                    onClicked: dndToggle.active = !dndToggle.active
                }

                CCToggle {
                    id: nightToggle
                    icon:    "󰌵"
                    label:   "Night"
                    activeColor: Colors.colYellow
                    onClicked: NightService.toggle()
                    active: NightService.enabled
                }
            }

            // ── Divider ─────────────────────────────────────
            Rectangle {
                Layout.fillWidth: true
                height: 1
                color:  Colors.colBorder
            }

            // ── Audio slider ─────────────────────────────────
            CCSlider {
                Layout.fillWidth: true
                icon:     AudioService.muted ? "󰖁" : "󰕾"
                label:    "Volume"
                value:    AudioService.volume
                iconColor: Colors.colAccent
                onMoved:  (v) => AudioService.setVolume(v)
                onIconClicked: AudioService.toggleMute()
            }

            // ── Brightness slider ────────────────────────────
            CCSlider {
                Layout.fillWidth: true
                icon:     "󰃠"
                label:    "Brightness"
                value:    BrightnessService.brightness
                iconColor: Colors.colYellow
                onMoved:  (v) => BrightnessService.setBrightness(v)
            }

            // ── Divider ─────────────────────────────────────
            Rectangle {
                Layout.fillWidth: true
                height: 1
                color:  Colors.colBorder
            }

            // ── Network info ─────────────────────────────────
            CCNetworkInfo {}

            // ── Bottom actions ───────────────────────────────
            RowLayout {
                Layout.fillWidth: true
                spacing: 8

                CCActionButton {
                    icon:  "󰐥"
                    label: "Power off"
                    onClicked: Qt.createQmlObject(
                        'import Quickshell; Process { command: ["systemctl","poweroff"]; running: true }',
                        root)
                }
                CCActionButton {
                    icon:  "󰜉"
                    label: "Reboot"
                    onClicked: Qt.createQmlObject(
                        'import Quickshell; Process { command: ["systemctl","reboot"]; running: true }',
                        root)
                }
                CCActionButton {
                    icon:  "󰍃"
                    label: "Logout"
                    onClicked: Qt.createQmlObject(
                        'import Quickshell; Process { command: ["hyprctl","dispatch","exit",""]; running: true }',
                        root)
                }
            }
        }
    }

    // ─── Close on click-outside ──────────────────────────────
    // Handled by Bar toggle button; ESC also closes
    Keys.onEscapePressed: root.open = false
}
