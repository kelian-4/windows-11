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

    readonly property var knownWidgets: ["weather", "calendar", "todo", "stocks", "sports", "photos"]
    readonly property var placements: {
        const spans = {
            small: {
                columns: 1,
                rows: 1
            },
            medium: {
                columns: 1,
                rows: 2
            },
            large: {
                columns: 2,
                rows: 4
            }
        };
        const occupied = [];
        const isFree = (row, column, columns, rows) => {
            for (let r = row; r < row + rows; r++) {
                for (let c = column; c < column + columns; c++) {
                    if (occupied[r]?.[c])
                        return false;
                }
            }
            return true;
        };
        const pending = Config.options.waffles.widgets.order.filter(id => root.knownWidgets.includes(id)).map(id => ({
                    id: id,
                    span: spans[Config.options.waffles.widgets[id]?.size] ?? spans.medium
                }));
        const result = [];
        for (let row = 0; pending.length > 0; row++) {
            for (let column = 0; column < root.columnCount && pending.length > 0; column++) {
                if (occupied[row]?.[column])
                    continue;
                const index = pending.findIndex(item => column + item.span.columns <= root.columnCount && isFree(row, column, item.span.columns, item.span.rows));
                if (index < 0)
                    continue;
                const item = pending.splice(index, 1)[0];
                for (let r = row; r < row + item.span.rows; r++) {
                    occupied[r] = occupied[r] ?? [];
                    for (let c = column; c < column + item.span.columns; c++)
                        occupied[r][c] = true;
                }
                result.push({
                    id: item.id,
                    row: row,
                    column: column,
                    columnSpan: item.span.columns,
                    rowSpan: item.span.rows
                });
            }
        }
        return result;
    }
    readonly property int rowCount: placements.reduce((max, item) => Math.max(max, item.row + item.rowSpan), 0)

    implicitWidth: columnCount * cellWidth + (columnCount - 1) * gap + 24

    ColumnLayout {
        anchors {
            fill: parent
            margins: 12
        }
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
            contentHeight: board.height

            Item {
                id: board

                width: parent.width
                height: Math.max(0, root.rowCount * (root.rowUnit + root.gap) - root.gap)

                Repeater {
                    model: root.placements

                    delegate: Item {
                        id: cell

                        required property var modelData

                        x: modelData.column * (root.cellWidth + root.gap)
                        y: modelData.row * (root.rowUnit + root.gap)
                        width: root.cellWidth * modelData.columnSpan + root.gap * (modelData.columnSpan - 1)
                        height: root.rowUnit * modelData.rowSpan + root.gap * (modelData.rowSpan - 1)

                        Loader {
                            anchors.fill: parent
                            sourceComponent: {
                                switch (cell.modelData.id) {
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
