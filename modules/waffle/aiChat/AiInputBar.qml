import QtQuick
import QtQuick.Controls.FluentWinUI3
import QtQuick.Controls
import QtQuick.Layouts
import qs.services
import qs.modules.common
import qs.modules.common.functions
import qs.modules.waffle.looks

Item {
    id: root

    required property var commands
    property alias inputField: field
    signal sendRequested(string text)

    function submit() {
        const message = field.text.trim();
        if (message.length === 0)
            return;
        if (Ai.isGenerating && !message.startsWith(root.commands.prefix))
            return;
        field.clear();
        root.sendRequested(message);
    }

    function acceptSuggestion(word) {
        const words = field.text.trim().split(/\s+/);
        words[words.length - 1] = word;
        field.text = words.join(" ") + " ";
        field.cursorPosition = field.text.length;
        field.forceActiveFocus();
    }

    implicitHeight: column.implicitHeight + 24

    ColumnLayout {
        id: column
        anchors {
            left: parent.left
            right: parent.right
            verticalCenter: parent.verticalCenter
            leftMargin: 12
            rightMargin: 12
        }
        spacing: 8

        AiSuggestions {
            id: suggestionBox
            Layout.fillWidth: true
            onAccepted: word => root.acceptSuggestion(word)
        }

        WBorderedButton {
            visible: Ai.pendingFilePath.length > 0
            text: FileUtils.fileNameForPath(Ai.pendingFilePath)
            icon.name: "dismiss"
            onClicked: Ai.attachFile("")
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 8

            ScrollView {
                Layout.fillWidth: true
                Layout.preferredHeight: Math.min(field.implicitHeight, 120)
                Layout.alignment: Qt.AlignBottom

                TextArea {
                    id: field
                    placeholderText: Translation.tr("Message the model... \"%1\" for commands").arg(root.commands.prefix)
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

                    onTextChanged: suggestionBox.suggestions = root.commands.suggest(field.text)

                    Keys.onPressed: event => {
                        if (event.key === Qt.Key_Tab && suggestionBox.visible) {
                            suggestionBox.acceptSelected();
                            event.accepted = true;
                        } else if (event.key === Qt.Key_Up && suggestionBox.visible) {
                            suggestionBox.selectedIndex = Math.max(0, suggestionBox.selectedIndex - 1);
                            event.accepted = true;
                        } else if (event.key === Qt.Key_Down && suggestionBox.visible) {
                            suggestionBox.selectedIndex = Math.min(suggestionBox.shown.length - 1, suggestionBox.selectedIndex + 1);
                            event.accepted = true;
                        } else if ((event.key === Qt.Key_Return || event.key === Qt.Key_Enter) && !(event.modifiers & Qt.ShiftModifier)) {
                            root.submit();
                            event.accepted = true;
                        } else if (event.key === Qt.Key_Escape && Ai.pendingFilePath.length > 0) {
                            Ai.attachFile("");
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
                enabled: Ai.isGenerating || field.text.trim().length > 0
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
}
