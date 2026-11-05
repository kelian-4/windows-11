pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.services
import qs.modules.common
import qs.modules.common.functions
import qs.modules.waffle.looks

Item {
    id: root

    required property var messageId
    required property var messageData
    readonly property string role: root.messageData?.role ?? ""
    readonly property bool isUser: root.role === "user"
    readonly property bool isAssistant: root.role === "assistant"
    readonly property bool isInterface: root.role === "interface"
    readonly property bool isDone: root.messageData?.done ?? true
    readonly property int messageIndex: Ai.messageIDs.indexOf(root.messageId)
    readonly property bool isLastMessage: root.messageIndex === Ai.messageIDs.length - 1
    property list<var> messageBlocks: StringUtils.splitMarkdownBlocks(root.messageData?.content ?? "")
    property bool copied: false

    implicitHeight: contentColumn.implicitHeight

    Timer {
        id: copiedTimer
        interval: 1500
        onTriggered: root.copied = false
    }

    HoverHandler {
        id: hoverHandler
    }

    ColumnLayout {
        id: contentColumn
        anchors {
            left: parent.left
            right: parent.right
        }
        spacing: 4

        Loader {
            Layout.fillWidth: true
            active: root.isInterface
            visible: active
            sourceComponent: Component {
                AiTextBlock {
                    blockText: root.messageData?.content ?? ""
                    textColor: Looks.colors.subfg
                    alignment: TextEdit.AlignHCenter
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true
            visible: root.isAssistant
            spacing: 8

            FluentIcon {
                icon: "wand"
                implicitSize: 16
                color: Looks.colors.accent
            }
            WText {
                Layout.fillWidth: true
                text: Ai.models[root.messageData?.model]?.name ?? ""
                color: Looks.colors.subfg
                font.weight: Looks.font.weight.strong
                elide: Text.ElideRight
            }
        }

        Item {
            Layout.fillWidth: true
            visible: root.isUser || root.isAssistant
            implicitHeight: bubble.implicitHeight

            Rectangle {
                id: bubble
                readonly property real horizontalPadding: root.isUser ? 12 : 0
                readonly property real verticalPadding: root.isUser ? 10 : 0

                anchors.right: parent.right
                width: root.isUser ? Math.min(parent.width, blocksColumn.implicitWidth + horizontalPadding * 2) : parent.width
                implicitHeight: blocksColumn.implicitHeight + verticalPadding * 2
                radius: Looks.radius.large
                color: root.isUser ? Looks.colors.bg2Base : "transparent"
                border.width: root.isUser ? 1 : 0
                border.color: Looks.colors.bg2Border

                ColumnLayout {
                    id: blocksColumn
                    anchors {
                        fill: parent
                        leftMargin: bubble.horizontalPadding
                        rightMargin: bubble.horizontalPadding
                        topMargin: bubble.verticalPadding
                        bottomMargin: bubble.verticalPadding
                    }
                    spacing: 8

                    WIndeterminateProgressBar {
                        Layout.fillWidth: true
                        visible: root.isAssistant && !root.isDone && root.messageBlocks.length === 0
                    }

                    WText {
                        Layout.fillWidth: true
                        visible: root.isAssistant && root.isDone && root.messageBlocks.length === 0
                        wrapMode: Text.Wrap
                        color: Looks.colors.subfg
                        text: Translation.tr("No response was received. Check your connection and your API key.")
                    }

                    Repeater {
                        model: ScriptModel {
                            values: root.messageBlocks
                        }
                        delegate: DelegateChooser {
                            role: "type"

                            DelegateChoice {
                                roleValue: "code"
                                AiCodeBlock {
                                    required property var modelData
                                    blockText: modelData.content
                                    lang: modelData.lang
                                    messageData: root.messageData
                                }
                            }
                            DelegateChoice {
                                roleValue: "think"
                                AiThinkBlock {
                                    required property var modelData
                                    blockText: modelData.content
                                    completed: (modelData.completed ?? false) || root.isDone
                                }
                            }
                            DelegateChoice {
                                roleValue: "text"
                                AiTextBlock {
                                    required property var modelData
                                    blockText: modelData.content
                                }
                            }
                        }
                    }
                }
            }
        }

        Flow {
            Layout.fillWidth: true
            visible: root.isAssistant && (root.messageData?.annotationSources?.length ?? 0) > 0
            spacing: 6

            Repeater {
                model: ScriptModel {
                    values: root.messageData?.annotationSources ?? []
                }
                delegate: WBorderedButton {
                    required property var modelData
                    readonly property string label: modelData.text ?? ""
                    text: label.length > 34 ? label.substring(0, 33) + "…" : label
                    icon.name: "link"
                    onClicked: Qt.openUrlExternally(modelData.url)
                }
            }
        }

        Flow {
            Layout.fillWidth: true
            visible: root.isAssistant && (root.messageData?.searchQueries?.length ?? 0) > 0
            spacing: 6

            Repeater {
                model: ScriptModel {
                    values: root.messageData?.searchQueries ?? []
                }
                delegate: WBorderedButton {
                    required property var modelData
                    text: modelData.length > 34 ? modelData.substring(0, 33) + "…" : modelData
                    icon.name: "globe-search"
                    onClicked: Qt.openUrlExternally("https://www.google.com/search?q=" + encodeURIComponent(modelData))
                }
            }
        }

        RowLayout {
            Layout.alignment: root.isUser ? Qt.AlignRight : Qt.AlignLeft
            visible: !root.isInterface && root.isDone && (hoverHandler.hovered || (root.isAssistant && root.isLastMessage))
            spacing: 2

            AiActionButton {
                iconName: root.copied ? "checkmark" : "copy"
                tooltipText: Translation.tr("Copy")
                onClicked: {
                    Quickshell.clipboardText = root.messageData?.content ?? "";
                    root.copied = true;
                    copiedTimer.restart();
                }
            }
            AiActionButton {
                visible: root.isAssistant
                enabled: !Ai.isGenerating
                iconName: "arrow-clockwise"
                tooltipText: Translation.tr("Regenerate")
                onClicked: Ai.regenerate(root.messageIndex)
            }
            AiActionButton {
                iconName: "delete"
                tooltipText: Translation.tr("Delete")
                onClicked: Ai.removeMessage(root.messageIndex)
            }
        }
    }
}
