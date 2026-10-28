pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import qs.modules.common
import qs.modules.waffle.looks

Item {
    id: root

    required property var entry
    required property var menu

    readonly property string kind: entry.type ?? "item"
    readonly property bool hasSubmenu: (entry.submenu?.length ?? 0) > 0

    implicitWidth: 272
    implicitHeight: kind === "separator" ? 9 : (kind === "row" ? 44 : 36)

    Rectangle {
        visible: root.kind === "separator"
        anchors.centerIn: parent
        width: parent.width - 8
        height: 1
        color: Looks.colors.bg0Border
    }

    RowLayout {
        visible: root.kind === "row"
        anchors {
            fill: parent
            leftMargin: 4
            rightMargin: 4
            topMargin: 4
            bottomMargin: 4
        }
        spacing: 2

        Repeater {
            model: root.entry.items ?? []

            delegate: WBorderlessButton {
                id: rowButton

                required property var modelData

                Layout.fillWidth: true
                Layout.fillHeight: true
                enabled: modelData.enabled ?? true
                onClicked: {
                    root.menu.closeAll();
                    rowButton.modelData.action();
                }

                contentItem: FluentIcon {
                    icon: rowButton.modelData.icon
                    implicitSize: 20
                    color: rowButton.enabled ? Looks.colors.fg : Looks.colors.subfg
                }
            }
        }
    }

    WButton {
        id: button

        visible: root.kind === "item"
        anchors {
            fill: parent
            leftMargin: 4
            rightMargin: 4
            topMargin: 1
            bottomMargin: 1
        }
        enabled: root.entry.enabled ?? true
        onHoveredChanged: {
            if (hovered)
                root.menu.hoverEntry(root);
        }
        onClicked: {
            if (root.hasSubmenu) {
                root.menu.openSubFor(root);
                return;
            }
            root.menu.closeAll();
            root.entry.action?.();
        }

        contentItem: RowLayout {
            spacing: 12

            FluentIcon {
                visible: root.menu.hasIcons
                Layout.preferredWidth: 16
                Layout.preferredHeight: 16
                icon: root.entry.icon ?? ""
                implicitSize: 16
                color: button.fgColor
            }

            WText {
                Layout.fillWidth: true
                text: root.entry.text ?? ""
                color: button.fgColor
                elide: Text.ElideRight
                font.pixelSize: Looks.font.pixelSize.large
            }

            WText {
                visible: (root.entry.shortcut ?? "").length > 0
                text: root.entry.shortcut ?? ""
                color: Looks.colors.subfg
                font.pixelSize: Looks.font.pixelSize.normal
            }

            FluentIcon {
                visible: root.entry.checked ?? false
                icon: "checkmark"
                implicitSize: 14
                color: button.fgColor
            }

            FluentIcon {
                visible: root.hasSubmenu
                icon: "chevron-right"
                implicitSize: 12
                color: button.fgColor
            }
        }
    }
}
