import QtQuick
import QtQuick.Layouts
import qs.services
import qs.modules.waffle.looks

Rectangle {
    id: root

    property alias text: input.text
    property string placeholder: Translation.tr("Find a setting")

    implicitHeight: 32
    radius: Looks.radius.medium
    color: input.activeFocus ? Looks.colors.bg0Base : Looks.colors.bg1Base
    border.width: 1
    border.color: Looks.colors.bgPanelSeparator

    Behavior on color {
        animation: Looks.transition.color.createObject(this)
    }

    Rectangle {
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        height: input.activeFocus ? 2 : 1
        radius: 1
        color: input.activeFocus ? Looks.colors.accent : Looks.colors.controlBgInactive
        opacity: input.activeFocus ? 1 : 0.35
    }

    TextInput {
        id: input
        anchors {
            left: parent.left
            right: searchIcon.left
            verticalCenter: parent.verticalCenter
            leftMargin: 11
            rightMargin: 8
        }
        clip: true
        color: Looks.colors.fg
        selectionColor: Looks.colors.selection
        selectedTextColor: Looks.colors.selectionFg
        renderType: Text.NativeRendering
        font {
            family: Looks.font.family.ui
            pixelSize: Looks.font.pixelSize.large
            weight: Looks.font.weight.regular
        }

        WText {
            anchors.verticalCenter: parent.verticalCenter
            visible: input.text.length === 0
            text: root.placeholder
            color: Looks.colors.fg1
            font.pixelSize: Looks.font.pixelSize.large
        }
    }

    Item {
        id: searchIcon
        anchors {
            right: parent.right
            rightMargin: 10
            verticalCenter: parent.verticalCenter
        }
        width: 14
        height: 14

        Rectangle {
            x: 1
            y: 1
            width: 9
            height: 9
            radius: 5
            color: "transparent"
            border.width: 1.5
            border.color: Looks.colors.fg1
        }

        Rectangle {
            x: 8.5
            y: 8.5
            width: 6
            height: 1.5
            radius: 1
            rotation: 45
            transformOrigin: Item.Left
            color: Looks.colors.fg1
        }
    }
}
