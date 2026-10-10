import QtQuick
import QtQuick.Layouts
import qs.modules.common
import qs.modules.waffle.looks
import qs.modules.waffle.settings

Rectangle {
    id: root
    property string materialIcon: "info"
    property string text: "Notice message"
    default property alias contentData: contentColumn.data

    radius: Looks.radius.medium
    color: Looks.colors.bg2Base
    border.width: 1
    border.color: Looks.colors.bg2Border
    Layout.fillWidth: true
    implicitWidth: rowLayout.implicitWidth + 28
    implicitHeight: rowLayout.implicitHeight + 24

    RowLayout {
        id: rowLayout
        anchors {
            fill: parent
            leftMargin: 14
            rightMargin: 14
            topMargin: 12
            bottomMargin: 12
        }
        spacing: 12

        Rectangle {
            Layout.alignment: Qt.AlignTop
            Layout.preferredWidth: 18
            Layout.preferredHeight: 18
            radius: 9
            color: Looks.colors.accent

            WText {
                anchors.centerIn: parent
                text: "i"
                color: Looks.colors.accentFg
                font.pixelSize: Looks.font.pixelSize.normal
                font.weight: Looks.font.weight.strong
            }
        }

        ColumnLayout {
            id: contentColumn
            Layout.fillWidth: true
            spacing: 4

            WText {
                Layout.fillWidth: true
                text: root.text
                wrapMode: Text.WordWrap
                font.pixelSize: Looks.font.pixelSize.large
            }
        }
    }
}
