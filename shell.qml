// shell.qml — QuickShell entry point
// Loads all top-level modules: Bar, OSD, Notifications, ControlCenter

import Quickshell
import "modules/Bar"
import "modules/OSD"
import "modules/Notifications"
import "modules/ControlCenter"

ShellRoot {
    // ─── Control Center (declared first — Bar references it) ─
    ControlCenter { id: controlCenter }

    // ─── Bar ───────────────────────────────────────────────
    Bar { ccPanel: controlCenter }

    // ─── On-Screen Display ─────────────────────────────────
    OSD {}

    // ─── Notification Center ───────────────────────────────
    NotificationCenter {}
}
