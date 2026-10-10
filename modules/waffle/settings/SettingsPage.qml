import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.modules.waffle.looks

Flickable {
    id: root

    default property alias content: column.data

    clip: true
    boundsBehavior: Flickable.StopAtBounds
    contentWidth: width
    contentHeight: column.implicitHeight + 36

    ScrollBar.vertical: WScrollBar {
        policy: ScrollBar.AsNeeded
    }

    ColumnLayout {
        id: column
        x: 21
        width: Math.min(root.width - 21 - 56, 1000)
        spacing: 4
    }
}
