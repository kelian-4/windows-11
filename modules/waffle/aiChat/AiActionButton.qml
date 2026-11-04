import QtQuick
import QtQuick.Controls
import qs.modules.common
import qs.modules.waffle.looks

WBorderlessButton {
    id: root

    property string iconName
    property string tooltipText
    property real iconSize: 14

    implicitWidth: 28
    implicitHeight: 28

    contentItem: Item {
        FluentIcon {
            anchors.centerIn: parent
            icon: root.iconName
            implicitSize: root.iconSize
            color: root.colForeground
        }
    }

    WToolTip {
        text: root.tooltipText
        extraVisibleCondition: root.tooltipText.length > 0
    }
}
