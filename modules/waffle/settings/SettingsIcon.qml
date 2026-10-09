import QtQuick
import QtQuick.Effects
import Quickshell
import qs.modules.waffle.looks

Item {
    id: root

    required property string icon
    property color tint: Looks.colors.fg
    property int size: 20

    implicitWidth: size
    implicitHeight: size

    Image {
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        smooth: true
        asynchronous: true
        sourceSize: Qt.size(root.size * 2, root.size * 2)
        source: FluentIconManifest.has(root.icon) ? `${Looks.iconsPath}/${root.icon}.svg` : Quickshell.iconPath(root.icon, "image-missing")

        layer.enabled: true
        layer.effect: MultiEffect {
            brightness: 1.0
            colorization: 1.0
            colorizationColor: root.tint
        }
    }
}
