import QtQuick
import qs.modules.common
import qs.modules.common.widgets
import qs.modules.waffle.looks

Item {
    id: root

    property string material: ""
    property string fluent: ""
    property real size: 16
    property color color: Appearance.colors.colOnLayer0

    readonly property bool waffle: Config.options.panelFamily === "waffle"

    implicitWidth: size
    implicitHeight: size

    Loader {
        anchors.fill: parent
        active: root.waffle
        sourceComponent: FluentIcon {
            anchors.centerIn: parent
            icon: root.fluent
            implicitSize: root.size
            color: root.color
        }
    }

    Loader {
        anchors.centerIn: parent
        active: !root.waffle
        sourceComponent: MaterialSymbol {
            text: root.material
            iconSize: root.size
            color: root.color
        }
    }
}
