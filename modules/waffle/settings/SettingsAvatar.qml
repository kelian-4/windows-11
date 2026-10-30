import QtQuick
import qs.modules.waffle.looks

Item {
    id: root

    property int size: 60

    implicitWidth: size
    implicitHeight: size

    Rectangle {
        anchors.fill: parent
        radius: width / 2
        color: Looks.colors.bg2Base
        border.width: 1
        border.color: Looks.colors.bg2Border

        SettingsIcon {
            anchors.centerIn: parent
            icon: "people"
            size: Math.round(root.size / 2)
            tint: Looks.colors.fg1
        }
    }

    WUserAvatar {
        anchors.fill: parent
        sourceSize: Qt.size(root.size, root.size)
    }
}
