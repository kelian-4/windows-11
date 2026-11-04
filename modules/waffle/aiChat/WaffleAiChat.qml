import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import qs
import qs.services
import qs.modules.common

Scope {
    id: root

    readonly property bool available: Config.options.policies.ai !== 0

    onAvailableChanged: {
        if (!root.available)
            GlobalStates.aiChatOpen = false;
    }

    function toggleOpen() {
        if (!root.available) {
            GlobalStates.aiChatOpen = false;
            return;
        }
        GlobalStates.aiChatOpen = !GlobalStates.aiChatOpen;
    }

    Connections {
        target: GlobalStates

        function onAiChatOpenChanged() {
            if (GlobalStates.aiChatOpen && root.available)
                panelLoader.active = true;
        }
    }

    Loader {
        id: panelLoader
        active: GlobalStates.aiChatOpen && root.available
        sourceComponent: PanelWindow {
            id: panelWindow
            exclusiveZone: 0
            WlrLayershell.namespace: "quickshell:aiChat"
            WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
            color: "transparent"

            anchors {
                bottom: Config.options.waffles.bar.bottom
                top: !Config.options.waffles.bar.bottom
                right: true
            }

            implicitWidth: content.implicitWidth
            implicitHeight: content.implicitHeight

            HyprlandFocusGrab {
                id: focusGrab
                active: true
                windows: [panelWindow]
                onCleared: content.close()
            }

            Connections {
                target: GlobalStates
                function onAiChatOpenChanged() {
                    if (!GlobalStates.aiChatOpen)
                        content.close();
                }
            }

            AiChatContent {
                id: content
                anchors.fill: parent
                maxPanelHeight: Math.max(360, (panelWindow.screen?.height ?? 900) - 80)

                onClosed: {
                    GlobalStates.aiChatOpen = false;
                    panelLoader.active = false;
                }
            }
        }
    }

    IpcHandler {
        target: "ai"

        function toggle(): void {
            root.toggleOpen();
        }

        function open(): void {
            if (root.available)
                GlobalStates.aiChatOpen = true;
        }

        function close(): void {
            GlobalStates.aiChatOpen = false;
        }
    }

    GlobalShortcut {
        name: "aiToggle"
        description: "Toggles the AI assistant on press"

        onPressed: root.toggleOpen()
    }
}
