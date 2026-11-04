import QtQuick
import QtQuick.Controls.FluentWinUI3
import QtQuick.Controls
import QtQuick.Layouts
import qs.services
import qs.modules.common
import qs.modules.waffle.looks

Item {
    id: root

    property bool canSend: true
    property alias inputField: field
    signal sendRequested(string text)

    function submit() {
        const message = field.text.trim();
        if (message.length === 0 || !root.canSend || Ai.isGenerating)
            return;
        field.clear();
        root.sendRequested(message);
    }

    implicitHeight: row.implicitHeight + 24

    RowLayout {
        id: row
        anchors {
            left: parent.left
            right: parent.right
            verticalCenter: parent.verticalCenter
            leftMargin: 12
            rightMargin: 12
        }
        spacing: 8

        ScrollView {
            Layout.fillWidth: true
            Layout.preferredHeight: Math.min(field.implicitHeight, 120)
            Layout.alignment: Qt.AlignBottom

            TextArea {
                id: field
                placeholderText: Translation.tr("Ask me anything")
                placeholderTextColor: Looks.colors.subfg
                wrapMode: TextEdit.Wrap
                color: Looks.colors.fg
                renderType: Text.NativeRendering
                selectByMouse: true
                palette.accent: Looks.colors.accent
                font {
                    hintingPreference: Font.PreferDefaultHinting
                    family: Looks.font.family.ui
                    pixelSize: Looks.font.pixelSize.large
                    weight: Looks.font.weight.regular
                }
                Keys.onPressed: event => {
                    if ((event.key === Qt.Key_Return || event.key === Qt.Key_Enter) && !(event.modifiers & Qt.ShiftModifier)) {
                        root.submit();
                        event.accepted = true;
                    }
                }
            }
        }

        WButton {
            Layout.alignment: Qt.AlignBottom
            implicitWidth: 40
            implicitHeight: 40
            checked: true
            enabled: Ai.isGenerating || (root.canSend && field.text.trim().length > 0)
            radius: Looks.radius.large
            contentItem: Item {
                FluentIcon {
                    anchors.centerIn: parent
                    icon: Ai.isGenerating ? "stop" : "arrow-right"
                    implicitSize: 18
                    color: Looks.colors.accentFg
                }
            }
            onClicked: {
                if (Ai.isGenerating)
                    Ai.stopGeneration();
                else
                    root.submit();
            }
            WToolTip {
                text: Ai.isGenerating ? Translation.tr("Stop") : Translation.tr("Send")
            }
        }
    }
}
