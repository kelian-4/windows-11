pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Qt.labs.synchronizer
import Quickshell
import qs.services
import qs.modules.common
import qs.modules.common.widgets
import qs.modules.waffle.looks
import qs.modules.waffle.bar

GridLayout {
    id: root

    property bool overflowOpen: false
    property bool dragging: false

    Layout.fillHeight: !Looks.barVertical
    Layout.fillWidth: Looks.barVertical
    flow: Looks.barVertical ? GridLayout.TopToBottom : GridLayout.LeftToRight
    columns: Looks.barVertical ? 1 : 1000
    rows: Looks.barVertical ? 1000 : 1
    rowSpacing: 0
    columnSpacing: 0

    BarIconButton {
        id: overflowButton

        visible: (TrayService.unpinnedItems.length > 0 || root.dragging)
        checked: root.overflowOpen

        iconName: "chevron-down"
        iconMonochrome: true
        iconRotation: ({
                "bottom": 180,
                "top": 0,
                "left": -90,
                "right": 90
            })[Looks.barSide] + (root.overflowOpen ? 180 : 0)
        Behavior on iconRotation {
            animation: Looks.transition.rotate.createObject(this)
        }

        onClicked: {
            root.overflowOpen = !root.overflowOpen;
        }

        TrayOverflowMenu {
            id: trayOverflowLayout
            Synchronizer on active {
                property alias source: root.overflowOpen
            }
        }

        BarToolTip {
            extraVisibleCondition: overflowButton.shouldShowTooltip
            text: Translation.tr("Show hidden icons")
        }

        DropArea {
            id: pinDropArea
            anchors.fill: parent
            property bool willPin: false
            onEntered: willPin = true
            onExited: willPin = false
        }
    }

    Repeater {
        model: ScriptModel {
            values: TrayService.pinnedItems
        }
        delegate: TrayButton {
            id: trayButton
            required property var modelData
            item: modelData

            property real initialX
            property real initialY

            MouseArea {
                id: dragArea
                anchors.fill: parent
                drag.target: parent
                drag.axis: Looks.barVertical ? Drag.YAxis : Drag.XAxis
                drag.threshold: 2

                onPressed: event => {
                    trayButton.Drag.hotSpot.x = event.x;
                    trayButton.Drag.hotSpot.y = event.y;
                    trayButton.initialX = trayButton.x;
                    trayButton.initialY = trayButton.y;
                    root.dragging = true;
                    trayButton.Drag.active = true;
                }
                onPositionChanged: {
                    pinTooltip.updateAnchor();
                }
                onReleased: {
                    if (!dragArea.drag.active) {
                        trayButton.click();
                    } else {
                        if (pinDropArea.containsDrag && pinDropArea.willPin) {
                            // Quickshell would crash if we don't hide this item first. Took me fucking 3 hours to figure out...
                            trayButton.visible = false;
                            TrayService.togglePin(trayButton.item.id);
                            pinDropArea.willPin = false;
                        } else {
                            trayButton.x = trayButton.initialX;
                            trayButton.y = trayButton.initialY;
                        }
                    }
                    trayButton.Drag.active = false;
                    root.dragging = false;
                }
            }

            BarToolTip {
                id: pinTooltip
                extraVisibleCondition: trayButton.Drag.active && pinDropArea.containsDrag && pinDropArea.willPin
                horizontalPadding: 6
                verticalPadding: 6
                realContentItem: FluentIcon {
                    anchors.centerIn: parent
                    icon: "pin-off"
                    implicitSize: 18
                }
            }
        }
    }
}
