import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.modules.common
import qs.modules.waffle.looks
import qs.modules.waffle.settings

Button {
    id: root
    property string buttonIcon
    property alias iconSize: iconWidget.size

    Layout.fillWidth: true
    implicitHeight: Math.max(52, contentItem.implicitHeight + 24)
    padding: 0
    leftPadding: 18
    rightPadding: 18
    hoverEnabled: true
    font.pixelSize: Looks.font.pixelSize.large

    onClicked: checked = !checked

    background: Rectangle {
        radius: Looks.radius.medium
        border.width: 1
        border.color: Looks.colors.bgPanelSeparator
        color: {
            if (!root.enabled) return Looks.colors.bg1Base;
            if (root.down) return Looks.colors.bg2Active;
            if (root.hovered) return Looks.colors.bg2Hover;
            return Looks.colors.bg1Base;
        }

        Behavior on color {
            animation: Looks.transition.color.createObject(this)
        }
    }

    contentItem: RowLayout {
        spacing: 16
        opacity: root.enabled ? 1 : 0.4

        SettingsIcon {
            id: iconWidget
            visible: icon.length > 0
            icon: MaterialIconMap.fluent(root.buttonIcon)
            size: 20
            Layout.alignment: Qt.AlignVCenter
        }

        WText {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter
            text: root.text
            wrapMode: Text.WordWrap
            font: root.font
        }

        WText {
            text: switchWidget.checked ? "On" : "Off"
            Layout.alignment: Qt.AlignVCenter
            font.pixelSize: Looks.font.pixelSize.large
        }

        WSwitch {
            id: switchWidget
            Layout.alignment: Qt.AlignVCenter
            checkable: false
            checked: root.checked
            onClicked: root.clicked()
        }
    }
}
