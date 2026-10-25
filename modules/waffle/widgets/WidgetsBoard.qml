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
    readonly property var heightBySize: ({
            small: 90,
            medium: 188,
            large: 288
        })
    readonly property var placements: {
        const heights = new Array(root.columnCount).fill(0);
        const pending = Config.options.waffles.widgets.order.filter(id => root.knownWidgets.includes(id)).map(id => {
            const size = Config.options.waffles.widgets[id]?.size ?? "medium";
            return {
                id: id,
                columns: size === "large" ? 2 : 1,
                height: root.heightBySize[size] ?? root.heightBySize.medium
            };
        });
        const bestPair = () => {
            let best = null;
            for (let column = 0; column + 1 < root.columnCount; column++) {
                const y = Math.max(heights[column], heights[column + 1]);
                const waste = Math.abs(heights[column] - heights[column + 1]);
                if (best === null || waste < best.waste || (waste === best.waste && y < best.y))
                    best = {
                        column: column,
                        y: y,
                        waste: waste
                    };
            }
            return best;
        };
        const result = [];
        while (pending.length > 0) {
            const narrowIndex = pending.findIndex(item => item.columns === 1);
            const wideIndex = pending.findIndex(item => item.columns === 2);
            const pair = wideIndex >= 0 ? bestPair() : null;
            if (wideIndex >= 0 && (narrowIndex < 0 || pair.waste <= root.gap)) {
                const item = pending.splice(wideIndex, 1)[0];
                result.push({
                    id: item.id,
                    column: pair.column,
                    columns: 2,
                    y: pair.y,
                    height: item.height
                });
                heights[pair.column] = pair.y + item.height + root.gap;
                heights[pair.column + 1] = heights[pair.column];
            } else {
                const item = pending.splice(narrowIndex, 1)[0];
                const column = heights.indexOf(Math.min(...heights));
                result.push({
                    id: item.id,
                    column: column,
                    columns: 1,
                    y: heights[column],
                    height: item.height
                });
                heights[column] += item.height + root.gap;
            }
        }
        return result;
    }
    readonly property real boardHeight: placements.reduce((max, item) => Math.max(max, item.y + item.height), 0)

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
                height: root.boardHeight

                Repeater {
                    model: root.placements

                    delegate: Item {
                        id: cell

                        required property var modelData

                        x: modelData.column * (root.cellWidth + root.gap)
                        y: modelData.y
                        width: root.cellWidth * modelData.columns + root.gap * (modelData.columns - 1)
                        height: modelData.height

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
