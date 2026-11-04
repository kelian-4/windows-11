pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.modules.common
import qs.modules.waffle.looks

WPane {
    id: root

    signal chosen

    implicitWidth: 300

    contentItem: Item {
        implicitWidth: 300
        implicitHeight: Math.min(list.contentHeight + 16, 320)

        WListView {
            id: list
            anchors {
                fill: parent
                margins: 4
            }
            clip: true
            spacing: 2
            model: Ai.modelList

            delegate: WChoiceButton {
                id: choice
                required property string modelData
                readonly property var info: Ai.models[modelData]
                width: ListView.view.width
                checked: modelData === Ai.currentModelId
                verticalPadding: 8
                contentItem: RowLayout {
                    spacing: 8

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 1

                        WText {
                            Layout.fillWidth: true
                            text: choice.info?.name ?? choice.modelData
                            elide: Text.ElideRight
                            font.weight: Looks.font.weight.strong
                        }
                        WText {
                            Layout.fillWidth: true
                            text: (choice.info?.description ?? "").split("\n")[0]
                            elide: Text.ElideRight
                            color: Looks.colors.subfg
                        }
                    }
                    FluentIcon {
                        visible: choice.checked
                        icon: "checkmark"
                        implicitSize: 14
                        color: Looks.colors.accent
                    }
                }
                onClicked: {
                    Ai.setModel(choice.modelData, false);
                    root.chosen();
                }
            }
        }
    }
}
