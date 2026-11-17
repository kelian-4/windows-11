import QtQuick
import QtQuick.Layouts
import qs.modules.common
import qs.modules.common.widgets
import qs.modules.waffle.looks
import qs.modules.waffle.bar.tasks
import qs.modules.waffle.bar.tray

Rectangle {
    id: root

    readonly property bool vertical: Looks.barVertical
    readonly property string side: Looks.barSide
    readonly property bool leftAlign: Config.options.waffles.bar.leftAlignApps

    color: Looks.colors.bg0
    implicitHeight: root.vertical ? 0 : Looks.barThickness
    implicitWidth: root.vertical ? Looks.barThickness : 0

    Rectangle {
        id: border
        anchors {
            left: root.vertical ? (root.side === "right" ? parent.left : undefined) : parent.left
            right: root.vertical ? (root.side === "left" ? parent.right : undefined) : parent.right
            top: root.vertical ? parent.top : (root.side === "bottom" ? parent.top : undefined)
            bottom: root.vertical ? parent.bottom : (root.side === "top" ? parent.bottom : undefined)
        }
        color: Looks.colors.bg0Border
        implicitHeight: 1
        implicitWidth: 1
    }

    BarGroup {
        id: bloatRow
        anchors {
            left: parent.left
            top: parent.top
            right: root.vertical ? parent.right : undefined
            bottom: root.vertical ? undefined : parent.bottom
        }
        opacity: root.leftAlign ? 0 : 1
        visible: opacity > 0
        Behavior on opacity {
            animation: Looks.transition.opacity.createObject(this)
        }

        WidgetsButton {}
    }

    BarGroup {
        id: appsRow
        anchors {
            left: root.vertical ? parent.left : (root.leftAlign ? parent.left : undefined)
            right: root.vertical ? parent.right : undefined
            top: root.vertical ? (root.leftAlign ? parent.top : undefined) : parent.top
            bottom: root.vertical ? undefined : parent.bottom
            horizontalCenter: (!root.vertical && !root.leftAlign) ? parent.horizontalCenter : undefined
            verticalCenter: (root.vertical && !root.leftAlign) ? parent.verticalCenter : undefined
        }

        StartButton {}
        SearchButton {}
        TaskViewButton {}
        AiButton {}
        Tasks {}
    }

    BarGroup {
        id: systemRow
        anchors {
            right: parent.right
            bottom: parent.bottom
            left: root.vertical ? parent.left : undefined
            top: root.vertical ? undefined : parent.top
        }
        FadeLoader {
            Layout.fillHeight: !root.vertical
            Layout.fillWidth: root.vertical
            shown: root.leftAlign
            sourceComponent: WidgetsButton {}
        }
        Tray {}
        UpdatesButton {}
        SystemButton {}
        TimeButton {}
    }

    component BarGroup: GridLayout {
        flow: root.vertical ? GridLayout.TopToBottom : GridLayout.LeftToRight
        columns: root.vertical ? 1 : 1000
        rows: root.vertical ? 1000 : 1
        rowSpacing: 0
        columnSpacing: 0
    }
}
