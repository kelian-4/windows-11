import QtQuick
import QtQuick.Controls
import qs.modules.waffle.looks

Button {
    id: root

    property bool accent: false

    implicitHeight: 32
    leftPadding: 16
    rightPadding: 16
    topPadding: 0
    bottomPadding: 0
    hoverEnabled: true

    background: Rectangle {
        radius: Looks.radius.medium
        border.width: root.accent ? 0 : 1
        border.color: Looks.colors.bg2Border
        color: {
            if (!root.enabled) return Looks.colors.bg1Base;
            if (root.accent) return root.down ? Looks.colors.accentActive : (root.hovered ? Looks.colors.accentHover : Looks.colors.accent);
            if (root.down) return Looks.colors.bg2Active;
            if (root.hovered) return Looks.colors.bg2Hover;
            return Looks.colors.bg2Base;
        }
    }

    contentItem: WText {
        text: root.text
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: root.accent ? Looks.colors.accentFg : Looks.colors.fg
        opacity: root.enabled ? 1 : 0.4
        font.pixelSize: Looks.font.pixelSize.large
    }
}
