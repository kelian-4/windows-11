pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell
import qs
import qs.services
import qs.modules.common
import qs.modules.waffle.looks

Item {
    id: root
    property Item contentItem
    property real radius: Looks.radius.large
    property alias color: contentRect.color
    property alias border: borderRect
    property alias borderColor: borderRect.border.color
    property alias borderWidth: borderRect.border.width

    implicitWidth: borderRect.implicitWidth
    implicitHeight: borderRect.implicitHeight

    WRectangularShadow {
        target: borderRect
    }

    Rectangle {
        id: borderRect
        z: 1

        color: "transparent"
        radius: root.radius
        border.color: Looks.colors.bg2Border
        border.width: 1
        implicitWidth: contentItem.implicitWidth + border.width * 2
        implicitHeight: contentItem.implicitHeight + border.width * 2
        anchors.fill: contentRect
        anchors.margins: -border.width
    }

    Rectangle {
        id: contentRect
        anchors.centerIn: parent
        z: 0

        color: Looks.colors.bgPanelBody
        radius: root.radius
        implicitWidth: contentItem.implicitWidth
        implicitHeight: contentItem.implicitHeight
        width: implicitWidth
        height: implicitHeight
        clip: true
        children: [root.contentItem]
    }
}