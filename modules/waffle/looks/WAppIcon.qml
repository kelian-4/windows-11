import QtQuick
import QtQuick.Effects
import Quickshell
import qs.services
import qs.modules.common
import qs.modules.common.functions

Item {
    id: root

    required property string iconName
    property bool separateLightDark: false
    property bool tryCustomIcon: true
    property string fallback: iconName
    property bool isMask: false
    property bool animated: true

    property real implicitSize: 26
    implicitWidth: implicitSize
    implicitHeight: implicitSize

    property bool _useFallback: !root.tryCustomIcon

    Image {
        id: img
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        smooth: true
        asynchronous: true
        source: {
            if (root._useFallback)
                return Quickshell.iconPath(root.fallback, "image-missing");
            if (root.iconName.startsWith("/"))
                return Qt.resolvedUrl(root.iconName);
            return `${Looks.iconsPath}/${root.iconName}${!root.separateLightDark ? "" : (Looks.dark ? "-dark" : "-light")}.svg`;
        }
        onStatusChanged: {
            if (status === Image.Error && !root._useFallback)
                root._useFallback = true;
        }

        layer.enabled: root.isMask
        layer.effect: MultiEffect {
            brightness: ColorUtils.isDark(Looks.colors.fg) ? -1.0 : 1.0
        }
    }
}
