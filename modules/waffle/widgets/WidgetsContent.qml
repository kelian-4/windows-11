import QtQuick
import qs.modules.waffle.looks

WBarAttachedPanelContent {
    id: root

    revealFromSides: true
    revealFromLeft: true

    contentItem: Item {
        id: body
        anchors {
            top: parent.top
            bottom: parent.bottom
        }
        implicitWidth: pane.implicitWidth

        WPane {
            id: pane
            anchors.verticalCenter: parent.verticalCenter
            contentItem: WidgetsBoard {
                implicitHeight: body.height - pane.borderWidth * 2
            }
        }
    }
}
