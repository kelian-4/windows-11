import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.modules.common
import qs.modules.waffle.looks
import qs.modules.waffle.settings

Rectangle {
    id: root
    property string text: ""
    property string icon
    property alias value: spinBoxWidget.value
    property alias stepSize: spinBoxWidget.stepSize
    property alias from: spinBoxWidget.from
    property alias to: spinBoxWidget.to

    Layout.fillWidth: true
    implicitHeight: 56
    implicitWidth: rowLayout.implicitWidth + 36
    radius: Looks.radius.medium
    color: Looks.colors.bg1Base
    border.width: 1
    border.color: Looks.colors.bgPanelSeparator

    RowLayout {
        id: rowLayout
        anchors {
            fill: parent
            leftMargin: 18
            rightMargin: 18
        }
        spacing: 16
        opacity: root.enabled ? 1 : 0.4

        SettingsIcon {
            visible: icon.length > 0
            icon: MaterialIconMap.fluent(root.icon)
            size: 20
            Layout.alignment: Qt.AlignVCenter
        }

        WText {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter
            text: root.text
            wrapMode: Text.WordWrap
            font.pixelSize: Looks.font.pixelSize.large
        }

        SpinBox {
            id: spinBoxWidget
            Layout.alignment: Qt.AlignVCenter
            implicitWidth: 120
            implicitHeight: 32
            editable: true
            value: root.value
            hoverEnabled: true

            background: Rectangle {
                radius: Looks.radius.medium
                color: spinBoxWidget.activeFocus ? Looks.colors.bg0Base : Looks.colors.bg2Base
                border.width: 1
                border.color: Looks.colors.bg2Border

                Rectangle {
                    anchors {
                        left: parent.left
                        right: parent.right
                        bottom: parent.bottom
                    }
                    height: spinBoxWidget.activeFocus ? 2 : 0
                    color: Looks.colors.accent
                }
            }

            contentItem: TextInput {
                leftPadding: 10
                rightPadding: 28
                text: spinBoxWidget.textFromValue(spinBoxWidget.value, spinBoxWidget.locale)
                color: Looks.colors.fg
                selectionColor: Looks.colors.selection
                selectedTextColor: Looks.colors.selectionFg
                verticalAlignment: Text.AlignVCenter
                readOnly: !spinBoxWidget.editable
                validator: spinBoxWidget.validator
                inputMethodHints: Qt.ImhFormattedNumbersOnly
                selectByMouse: true
                font {
                    family: Looks.font.family.ui
                    pixelSize: Looks.font.pixelSize.large
                }
            }

            up.indicator: Rectangle {
                x: spinBoxWidget.width - width - 3
                y: 3
                width: 22
                height: spinBoxWidget.height / 2 - 3
                radius: 3
                color: spinBoxWidget.up.pressed ? Looks.colors.bg2Active : (spinBoxWidget.up.hovered ? Looks.colors.bg2Hover : "transparent")

                FluentIcon {
                    anchors.centerIn: parent
                    icon: "caret-up"
                    implicitSize: 10
                }
            }

            down.indicator: Rectangle {
                x: spinBoxWidget.width - width - 3
                y: spinBoxWidget.height / 2
                width: 22
                height: spinBoxWidget.height / 2 - 3
                radius: 3
                color: spinBoxWidget.down.pressed ? Looks.colors.bg2Active : (spinBoxWidget.down.hovered ? Looks.colors.bg2Hover : "transparent")

                FluentIcon {
                    anchors.centerIn: parent
                    icon: "caret-down"
                    implicitSize: 10
                }
            }
        }
    }
}
