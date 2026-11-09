import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import qs
import qs.modules.common

Scope {
    id: root

    property var focusedScreen: Quickshell.screens.find(s => s.name === Hyprland.focusedMonitor?.name)

    Loader {
        active: GlobalStates.sessionConfirmAction.length > 0 && !GlobalStates.screenLocked
        sourceComponent: PanelWindow {
            screen: root.focusedScreen ?? Quickshell.screens[0]
            exclusionMode: ExclusionMode.Ignore
            WlrLayershell.namespace: "quickshell:sessionConfirm"
            WlrLayershell.layer: WlrLayer.Overlay
            WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
            color: "transparent"

            anchors {
                top: true
                left: true
                right: true
                bottom: true
            }

            SessionConfirmDialog {
                anchors.fill: parent
            }
        }
    }
}
