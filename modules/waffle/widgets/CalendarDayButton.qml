import QtQuick
import qs.modules.waffle.looks

WButton {
    id: root

    required property var model
    required property int focusedMonth
    required property real size

    checked: model.today
    enabled: hovered || checked || model.month === focusedMonth
    implicitWidth: size
    implicitHeight: size
    radius: size / 2

    contentItem: Item {
        WText {
            anchors.centerIn: parent
            text: root.model.day
            color: root.fgColor
        }
    }
}
