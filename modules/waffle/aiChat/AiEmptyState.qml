pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.modules.common
import qs.modules.waffle.looks

Item {
    id: root

    property bool canSend: true
    signal suggestionChosen(string text)

    readonly property var suggestions: [
        Translation.tr("Explain how a neural network works"),
        Translation.tr("Help me write a polite email"),
        Translation.tr("Give me ideas for a weekend project")
    ]

    ColumnLayout {
        anchors {
            left: parent.left
            right: parent.right
            verticalCenter: parent.verticalCenter
            leftMargin: 24
            rightMargin: 24
        }
        spacing: 10

        FluentIcon {
            Layout.alignment: Qt.AlignHCenter
            icon: "wand"
            implicitSize: 40
            color: Looks.colors.accent
        }
        WText {
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.Wrap
            text: Translation.tr("How can I help you today?")
            font.pixelSize: Looks.font.pixelSize.xlarger
            font.weight: Looks.font.weight.strong
        }
        WText {
            Layout.fillWidth: true
            Layout.bottomMargin: 8
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.Wrap
            text: Translation.tr("Ask anything, or start with one of these ideas.")
            color: Looks.colors.subfg
        }

        Repeater {
            model: root.suggestions
            delegate: WBorderedButton {
                required property string modelData
                Layout.fillWidth: true
                enabled: root.canSend
                text: modelData
                onClicked: root.suggestionChosen(modelData)
            }
        }
    }
}
