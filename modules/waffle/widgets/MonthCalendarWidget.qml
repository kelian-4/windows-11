pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.modules.common
import qs.modules.common.widgets
import qs.modules.waffle.looks

WidgetCard {
    id: root

    widgetId: "calendar"
    title: Qt.locale(Config.options.calendar.locale).toString(calendarView.focusedDate, "MMMM yyyy")
    allowedSizes: ["large"]

    readonly property var locale: Qt.locale(Config.options.calendar.locale)

    ColumnLayout {
        anchors.fill: parent
        spacing: 4

        RowLayout {
            Layout.fillWidth: true
            spacing: 4

            Item {
                Layout.fillWidth: true
            }

            WBorderlessButton {
                implicitWidth: 28
                implicitHeight: 28
                onClicked: calendarView.scrollMonthsAndSnap(-1)
                contentItem: FluentIcon {
                    icon: "caret-up"
                    filled: true
                    implicitSize: 12
                }
            }

            WBorderlessButton {
                implicitWidth: 28
                implicitHeight: 28
                onClicked: calendarView.scrollMonthsAndSnap(1)
                contentItem: FluentIcon {
                    icon: "caret-down"
                    filled: true
                    implicitSize: 12
                }
            }
        }

        DayOfWeekRow {
            Layout.fillWidth: true
            locale: root.locale
            spacing: calendarView.buttonSpacing
            implicitHeight: calendarView.buttonSize
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
            Layout.fillWidth: true
            locale: root.locale
            buttonSize: 30
            buttonSpacing: 6
            buttonVerticalSpacing: 1
            delegate: DayButton {}
        }

        Item {
            Layout.fillHeight: true
        }
    }

    component DayButton: WButton {
        id: dayButton
        required property var model
        checked: model.today
        enabled: hovered || checked || model.month === calendarView.focusedMonth
        implicitWidth: calendarView.buttonSize
        implicitHeight: calendarView.buttonSize
        radius: height / 2

        contentItem: Item {
            WText {
                anchors.centerIn: parent
                text: dayButton.model.day
                color: dayButton.fgColor
            }
        }
    }
}
