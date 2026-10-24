import QtQuick
import QtQuick.Layouts
import qs.services
import qs.modules.common
import qs.modules.waffle.looks

WidgetCard {
    id: root

    readonly property bool up: Stocks.change >= 0
    readonly property color trendColor: up ? "#2E9E5B" : "#D13438"

    widgetId: "stocks"
    allowedSizes: ["small"]
    title: Stocks.data.loaded ? Stocks.data.name : Translation.tr("Stocks")

    RowLayout {
        anchors.fill: parent
        spacing: 8

        ColumnLayout {
            spacing: 0

            WText {
                text: Stocks.data.loaded ? Stocks.data.price.toFixed(2) : "--"
                font.pixelSize: Looks.font.pixelSize.xlarger
                font.weight: Looks.font.weight.strong
            }

            WText {
                visible: Stocks.data.loaded
                text: (Stocks.change >= 0 ? "+" : "") + Stocks.changePercent.toFixed(2) + "%"
                color: root.trendColor
                font.pixelSize: Looks.font.pixelSize.normal
            }
        }

        Sparkline {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.bottomMargin: 4
            values: Stocks.data.closes
            lineColor: root.trendColor
        }
    }
}
