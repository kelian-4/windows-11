import QtQuick
import qs.services
import qs.modules.waffle.looks

Rectangle {
    implicitWidth: label.implicitWidth + 16
    implicitHeight: label.implicitHeight + 6
    radius: Looks.radius.medium
    color: Looks.colors.bg2Base
    border.width: 1
    border.color: Looks.colors.bg2Border

    WText {
        id: label
        anchors.centerIn: parent
        text: Translation.tr("Coming soon")
        color: Looks.colors.fg1
        font.pixelSize: Looks.font.pixelSize.normal
    }
}
