pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.modules.common
import qs.modules.waffle.looks

WidgetCard {
    id: root

    readonly property bool loaded: Weather.data.lastRefresh !== 0
    readonly property int nowHour: new Date().getHours()

    widgetId: "weather"
    allowedSizes: ["small", "medium"]
    title: loaded ? Weather.data.city : Translation.tr("Weather")
    textColor: "#1B1B1B"
    subTextColor: "#43515F"
    border.color: "#E8EFF9"
    gradient: Gradient {
        GradientStop {
            position: 0.0
            color: "#ADD1F3"
        }
        GradientStop {
            position: 1.0
            color: "#CFE5FA"
        }
    }

    function hourLabel(hour, index) {
        if (index === 0)
            return Translation.tr("Now");
        return Qt.formatTime(new Date(2000, 0, 1, hour), "hAP");
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 4

        RowLayout {
            Layout.fillWidth: true
            spacing: 8

            FluentIcon {
                visible: root.loaded
                icon: WeatherIcons.iconFor(Weather.data.wCode, root.nowHour)
                implicitSize: 30
                color: root.textColor
            }

            WText {
                text: root.loaded ? Weather.data.temp.replace(/[CF]$/, "") : "--"
                color: root.textColor
                font.pixelSize: 30
                font.weight: Looks.font.weight.strong
            }

            Item {
                Layout.fillWidth: true
            }
        }

        WText {
            Layout.fillWidth: true
            visible: root.loaded
            text: Weather.data.desc + (Weather.data.high !== "" ? "  •  " + Translation.tr("H %1° L %2°").arg(Weather.data.high).arg(Weather.data.low) : "")
            color: root.subTextColor
            elide: Text.ElideRight
            font.pixelSize: 10
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            visible: root.size === "medium"
            radius: 14
            color: "#D3E9FC"

            RowLayout {
                anchors {
                    fill: parent
                    margins: 6
                }
                spacing: 0
                uniformCellSizes: true

                Repeater {
                    model: Weather.data.hourly

                    delegate: ColumnLayout {
                        id: slot

                        required property var modelData
                        required property int index

                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.preferredWidth: 0
                        Layout.minimumWidth: 0
                        spacing: 4

                        WText {
                            Layout.alignment: Qt.AlignHCenter
                            text: root.hourLabel(slot.modelData.hour, slot.index)
                            color: root.subTextColor
                            font.pixelSize: 9
                        }

                        FluentIcon {
                            Layout.alignment: Qt.AlignHCenter
                            icon: WeatherIcons.iconFor(slot.modelData.wCode, slot.modelData.hour)
                            implicitSize: 18
                            color: root.textColor
                        }

                        WText {
                            Layout.alignment: Qt.AlignHCenter
                            text: slot.modelData.temp
                            color: root.textColor
                            font.pixelSize: Looks.font.pixelSize.normal
                            font.weight: Looks.font.weight.strong
                        }

                        WText {
                            Layout.alignment: Qt.AlignHCenter
                            text: slot.modelData.rain
                            color: root.subTextColor
                            font.pixelSize: 10
                        }

                        Item {
                            Layout.fillHeight: true
                        }
                    }
                }
            }
        }

        Item {
            Layout.fillHeight: true
            visible: root.size !== "medium"
        }
    }
}
