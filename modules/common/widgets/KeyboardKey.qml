import qs.modules.common
import qs.modules.waffle.looks
import QtQuick

Rectangle {
    id: root
    property string key

    property real horizontalPadding: 6
    property real verticalPadding: 1
    property real borderWidth: 1
    property real extraBottomBorderWidth: 2
    property color borderColor: Looks.colors.bg2Border
    property real borderRadius: Looks.radius.medium
    property real pixelSize: Looks.font.pixelSize.normal
    property color keyColor: Looks.colors.bg2Base
    implicitWidth: keyFace.implicitWidth + borderWidth * 2
    implicitHeight: keyFace.implicitHeight + borderWidth * 2 + extraBottomBorderWidth
    radius: borderRadius
    color: borderColor

    Rectangle {
        id: keyFace
        anchors {
            fill: parent
            topMargin: borderWidth
            leftMargin: borderWidth
            rightMargin: borderWidth
            bottomMargin: extraBottomBorderWidth + borderWidth
        }
        implicitWidth: keyText.implicitWidth + horizontalPadding * 2
        implicitHeight: keyText.implicitHeight + verticalPadding * 2
        color: keyColor
        radius: borderRadius - borderWidth

        WText {
            id: keyText
            anchors.centerIn: parent
            font.pixelSize: root.pixelSize
            text: key
        }
    }
}
