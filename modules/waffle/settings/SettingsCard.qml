import QtQuick
import QtQuick.Layouts
import qs.modules.waffle.looks

Rectangle {
    id: root

    property string icon: ""
    property color iconTint: Looks.colors.fg
    property string title: ""
    property string subtitle: ""
    property bool chevron: true
    property bool clickable: chevron
    default property alias trailing: trailingRow.data

    signal clicked()

    Layout.fillWidth: true
    implicitHeight: subtitle.length > 0 ? 68 : 60
    radius: Looks.radius.medium
    border.width: 1
    border.color: Looks.colors.bgPanelSeparator
    color: {
        if (!root.clickable) return Looks.colors.bg1Base;
        if (mouse.pressed) return Looks.colors.bg2Active;
        if (mouse.containsMouse) return Looks.colors.bg2Hover;
        return Looks.colors.bg1Base;
    }

    Behavior on color {
        animation: Looks.transition.color.createObject(this)
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true
        enabled: root.clickable
        onClicked: root.clicked()
    }

    RowLayout {
        anchors {
            fill: parent
            leftMargin: 18
            rightMargin: 18
        }
        spacing: 16

        SettingsIcon {
            visible: root.icon.length > 0
            icon: root.icon
            tint: root.iconTint
            size: 20
            Layout.alignment: Qt.AlignVCenter
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter
            spacing: 0

            WText {
                Layout.fillWidth: true
                text: root.title
                elide: Text.ElideRight
                font.pixelSize: Looks.font.pixelSize.large
            }

            WText {
                Layout.fillWidth: true
                visible: root.subtitle.length > 0
                text: root.subtitle
                elide: Text.ElideRight
                color: Looks.colors.fg1
                font.pixelSize: Looks.font.pixelSize.normal
            }
        }

        RowLayout {
            id: trailingRow
            spacing: 12
            Layout.alignment: Qt.AlignVCenter
        }

        FluentIcon {
            visible: root.chevron
            icon: "chevron-right"
            implicitSize: 14
            color: Looks.colors.fg1
            Layout.alignment: Qt.AlignVCenter
        }
    }
}
