import QtQuick
import QtQuick.Effects
import Quickshell
import qs.modules.common
import qs.modules.common.functions
import qs.modules.waffle.looks

Item {
    id: root

    required property string icon
    property bool filled: false
    property bool monochrome: true
    property int implicitSize: 20
    property color color: Looks.colors.fg
    property bool animated: true
    property alias source: img.source
    implicitWidth: implicitSize
    implicitHeight: implicitSize

    property bool _useFallback: false

    Image {
        id: img
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        smooth: true
        asynchronous: true
        source: {
            if (root.icon === "")
                return "";
            if (root._useFallback || !FluentIconManifest.has(root.icon))
                return Quickshell.iconPath(root.icon, "image-missing");
            return `${Looks.iconsPath}/${root.icon}${root.filled ? "-filled" : ""}.svg`;
        }
        onStatusChanged: {
            if (status === Image.Error && !root._useFallback)
                root._useFallback = true;
        }

        layer.enabled: root.monochrome
        layer.effect: MultiEffect {
            brightness: ColorUtils.isDark(root.color) ? -1.0 : 1.0
        }
    }
}
