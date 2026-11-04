import QtQuick
import QtQuick.Layouts
import qs.services
import qs.modules.common
import qs.modules.waffle.looks

Rectangle {
    id: root

    required property string blockText
    property bool completed: false
    property bool expanded: !root.completed

    Layout.fillWidth: true
    implicitHeight: column.implicitHeight
    radius: Looks.radius.medium
    color: Looks.colors.bg1
    border.width: 1
    border.color: Looks.colors.bg2Border

    ColumnLayout {
        id: column
        anchors {
            left: parent.left
            right: parent.right
        }
        spacing: 0

        MouseArea {
            Layout.fillWidth: true
            implicitHeight: 32
            cursorShape: Qt.PointingHandCursor
            onClicked: root.expanded = !root.expanded

            RowLayout {
                anchors {
                    fill: parent
                    leftMargin: 10
                    rightMargin: 10
                }
                spacing: 8

                FluentIcon {
                    icon: "chevron-down"
                    implicitSize: 12
                    color: Looks.colors.subfg
                    rotation: root.expanded ? 0 : -90
                    Behavior on rotation {
                        animation: Looks.transition.enter.createObject(this)
                    }
                }
                WText {
                    Layout.fillWidth: true
                    text: Translation.tr("Reasoning")
                    color: Looks.colors.subfg
                    font.pixelSize: Looks.font.pixelSize.normal
                }
            }
        }

        TextEdit {
            Layout.fillWidth: true
            Layout.margins: 10
            Layout.topMargin: 0
            visible: root.expanded
            text: root.blockText.replace(/<\/?tt>/g, "").trim()
            readOnly: true
            selectByMouse: true
            wrapMode: TextEdit.Wrap
            textFormat: TextEdit.PlainText
            color: Looks.colors.subfg
            selectionColor: Looks.colors.selection
            selectedTextColor: Looks.colors.selectionFg
            renderType: Text.NativeRendering
            font {
                family: Looks.font.family.ui
                pixelSize: Looks.font.pixelSize.normal
                weight: Looks.font.weight.regular
                variableAxes: Looks.font.variableAxes.ui
            }
        }
    }
}
