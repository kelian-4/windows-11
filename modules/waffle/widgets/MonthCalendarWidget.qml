pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.modules.common
import qs.modules.common.widgets
import qs.modules.waffle.looks

WidgetCard {
    id: root

    readonly property var calendarLocale: Qt.locale(Config.options.calendar.locale)
    readonly property real gridWidth: 7 * calendarView.buttonSize + 6 * calendarView.buttonSpacing

    widgetId: "calendar"
    showHeader: false
    allowedSizes: ["large"]

    ColumnLayout {
        anchors.fill: parent
        spacing: 4

        RowLayout {
            Layout.fillWidth: true
            spacing: 2

            WText {
                Layout.fillWidth: true
                text: root.calendarLocale.toString(calendarView.focusedDate, "MMMM yyyy")
                font.pixelSize: Looks.font.pixelSize.large
                font.weight: Looks.font.weight.strong
            }

            WBorderlessButton {
                implicitWidth: 32
                implicitHeight: 32
                onClicked: calendarView.scrollMonthsAndSnap(-1)
                contentItem: FluentIcon {
                    icon: "chevron-up"
                    implicitSize: 16
                }
            }

            WBorderlessButton {
                implicitWidth: 32
                implicitHeight: 32
                onClicked: calendarView.scrollMonthsAndSnap(1)
                contentItem: FluentIcon {
                    icon: "chevron-down"
                    implicitSize: 16
                }
            }

            Item {
                implicitWidth: 24
            }
        }

        DayOfWeekRow {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: root.gridWidth
            locale: root.calendarLocale
            spacing: calendarView.buttonSpacing
            delegate: Item {
                id: dayOfWeekItem
                required property var model
                implicitWidth: calendarView.buttonSize
                implicitHeight: calendarView.buttonSize
                WText {
                    anchors.centerIn: parent
                    text: dayOfWeekItem.model.shortName.substring(0, 2)
                    color: Looks.colors.subfg
                }
            }
        }

        CalendarView {
            id: calendarView
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: root.gridWidth
            locale: root.calendarLocale
            buttonSize: 30
            buttonSpacing: 8
            buttonVerticalSpacing: 2
            delegate: CalendarDayButton {
                focusedMonth: calendarView.focusedMonth
                size: calendarView.buttonSize
            }
        }

        Item {
            Layout.fillHeight: true
        }
    }
}
