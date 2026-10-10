import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.modules.common
import qs.modules.waffle.looks
import qs.modules.waffle.settings

Button {
    id: root
    property string buttonIcon
    property string buttonText
    property bool toggled: false
    property bool leftmost: false
    property bool rightmost: false

    implicitHeight: 34
    leftPadding: 14
    rightPadding: 14
    topPadding: 0
    bottomPadding: 0
    hoverEnabled: true
    text: buttonText

    background: Rectangle {
        radius: Looks.radius.medium
        border.width: 1
        border.color: root.toggled ? Looks.colors.accent : Looks.colors.bg2Border
        color: {
            if (root.toggled) return root.down ? Looks.colors.accentActive : (root.hovered ? Looks.colors.accentHover : Looks.colors.accent);
            if (root.down) return Looks.colors.bg2Active;
            if (root.hovered) return Looks.colors.bg2Hover;
            return Looks.colors.bg2Base;
        }

        Behavior on color {
            animation: Looks.transition.color.createObject(this)
        }
    }

    contentItem: RowLayout {
        spacing: 8

        SettingsIcon {
            visible: icon.length > 0
            icon: MaterialIconMap.fluent(root.buttonIcon)
            size: 16
            tint: root.toggled ? Looks.colors.accentFg : Looks.colors.fg
            Layout.alignment: Qt.AlignVCenter
        }

        WText {
            visible: root.buttonText && root.buttonText.length > 0
            text: root.buttonText
            color: root.toggled ? Looks.colors.accentFg : Looks.colors.fg
            Layout.alignment: Qt.AlignVCenter
            font.pixelSize: Looks.font.pixelSize.large
        }
    }
}
