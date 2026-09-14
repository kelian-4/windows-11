import QtQuick
import Quickshell
import Quickshell.Widgets
import QtQuick.Effects
import qs.modules.common.functions

Item {
    id: root
    
    property bool colorize: false
    property color color
    property string source: ""
    property string iconFolder: Qt.resolvedUrl(Quickshell.shellPath("assets/icons"))  // The folder to check first
    width: 30
    height: 30
    
    IconImage {
        id: iconImage
        anchors.fill: parent
        source: {
            const fullPathWhenSourceIsIconName = iconFolder + "/" + root.source;
            if (iconFolder && fullPathWhenSourceIsIconName) {
                return fullPathWhenSourceIsIconName
            }
            return root.source
        }
        implicitSize: root.height

        // See FluentIcon.qml for why this is a simple brightness push
        // rather than colorization/masking.
        layer.enabled: root.colorize
        layer.effect: MultiEffect {
            brightness: ColorUtils.isDark(root.color) ? -1.0 : 1.0
        }
    }
}
