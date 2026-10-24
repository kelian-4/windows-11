pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.services
import qs.modules.common
import qs.modules.waffle.looks

Item {
    id: root

    readonly property real cellWidth: 172
    readonly property real rowUnit: 96
    readonly property real gap: 8
    readonly property int columnCount: 3
    readonly property string greeting: {
        const hour = new Date().getHours();
        if (hour < 12)
            return Translation.tr("Good morning, %1");
        if (hour < 18)
            return Translation.tr("Good afternoon, %1");
        return Translation.tr("Good evening, %1");
    }

    function addWidget(widgetId) {
        const order = Config.options.waffles.widgets.order;
        if (order.includes(widgetId))
            return;
        Config.options.waffles.widgets.order = order.concat([widgetId]);
    }

    implicitWidth: sidebar.implicitWidth + columnCount * cellWidth + (columnCount - 1) * gap + 24

    RowLayout {
        anchors.fill: parent
        spacing: 0

        WidgetsSidebar {
            id: sidebar
            Layout.fillHeight: true
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.topMargin: 12
            Layout.rightMargin: 12
            spacing: 12

            RowLayout {
                Layout.fillWidth: true
                spacing: 4

                WText {
                    Layout.fillWidth: true
                    text: root.greeting.arg(SystemInfo.username)
                    elide: Text.ElideRight
                    font.pixelSize: Looks.font.pixelSize.xlarger
                    font.weight: Looks.font.weight.strong
                }

                WBorderlessButton {
                    implicitWidth: 32
                    implicitHeight: 32
                    onClicked: Weather.getData()
                    contentItem: FluentIcon {
                        icon: "arrow-sync"
                        implicitSize: 16
                    }
                }

                WBorderlessButton {
                    id: addButton
                    implicitWidth: 32
                    implicitHeight: 32
                    onClicked: addMenu.visible = !addMenu.visible
                    contentItem: FluentIcon {
                        icon: "add"
                        implicitSize: 16
                    }

                    WMenu {
                        id: addMenu
                        downDirection: true
                        x: addButton.width - addMenu.implicitWidth
                        y: addButton.height

                        Action {
                            enabled: !Config.options.waffles.widgets.order.includes("weather")
                            text: Translation.tr("Weather")
                            onTriggered: root.addWidget("weather")
                        }
                        Action {
                            enabled: !Config.options.waffles.widgets.order.includes("calendar")
                            text: Translation.tr("Calendar")
                            onTriggered: root.addWidget("calendar")
                        }
                        Action {
                            enabled: !Config.options.waffles.widgets.order.includes("todo")
                            text: Translation.tr("To Do")
                            onTriggered: root.addWidget("todo")
                        }
                        Action {
                            enabled: !Config.options.waffles.widgets.order.includes("stocks")
                            text: Translation.tr("Stocks")
                            onTriggered: root.addWidget("stocks")
                        }
                        Action {
                            enabled: !Config.options.waffles.widgets.order.includes("sports")
                            text: Translation.tr("Sports")
                            onTriggered: root.addWidget("sports")
                        }
                        Action {
                            enabled: !Config.options.waffles.widgets.order.includes("photos")
                            text: Translation.tr("Photos")
                            onTriggered: root.addWidget("photos")
                        }
                    }
                }

                WUserAvatar {
                    sourceSize: Qt.size(28, 28)
                }
            }

            Flickable {
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
                boundsBehavior: Flickable.StopAtBounds
                contentWidth: width
                contentHeight: grid.implicitHeight

                GridLayout {
                    id: grid
                    width: parent.width
                    columns: root.columnCount
                    columnSpacing: root.gap
                    rowSpacing: root.gap

                    Repeater {
                        model: Config.options.waffles.widgets.order

                        delegate: Item {
                            id: cell

                            required property string modelData

                            readonly property string size: Config.options.waffles.widgets[modelData]?.size ?? "medium"
                            readonly property int columnSpan: size === "large" ? 2 : 1
                            readonly property int rowSpan: size === "small" ? 1 : (size === "medium" ? 2 : 4)

                            Layout.columnSpan: columnSpan
                            Layout.rowSpan: rowSpan
                            Layout.preferredWidth: root.cellWidth * columnSpan + root.gap * (columnSpan - 1)
                            Layout.preferredHeight: root.rowUnit * rowSpan + root.gap * (rowSpan - 1)

                            Loader {
                                anchors.fill: parent
                                sourceComponent: {
                                    switch (cell.modelData) {
                                    case "weather":
                                        return weatherComponent;
                                    case "calendar":
                                        return calendarComponent;
                                    case "todo":
                                        return todoComponent;
                                    case "stocks":
                                        return stocksComponent;
                                    case "sports":
                                        return sportsComponent;
                                    case "photos":
                                        return photosComponent;
                                    default:
                                        return null;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    Component {
        id: weatherComponent
        WeatherWidget {}
    }

    Component {
        id: calendarComponent
        MonthCalendarWidget {}
    }

    Component {
        id: todoComponent
        TodoWidget {}
    }

    Component {
        id: stocksComponent
        StocksWidget {}
    }

    Component {
        id: sportsComponent
        SportsWidget {}
    }

    Component {
        id: photosComponent
        PhotosWidget {}
    }
}
