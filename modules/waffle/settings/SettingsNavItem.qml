import QtQuick
import QtQuick.Layouts
import qs.modules.waffle.looks

Item {
    id: root

    property string icon: ""
    property color iconTint: Looks.colors.fg
    property string text: ""
    property bool selected: false

    signal clicked()

    Layout.fillWidth: true
    implicitHeight: 40

    Rectangle {
        id: background
        anchors {
            fill: parent
            topMargin: 1
            bottomMargin: 1
        }
        radius: Looks.radius.medium
        color: {
            if (mouse.pressed) return Looks.colors.bg1Active;
            if (root.selected) return Looks.colors.bg1Base;
            if (mouse.containsMouse) return Looks.colors.bg1Hover;
            return "transparent";
        }

        Behavior on color {
            animation: Looks.transition.color.createObject(this)
        }

        Rectangle {
            anchors.verticalCenter: parent.verticalCenter
            x: 0
            width: 3
            radius: 2
            height: root.selected ? 16 : 0
            color: Looks.colors.accent

            Behavior on height {
                animation: Looks.transition.resize.createObject(this)
            }
        }

        RowLayout {
            anchors {
                fill: parent
                leftMargin: 12
                rightMargin: 12
            }
            spacing: 12

            SettingsIcon {
                icon: root.icon
                tint: root.iconTint
                size: 20
                Layout.alignment: Qt.AlignVCenter
            }

            WText {
                Layout.fillWidth: true
                text: root.text
                elide: Text.ElideRight
                font.pixelSize: Looks.font.pixelSize.large
            }
        }
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true
        onClicked: root.clicked()
    }
}
