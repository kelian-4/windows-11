import QtQuick
import QtQuick.Layouts
import qs.modules.waffle.looks

RowLayout {
    id: root

    property string icon: ""
    property color iconTint: Looks.colors.fg
    property string title: ""
    property string subtitle: ""

    spacing: 14

    SettingsIcon {
        icon: root.icon
        tint: root.iconTint
        size: 24
        Layout.alignment: Qt.AlignVCenter
    }

    ColumnLayout {
        spacing: 0
        Layout.alignment: Qt.AlignVCenter

        WText {
            text: root.title
            font.pixelSize: Looks.font.pixelSize.large
            font.weight: Looks.font.weight.strong
        }

        WText {
            text: root.subtitle
            color: Looks.colors.fg1
            font.pixelSize: Looks.font.pixelSize.normal
        }
    }
}
