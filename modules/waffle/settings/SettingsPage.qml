import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.modules.waffle.looks

Flickable {
    id: root

    property string title: ""
    default property alias content: column.data

    clip: true
    boundsBehavior: Flickable.StopAtBounds
    contentWidth: width
    contentHeight: column.implicitHeight + 36 + header.implicitHeight

    ScrollBar.vertical: WScrollBar {
        policy: ScrollBar.AsNeeded
    }

    WText {
        id: header
        x: 64
        y: 10
        text: root.title
        font.pixelSize: 28
        font.weight: Looks.font.weight.strong
    }

    ColumnLayout {
        id: column
        x: 21
        y: header.y + header.implicitHeight + 24
        width: Math.min(root.width - 21 - 56, 1000)
        spacing: 4
    }
}
