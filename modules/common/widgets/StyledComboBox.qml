pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.services
import qs.modules.common
import qs.modules.common.widgets
import qs.modules.common.functions
import qs.modules.waffle.looks
import qs.modules.waffle.settings

ComboBox {
    id: root

    property string buttonIcon: ""
    property real buttonRadius: Looks.radius.medium
    property color colBackground: Looks.colors.bg2Base
    property color colBackgroundHover: Looks.colors.bg2Hover
    property color colBackgroundActive: Looks.colors.bg2Active

    implicitHeight: 36
    Layout.fillWidth: true

    background: Rectangle {
        radius: root.buttonRadius
        border.width: 1
        border.color: Looks.colors.bg2Border
        color: (root.down && !root.popup.visible) ? root.colBackgroundActive : root.hovered ? root.colBackgroundHover : root.colBackground

        Behavior on color {
            animation: Looks.transition.color.createObject(this)
        }
    }

    indicator: FluentIcon {
        x: root.width - width - 14
        y: root.height / 2 - height / 2
        icon: "chevron-down"
        implicitSize: 12
        rotation: root.popup.visible ? 180 : 0

        Behavior on rotation {
            animation: Looks.transition.resize.createObject(this)
        }
    }

    contentItem: Item {
        implicitWidth: buttonLayout.implicitWidth
        implicitHeight: buttonLayout.implicitHeight

        RowLayout {
            id: buttonLayout
            anchors.fill: parent
            spacing: 10
            anchors.leftMargin: 12
            anchors.rightMargin: 34

            SettingsIcon {
                Layout.alignment: Qt.AlignVCenter
                size: 16
                icon: {
                    if (root.currentIndex >= 0 && typeof root.model[root.currentIndex] === 'object' && root.model[root.currentIndex]?.icon) {
                        return MaterialIconMap.fluent(root.model[root.currentIndex].icon);
                    }
                    return MaterialIconMap.fluent(root.buttonIcon);
                }
                visible: icon.length > 0
            }

            WText {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignVCenter
                text: root.displayText
                elide: Text.ElideRight
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: Looks.font.pixelSize.large
            }
        }
    }

    delegate: ItemDelegate {
        id: itemDelegate
        width: ListView.view ? ListView.view.width : root.width
        implicitHeight: 36

        required property var model
        required property int index
        property color color: {
            if (itemDelegate.down) return Looks.colors.bg2Active;
            if (itemDelegate.hovered) return Looks.colors.bg2Hover;
            if (root.currentIndex === itemDelegate.index) return Looks.colors.bg2Base;
            return "transparent";
        }

        background: Rectangle {
            anchors.fill: parent
            radius: Looks.radius.medium
            color: itemDelegate.color

            Rectangle {
                visible: root.currentIndex === itemDelegate.index
                anchors.verticalCenter: parent.verticalCenter
                x: 0
                width: 3
                height: 16
                radius: 2
                color: Looks.colors.accent
            }

            Behavior on color {
                animation: Looks.transition.color.createObject(this)
            }
        }

        contentItem: RowLayout {
            spacing: 10

            SettingsIcon {
                Layout.alignment: Qt.AlignVCenter
                size: 16
                icon: typeof itemDelegate.model === 'object' ? MaterialIconMap.fluent(itemDelegate.model?.icon ?? "") : ""
                visible: icon.length > 0
            }

            WText {
                Layout.fillWidth: true
                Layout.leftMargin: 8
                text: itemDelegate.model[root.textRole]
                elide: Text.ElideRight
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: Looks.font.pixelSize.large
            }
        }
    }

    popup: Popup {
        y: root.height + 4
        width: root.width
        height: Math.min(listView.contentHeight + topPadding + bottomPadding, 300)
        padding: 4

        background: Rectangle {
            radius: Looks.radius.medium
            color: Looks.colors.bg1Base
            border.width: 1
            border.color: Looks.colors.bg2Border
        }

        contentItem: StyledListView {
            id: listView
            clip: true
            implicitHeight: contentHeight
            spacing: 2
            model: root.popup.visible ? root.delegateModel : null
            currentIndex: root.highlightedIndex
        }
    }
}
