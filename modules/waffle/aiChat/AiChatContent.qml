pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell
import qs
import qs.services
import qs.modules.common
import qs.modules.waffle.looks

WBarAttachedPanelContent {
    id: root

    property real maxPanelHeight: 700
    property bool modelPickerOpen: false
    readonly property bool hasMessages: Ai.messageIDs.length > 0

    AiCommands {
        id: aiCommands
    }

    function send(text) {
        messageList.scrollToEnd();
        aiCommands.handle(text);
    }

    function startNewChat() {
        Ai.clearMessages();
        Ai.saveChat("lastSession");
        inputBar.inputField.forceActiveFocus();
    }

    Component.onCompleted: {
        if (!KeyringStorage.loaded)
            KeyringStorage.fetchKeyringData();
        if (!Ai.messageIDs.length)
            Ai.loadChat("lastSession");
        inputBar.inputField.forceActiveFocus();
    }

    Connections {
        target: Ai
        function onResponseFinished() {
            inputBar.inputField.forceActiveFocus();
        }
    }

    contentItem: WPane {
        contentItem: Item {
            implicitWidth: 440
            implicitHeight: Math.min(660, root.maxPanelHeight)

            ColumnLayout {
                anchors.fill: parent
                spacing: 0

                AiChatHeader {
                    Layout.fillWidth: true
                    modelPickerOpen: root.modelPickerOpen
                    onModelPickerToggled: root.modelPickerOpen = !root.modelPickerOpen
                    onNewChatRequested: root.startNewChat()
                    onCloseRequested: root.close()
                }

                WPanelSeparator {}

                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    AiMessageList {
                        id: messageList
                        anchors.fill: parent
                        visible: root.hasMessages
                    }

                    AiEmptyState {
                        anchors.fill: parent
                        visible: !root.hasMessages
                        onSuggestionChosen: text => root.send(text)
                    }

                    MouseArea {
                        anchors.fill: parent
                        visible: root.modelPickerOpen
                        onClicked: root.modelPickerOpen = false
                    }

                    AiModelPicker {
                        anchors {
                            top: parent.top
                            right: parent.right
                            topMargin: 4
                            rightMargin: 8
                        }
                        visible: root.modelPickerOpen
                        onChosen: root.modelPickerOpen = false
                    }
                }

                WPanelSeparator {}

                AiInputBar {
                    id: inputBar
                    Layout.fillWidth: true
                    commands: aiCommands
                    onSendRequested: text => root.send(text)
                }
            }
        }
    }
}
