pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.modules.common
import qs.modules.waffle.looks

Popup {
    id: root

    property var model: []
    property var parentMenu: null
    property var subMenu: null

    readonly property bool hasIcons: model.some(entry => (entry.icon ?? "").length > 0)
    readonly property bool dynamicInstance: parentMenu !== null

    function clampX(value) {
        return Math.max(8, Math.min(value, parent.width - width - 8));
    }

    function clampY(value) {
        return Math.max(8, Math.min(value, parent.height - height - 8));
    }

    function openAt(posX, posY) {
        open();
        x = clampX(posX);
        y = clampY(posY);
    }

    function openBeside(parentX, parentWidth, posY) {
        open();
        const right = parentX + parentWidth - 4;
        x = right + width + 8 > parent.width ? Math.max(8, parentX - width + 4) : right;
        y = clampY(posY);
    }

    function openSubFor(entryItem) {
        closeSub();
        const component = Qt.createComponent(Qt.resolvedUrl("DesktopMenu.qml"));
        const sub = component.createObject(root.parent, {
            parent: root.parent,
            model: entryItem.entry.submenu,
            parentMenu: root
        });
        const point = entryItem.mapToItem(root.parent, 0, 0);
        sub.openBeside(root.x, root.width, point.y - 5);
        root.subMenu = sub;
    }

    function closeSub() {
        if (root.subMenu === null)
            return;
        root.subMenu.close();
        root.subMenu = null;
    }

    function closeAll() {
        if (root.parentMenu !== null) {
            root.parentMenu.closeAll();
            return;
        }
        root.closeSub();
        root.close();
    }

    function hoverEntry(entryItem) {
        if (entryItem.hasSubmenu)
            root.openSubFor(entryItem);
        else
            root.closeSub();
    }

    width: 280
    padding: 4
    popupType: Popup.Item
    closePolicy: Popup.CloseOnEscape

    onClosed: {
        root.closeSub();
        if (root.dynamicInstance)
            root.destroy();
    }

    background: Item {
        WRectangularShadow {
            target: menuBackground
        }

        Rectangle {
            id: menuBackground
            anchors.fill: parent
            radius: Looks.radius.large
            color: Looks.colors.bg1Base
            border.width: 1
            border.color: Looks.colors.bg0Border
        }
    }

    contentItem: ColumnLayout {
        spacing: 0

        Repeater {
            model: root.model

            delegate: DesktopMenuEntry {
                required property var modelData

                Layout.fillWidth: true
                entry: modelData
                menu: root
            }
        }
    }
}
