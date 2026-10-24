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
    property bool showHeader: true
    property color textColor: Looks.colors.fg
    property color subTextColor: Looks.colors.subfg
    property list<string> allowedSizes: ["small", "medium", "large"]
    property real contentMargin: 14
    default property alias content: contentArea.data

    readonly property string size: Config.options.waffles.widgets[widgetId]?.size ?? allowedSizes[0]

    function setSize(newSize) {
        Config.options.waffles.widgets[widgetId].size = newSize;
    }

    function remove() {
        Config.options.waffles.widgets.order = Config.options.waffles.widgets.order.filter(id => id !== widgetId);
    }

    radius: 20
    color: Looks.colors.bg2Base
    border.width: 1
    border.color: Looks.colors.bg2Border
    clip: true

    ColumnLayout {
        anchors {
            fill: parent
            margins: root.contentMargin
        }
        spacing: 6

        RowLayout {
            Layout.fillWidth: true
            visible: root.showHeader
            spacing: 4

            WText {
                Layout.fillWidth: true
                text: root.title
                color: root.textColor
                elide: Text.ElideRight
                font.pixelSize: Looks.font.pixelSize.large
                font.weight: Looks.font.weight.strong
            }

            Item {
                implicitWidth: 24
                implicitHeight: 28
            }
        }

        Item {
            id: contentArea
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }

    WBorderlessButton {
        id: moreButton
        anchors {
            top: parent.top
            right: parent.right
            topMargin: root.contentMargin - 8
            rightMargin: root.contentMargin - 8
        }
        implicitWidth: 32
        implicitHeight: 32
        onClicked: menu.visible = !menu.visible
        contentItem: FluentIcon {
            icon: "more-horizontal"
            implicitSize: 16
            color: root.textColor
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
