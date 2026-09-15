import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell
import qs.services
import qs.modules.common
import qs.modules.common.widgets
import qs.modules.common.functions
import qs.modules.waffle.looks

Item {
    id: root

    property string icon: ""
    property real implicitSize: 16
    implicitWidth: implicitSize
    implicitHeight: implicitSize

    readonly property bool useFallback: !root.icon
    property bool _iconLoadFailed: false

    Image {
        id: appIconImg
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        smooth: true
        asynchronous: true
        visible: !root.useFallback && !root._iconLoadFailed
        source: root.useFallback ? "" : root.icon
        onStatusChanged: {
            if (status === Image.Error)
                root._iconLoadFailed = true;
        }
    }

    Image {
        id: fallbackImg
        anchors.fill: parent
        visible: root.useFallback || root._iconLoadFailed
        fillMode: Image.PreserveAspectFit
        source: root.useFallback
                ? `${Looks.iconsPath}/apps.svg`
                : (root._iconLoadFailed ? Quickshell.iconPath(root.icon, "image-missing") : "")

        layer.enabled: visible
        layer.effect: MultiEffect {
            brightness: ColorUtils.isDark(Looks.colors.fg) ? -1.0 : 1.0
        }
    }
}
