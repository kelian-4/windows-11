import QtQuick
import QtQuick.Layouts
import qs.services
import qs.modules.common
import qs.modules.waffle.looks

Rectangle {
    id: root

    readonly property var model: Ai.getModel()

    function save() {
        const key = keyField.text.trim();
        if (key.length === 0)
            return;
        Ai.setApiKey(key);
        keyField.text = "";
    }

    implicitHeight: column.implicitHeight + 24
    radius: Looks.radius.large
    color: Looks.colors.bg2Base
    border.width: 1
    border.color: Looks.colors.bg2Border

    ColumnLayout {
        id: column
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            margins: 12
        }
        spacing: 8

        RowLayout {
            Layout.fillWidth: true
            spacing: 8

            FluentIcon {
                icon: "lock-closed"
                implicitSize: 16
                color: Looks.colors.accent
            }
            WText {
                Layout.fillWidth: true
                wrapMode: Text.Wrap
                text: Translation.tr("An API key is needed to use %1.").arg(root.model?.name ?? "")
                font.weight: Looks.font.weight.strong
            }
        }

        WText {
            Layout.fillWidth: true
            wrapMode: Text.Wrap
            color: Looks.colors.subfg
            text: Translation.tr("It is stored in your system keyring.")
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 8

            WTextField {
                id: keyField
                Layout.fillWidth: true
                echoMode: TextInput.Password
                placeholderText: Translation.tr("Paste your API key")
                onAccepted: root.save()
            }
            WBorderedButton {
                text: Translation.tr("Save")
                checked: true
                enabled: keyField.text.trim().length > 0
                onClicked: root.save()
            }
        }

        WBorderlessButton {
            visible: (root.model?.key_get_link ?? "").length > 0
            implicitHeight: 28
            contentItem: WText {
                text: Translation.tr("Get a key")
                color: Looks.colors.link
            }
            onClicked: Qt.openUrlExternally(root.model.key_get_link)
        }
    }
}
