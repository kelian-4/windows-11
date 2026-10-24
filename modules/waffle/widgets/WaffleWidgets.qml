import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import qs
import qs.modules.common

Scope {
    id: root

    Connections {
        target: GlobalStates

        function onWidgetsOpenChanged() {
            if (GlobalStates.widgetsOpen)
                panelLoader.active = true;
        }
    }

    Loader {
        id: panelLoader
        active: GlobalStates.widgetsOpen
        sourceComponent: PanelWindow {
            id: panelWindow
            exclusiveZone: 0
            WlrLayershell.namespace: "quickshell:wWidgets"
            WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
            color: "transparent"

            anchors {
                top: true
                bottom: true
                left: true
            }

            implicitWidth: content.implicitWidth
            implicitHeight: content.implicitHeight

            HyprlandFocusGrab {
                active: true
                windows: [panelWindow]
                onCleared: content.close()
            }

            Connections {
                target: GlobalStates

                function onWidgetsOpenChanged() {
                    if (!GlobalStates.widgetsOpen)
                        content.close();
                }
            }

            WidgetsContent {
                id: content
                anchors.fill: parent

                onClosed: {
                    GlobalStates.widgetsOpen = false;
                    panelLoader.active = false;
                }
            }
        }
    }

    function toggleOpen() {
        GlobalStates.widgetsOpen = !GlobalStates.widgetsOpen;
    }

    IpcHandler {
        target: "widgets"

        function toggle() {
            root.toggleOpen();
        }
    }

    GlobalShortcut {
        name: "widgetsToggle"
        description: "Toggles the widgets board on press"

        onPressed: root.toggleOpen()
    }
}
