pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray
import qs.services
import qs.modules.common
import qs.modules.common.widgets
import qs.modules.waffle.looks
import qs.modules.waffle.bar

BarIconButton {
    id: root

    required property SystemTrayItem item
    property alias menuOpen: menu.visible
    iconSource: item.icon
    iconScale: 0
    Component.onCompleted: {
        root.iconScale = 1
    }
    Behavior on iconScale {
        animation: Looks.transition.enter.createObject(this)
    }

    onClicked: {
        item.activate();
    }

    altAction: () => {
        if (item.hasMenu) menu.open()
    }

    // This is lazy, but it's not like tray menus on Windoes are consistent...
    // TODO: Figure out how to do cascading menus then use a custom menu
    QsMenuAnchor {
        id: menu
        menu: root.item.menu
        anchor {
            adjustment: Looks.barPopupAdjustment
            item: root
            gravity: Looks.barPopupEdge
            edges: Looks.barPopupEdge
        }
    }

    BarToolTip {
        extraVisibleCondition: root.shouldShowTooltip && !root.Drag.active
        text: TrayService.getTooltipForItem(root.item)
    }
}
