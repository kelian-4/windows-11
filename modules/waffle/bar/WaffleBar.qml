import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import qs
import qs.services
import qs.modules.common
import qs.modules.common.widgets
import qs.modules.waffle.looks

Scope {
    id: root
    
    LazyLoader {
        id: barLoader
        active: GlobalStates.barOpen
        component: Variants {
            model: Quickshell.screens
            delegate: PanelWindow { // Bar window
                id: barRoot
                required property var modelData
                screen: modelData
                exclusionMode: ExclusionMode.Ignore
                exclusiveZone: Looks.barVertical ? implicitWidth : implicitHeight
                WlrLayershell.namespace: "quickshell:bar"

                anchors {
                    left: Looks.barVertical ? Looks.barSide === "left" : true
                    right: Looks.barVertical ? Looks.barSide === "right" : true
                    top: Looks.barVertical ? true : Looks.barSide === "top"
                    bottom: Looks.barVertical ? true : Looks.barSide === "bottom"
                }

                color: "transparent"
                implicitHeight: content.implicitHeight
                implicitWidth: content.implicitWidth

                WaffleBarContent {
                    id: content
                    anchors.fill: parent
                }
            }
        }
    }

    IpcHandler {
        target: "bar"

        function toggle(): void {
            GlobalStates.barOpen = !GlobalStates.barOpen
        }

        function close(): void {
            GlobalStates.barOpen = false
        }

        function open(): void {
            GlobalStates.barOpen = true
        }
    }

    GlobalShortcut {
        name: "barToggle"
        description: "Toggles bar on press"

        onPressed: {
            GlobalStates.barOpen = !GlobalStates.barOpen;
        }
    }

    GlobalShortcut {
        name: "barOpen"
        description: "Opens bar on press"

        onPressed: {
            GlobalStates.barOpen = true;
        }
    }

    GlobalShortcut {
        name: "barClose"
        description: "Closes bar on press"

        onPressed: {
            GlobalStates.barOpen = false;
        }
    }
}
