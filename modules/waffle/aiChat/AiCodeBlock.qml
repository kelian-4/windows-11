import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.services
import qs.modules.common
import qs.modules.waffle.looks

Rectangle {
    id: root

    required property string blockText
    property string lang: ""
    property var messageData: null
    readonly property bool isCommandRequest: root.lang === "command"
    readonly property bool awaitingApproval: root.isCommandRequest && (root.messageData?.functionPending ?? false)
    property bool copied: false

    Layout.fillWidth: true
    implicitHeight: column.implicitHeight
    radius: Looks.radius.medium
    color: Looks.colors.bg0Base
    border.width: 1
    border.color: Looks.colors.bg2Border

    Timer {
        id: copiedTimer
        interval: 1500
        onTriggered: root.copied = false
    }

    ColumnLayout {
        id: column
        anchors {
            left: parent.left
            right: parent.right
        }
        spacing: 0

        RowLayout {
            Layout.fillWidth: true
            Layout.leftMargin: 10
            Layout.rightMargin: 4
            Layout.topMargin: 2
            spacing: 6

            WText {
                Layout.fillWidth: true
                text: root.isCommandRequest ? "bash" : root.lang
                color: Looks.colors.subfg
                font.pixelSize: Looks.font.pixelSize.normal
                elide: Text.ElideRight
            }
            AiActionButton {
                iconName: root.copied ? "checkmark" : "copy"
                tooltipText: Translation.tr("Copy")
                onClicked: {
                    Quickshell.clipboardText = root.blockText;
                    root.copied = true;
                    copiedTimer.restart();
                }
            }
        }

        TextEdit {
            Layout.fillWidth: true
            Layout.leftMargin: 10
            Layout.rightMargin: 10
            Layout.bottomMargin: 10
            text: root.blockText.replace(/\n+$/, "")
            readOnly: true
            selectByMouse: true
            wrapMode: TextEdit.WrapAnywhere
            textFormat: TextEdit.PlainText
            color: Looks.colors.fg
            selectionColor: Looks.colors.selection
            selectedTextColor: Looks.colors.selectionFg
            renderType: Text.NativeRendering
            font {
                family: Config.options.appearance.fonts.monospace
                pixelSize: Looks.font.pixelSize.normal
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.margins: 8
            Layout.topMargin: 0
            visible: root.awaitingApproval
            spacing: 8

            Item {
                Layout.fillWidth: true
            }
            WBorderedButton {
                text: Translation.tr("Reject")
                onClicked: Ai.rejectCommand(root.messageData)
            }
            WBorderedButton {
                text: Translation.tr("Approve")
                checked: true
                onClicked: Ai.approveCommand(root.messageData)
            }
        }
    }
}
