import QtQuick
import qs.modules.waffle.looks

Item {
    id: root

    property color hoverColor: Looks.colors.bg2Hover
    property color pressColor: Looks.colors.bg2Active
    property color glyphColor: Looks.colors.fg
    default property alias glyph: glyphHolder.data

    signal clicked()

    implicitWidth: 46
    implicitHeight: 32

    Rectangle {
        anchors.fill: parent
        color: mouse.pressed ? root.pressColor : (mouse.containsMouse ? root.hoverColor : "transparent")
    }

    Item {
        id: glyphHolder
        anchors.centerIn: parent
        width: 12
        height: 12
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true
        onClicked: root.clicked()
    }
}
