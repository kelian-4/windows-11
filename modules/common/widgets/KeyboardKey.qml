import QtQuick
import QtQuick.Layouts
import qs.modules.common
import qs.modules.waffle.looks

Item {
    id: root
    property string key
    property real pixelSize: Looks.font.pixelSize.large
    property real borderWidth: 1
    property real extraBottomBorderWidth: 2
    property color borderColor: Looks.colors.bg2Border
    property real borderRadius: Looks.radius.medium
    property color keyColor: Looks.colors.bg2Base

    implicitWidth: keyFace.implicitWidth + borderWidth * 2
    implicitHeight: keyFace.implicitHeight + borderWidth * 2 + extraBottomBorderWidth

    Rectangle {
        id: borderRect
        anchors.fill: parent
        color: root.borderColor
        radius: root.borderRadius

        Rectangle {
            id: keyFace
            anchors {
                fill: parent
                topMargin: root.borderWidth
                leftMargin: root.borderWidth
                rightMargin: root.borderWidth
                bottomMargin: root.borderWidth + root.extraBottomBorderWidth
            }
            implicitWidth: keyText.implicitWidth + 12
            implicitHeight: keyText.implicitHeight + 4
            color: root.keyColor
            radius: root.borderRadius - root.borderWidth

            WText {
                id: keyText
                anchors.centerIn: parent
                font.pixelSize: root.pixelSize
                text: root.key
            }
        }
    }
}
