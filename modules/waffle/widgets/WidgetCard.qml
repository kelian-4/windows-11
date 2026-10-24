pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.services
import qs.modules.common
import qs.modules.waffle.looks

Rectangle {
    id: root

    required property string widgetId
    property string title: ""
    property list<string> allowedSizes: ["small", "medium", "large"]
    default property alias content: contentArea.data

    readonly property string size: Config.options.waffles.widgets[widgetId]?.size ?? allowedSizes[0]

    function setSize(newSize) {
        Config.options.waffles.widgets[widgetId].size = newSize;
    }

    function remove() {
        Config.options.waffles.widgets.order = Config.options.waffles.widgets.order.filter(id => id !== widgetId);
    }

    radius: Looks.radius.xLarge
    color: Looks.colors.bg2Base
    border.width: 1
    border.color: Looks.colors.bg2Border
    clip: true

    ColumnLayout {
        anchors {
            fill: parent
            margins: 12
        }
        spacing: 8

        RowLayout {
            Layout.fillWidth: true
            spacing: 4

            WText {
                Layout.fillWidth: true
                text: root.title
                elide: Text.ElideRight
                font.pixelSize: Looks.font.pixelSize.large
                font.weight: Looks.font.weight.strong
            }

            WBorderlessButton {
                id: moreButton
                implicitWidth: 28
                implicitHeight: 28
                onClicked: menu.visible = !menu.visible
                contentItem: FluentIcon {
                    icon: "more-horizontal"
                    implicitSize: 16
                }

                WMenu {
                    id: menu
                    downDirection: true
                    x: moreButton.width - menu.implicitWidth
                    y: moreButton.height

                    Action {
                        enabled: root.allowedSizes.includes("small") && root.size !== "small"
                        text: Translation.tr("Small")
                        onTriggered: root.setSize("small")
                    }
                    Action {
                        enabled: root.allowedSizes.includes("medium") && root.size !== "medium"
                        text: Translation.tr("Medium")
                        onTriggered: root.setSize("medium")
                    }
                    Action {
                        enabled: root.allowedSizes.includes("large") && root.size !== "large"
                        text: Translation.tr("Large")
                        onTriggered: root.setSize("large")
                    }
                    Action {
                        icon.name: "dismiss"
                        text: Translation.tr("Remove widget")
                        onTriggered: root.remove()
                    }
                }
            }
        }

        Item {
            id: contentArea
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}
