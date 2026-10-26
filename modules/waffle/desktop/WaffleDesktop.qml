import QtQuick
import Quickshell
import Quickshell.Wayland

Scope {
    Variants {
        model: Quickshell.screens.length > 0 ? [Quickshell.screens[0]] : []

        delegate: PanelWindow {
            id: window

            required property var modelData

            screen: modelData
            color: "transparent"
            exclusiveZone: 0
            WlrLayershell.namespace: "quickshell:wDesktop"
            WlrLayershell.layer: WlrLayer.Bottom
            WlrLayershell.keyboardFocus: content.renaming ? WlrKeyboardFocus.OnDemand : WlrKeyboardFocus.None

            anchors {
                top: true
                bottom: true
                left: true
                right: true
            }

            DesktopIconsContent {
                id: content
                anchors.fill: parent
            }
        }
    }
}
