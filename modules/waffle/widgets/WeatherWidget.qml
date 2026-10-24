import QtQuick
import QtQuick.Layouts
import qs.services
import qs.modules.common
import qs.modules.common.widgets
import qs.modules.waffle.looks

WidgetCard {
    id: root

    widgetId: "weather"
    title: Weather.data.city

    ColumnLayout {
        anchors.fill: parent
        spacing: 4

        RowLayout {
            Layout.fillWidth: true
            spacing: 8

            MaterialSymbol {
                text: Icons.getWeatherIcon(Weather.data.wCode) ?? "cloud"
                iconSize: 36
                color: Looks.colors.fg
            }

            WText {
                text: Weather.data.temp
                font.pixelSize: 28
                font.weight: Looks.font.weight.strong
            }
        }

        WText {
            visible: root.size !== "small"
            text: Translation.tr("Feels like %1").arg(Weather.data.tempFeelsLike)
            color: Looks.colors.subfg
        }

        WText {
            visible: root.size !== "small"
            text: Translation.tr("Humidity %1").arg(Weather.data.humidity)
            color: Looks.colors.subfg
        }

        WText {
            visible: root.size !== "small"
            text: Translation.tr("Wind %1").arg(Weather.data.wind)
            color: Looks.colors.subfg
        }

        WText {
            visible: root.size === "medium" || root.size === "large"
            text: Translation.tr("Precipitation %1").arg(Weather.data.precip)
            color: Looks.colors.subfg
        }

        Item {
            Layout.fillHeight: true
        }
    }
}
