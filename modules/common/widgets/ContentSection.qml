import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.modules.common
import qs.modules.waffle.looks
import qs.modules.waffle.settings

ColumnLayout {
    id: root
    property string title
    property string icon: ""
    default property alias contentData: sectionContent.data

    Layout.fillWidth: true
    spacing: 8

    RowLayout {
        Layout.leftMargin: 2
        spacing: 10

        SettingsIcon {
            visible: icon.length > 0
            icon: MaterialIconMap.fluent(root.icon)
            size: 18
            Layout.alignment: Qt.AlignVCenter
        }

        WText {
            text: root.title
            font.pixelSize: Looks.font.pixelSize.larger
            font.weight: Looks.font.weight.strong
        }
    }

    ColumnLayout {
        id: sectionContent
        Layout.fillWidth: true
        spacing: 4
    }
}
