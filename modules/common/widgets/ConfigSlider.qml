import QtQuick
import QtQuick.Layouts
import qs.modules.common
import qs.modules.waffle.looks
import qs.modules.waffle.settings

Rectangle {
    id: root

    property string text: ""
    property string buttonIcon: ""
    property alias value: slider.value
    property var stopIndicatorValues: []
    property bool usePercentTooltip: true
    property alias from: slider.from
    property alias to: slider.to
    property real textWidth: 140

    Layout.fillWidth: true
    implicitHeight: 56
    radius: Looks.radius.medium
    color: Looks.colors.bg1Base
    border.width: 1
    border.color: Looks.colors.bgPanelSeparator

    RowLayout {
        anchors {
            fill: parent
            leftMargin: 18
            rightMargin: 18
        }
        spacing: 16

        SettingsIcon {
            visible: icon.length > 0
            icon: MaterialIconMap.fluent(root.buttonIcon)
            size: 20
            Layout.alignment: Qt.AlignVCenter
        }

        WText {
            Layout.preferredWidth: root.textWidth
            Layout.alignment: Qt.AlignVCenter
            text: root.text
            elide: Text.ElideRight
            font.pixelSize: Looks.font.pixelSize.large
        }

        WSlider {
            id: slider
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter
            stepSize: root.usePercentTooltip ? 0.01 : 1
            scrollable: false
            tooltipContent: root.usePercentTooltip ? `${Math.round(slider.value * 100)}%` : `${Math.round(slider.value)}`
        }

        WText {
            Layout.preferredWidth: 44
            horizontalAlignment: Text.AlignRight
            Layout.alignment: Qt.AlignVCenter
            text: root.usePercentTooltip ? `${Math.round(slider.value * 100)}%` : `${Math.round(slider.value)}`
            color: Looks.colors.fg1
            font.pixelSize: Looks.font.pixelSize.large
        }
    }
}
