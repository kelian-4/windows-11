import QtQuick
import QtQuick.Layouts
import qs
import qs.services
import qs.modules.common
import qs.modules.waffle.looks

BarButton {
    id: root

    rightInset: Looks.barVertical ? 8 : 12 // For now this is the rightmost button. Desktop peek is useless. (for now)
    leftPadding: Looks.barVertical ? 4 : 12
    rightPadding: Looks.barVertical ? 4 : 22

    checked: GlobalStates.sidebarRightOpen
    onClicked: {
        GlobalStates.sidebarRightOpen = !GlobalStates.sidebarRightOpen;
    }

    contentItem: Item {
        // anchors.centerIn: parent
        implicitHeight: Looks.barVertical ? verticalLayout.implicitHeight : contentLayout.implicitHeight
        implicitWidth: Looks.barVertical ? verticalLayout.implicitWidth : contentLayout.implicitWidth

        Column {
            id: verticalLayout
            visible: Looks.barVertical
            anchors.centerIn: parent
            spacing: 2

            WText {
                anchors.horizontalCenter: parent.horizontalCenter
                text: DateTime.time
            }
            WText {
                width: Math.max(0, root.width - root.leftInset - root.rightInset - 8)
                horizontalAlignment: Text.AlignHCenter
                fontSizeMode: Text.HorizontalFit
                minimumPixelSize: 7
                font.pixelSize: Looks.font.pixelSize.small
                text: DateTime.date
            }
            FluentIcon {
                visible: Notifications.silent
                anchors.horizontalCenter: parent.horizontalCenter
                icon: "alert-snooze"
                implicitSize: 16
                filled: true
            }
        }

        Row {
            id: contentLayout
            visible: !Looks.barVertical
            anchors.centerIn: parent
            spacing: 7
            
            Column {
                anchors.verticalCenter: parent.verticalCenter
                WText {
                    anchors.right: parent.right
                    text: DateTime.time
                }
                WText {
                    anchors.right: parent.right
                    text: DateTime.date
                }
            }
            FluentIcon {
                visible: Notifications.silent
                anchors.verticalCenter: parent.verticalCenter
                icon: "alert-snooze"
                implicitSize: 18
                filled: true
            }
        }
    }

    BarToolTip {
        id: tooltip
        extraVisibleCondition: root.shouldShowTooltip
        text: `${Qt.locale().toString(DateTime.clock.date, "dddd, MMMM d, yyyy")}\n\n${Qt.locale().toString(DateTime.clock.date, "ddd hh:mm AP")}`
    }
}
