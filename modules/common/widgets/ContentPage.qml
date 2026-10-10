import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.modules.common
import qs.modules.waffle.looks

Flickable {
    id: root
    property real baseWidth: 600
    property bool forceWidth: false
    property real bottomContentPadding: 60
    property Component heroComponent: null

    default property alias contentData: contentColumn.data

    clip: true
    boundsBehavior: Flickable.StopAtBounds
    contentWidth: width
    contentHeight: contentColumn.implicitHeight + root.bottomContentPadding
    implicitWidth: contentColumn.implicitWidth

    ScrollBar.vertical: WScrollBar {
        policy: ScrollBar.AsNeeded
    }

    ColumnLayout {
        id: contentColumn
        x: 21
        width: Math.max(0, Math.min(root.width - 77, 1000))
        spacing: 24

        Loader {
            Layout.fillWidth: true
            Layout.bottomMargin: 4
            active: root.heroComponent !== null
            visible: active
            sourceComponent: root.heroComponent
        }
    }
}
