pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.services
import qs.modules.common
import qs.modules.waffle.looks

Popup {
    id: root

    property var info: ({})

    width: 360
    padding: 16
    modal: true
    dim: false
    popupType: Popup.Item
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
    x: Math.round((parent.width - width) / 2)
    y: Math.round((parent.height - height) / 2)

    background: Item {
        WRectangularShadow {
            target: dialogBackground
        }

        Rectangle {
            id: dialogBackground
            anchors.fill: parent
            radius: Looks.radius.large
            color: Looks.colors.bg1Base
            border.width: 1
            border.color: Looks.colors.bg0Border
        }
    }

    contentItem: ColumnLayout {
        spacing: 12

        RowLayout {
            Layout.fillWidth: true
            spacing: 12

            Image {
                Layout.preferredWidth: 40
                Layout.preferredHeight: 40
                source: root.info.icon ?? ""
                sourceSize: Qt.size(80, 80)
                fillMode: Image.PreserveAspectFit
            }

            WText {
                Layout.fillWidth: true
                text: root.info.name ?? ""
                elide: Text.ElideMiddle
                font.pixelSize: Looks.font.pixelSize.larger
                font.weight: Looks.font.weight.strong
            }
        }

        Rectangle {
            Layout.fillWidth: true
            implicitHeight: 1
            color: Looks.colors.bg0Border
        }

        GridLayout {
            Layout.fillWidth: true
            columns: 2
            columnSpacing: 16
            rowSpacing: 8

            Repeater {
                model: root.info.rows ?? []

                delegate: Item {
                    id: row

                    required property var modelData

                    Layout.columnSpan: 2
                    Layout.fillWidth: true
                    implicitHeight: Math.max(label.implicitHeight, value.implicitHeight)

                    WText {
                        id: label
                        width: 90
                        text: row.modelData.label
                        color: Looks.colors.subfg
                    }

                    WText {
                        id: value
                        anchors {
                            left: label.right
                            right: parent.right
                        }
                        text: row.modelData.value
                        wrapMode: Text.WrapAnywhere
                    }
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true

            Item {
                Layout.fillWidth: true
            }

            WButton {
                text: Translation.tr("OK")
                implicitWidth: 88
                onClicked: root.close()
            }
        }
    }
}
