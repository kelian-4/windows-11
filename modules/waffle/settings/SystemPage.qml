import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import qs.services
import qs.modules.common
import qs.modules.waffle.looks

SettingsPage {
    id: root

    property var cards: []
    property string hostname: ""
    readonly property string wallpaper: Config.options.background.wallpaperPath.length > 0 ? Config.options.background.wallpaperPath : `${Directories.assetsPath}/images/default_wallpaper.png`

    FileView {
        path: "/proc/sys/kernel/hostname"
        onLoaded: root.hostname = text().trim()
    }

    RowLayout {
        Layout.fillWidth: true
        Layout.bottomMargin: 20
        spacing: 20

        Rectangle {
            Layout.preferredWidth: 118
            Layout.preferredHeight: 74
            radius: Looks.radius.medium
            color: Looks.colors.bg1Base
            border.width: 1
            border.color: Looks.colors.bg2Border
            clip: true

            Image {
                anchors.fill: parent
                anchors.margins: 1
                source: root.wallpaper
                fillMode: Image.PreserveAspectCrop
                asynchronous: true
                sourceSize: Qt.size(240, 150)
            }
        }

        ColumnLayout {
            Layout.alignment: Qt.AlignVCenter
            spacing: 1

            WText {
                text: root.hostname
                font.pixelSize: Looks.font.pixelSize.xlarger + 3
                font.weight: Looks.font.weight.strong
            }

            WText {
                text: SystemInfo.distroName
                color: Looks.colors.fg1
                font.pixelSize: Looks.font.pixelSize.large
            }

            WText {
                text: "Rename"
                color: Looks.colors.accent
                font.pixelSize: Looks.font.pixelSize.large

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                }
            }
        }

        Item {
            Layout.fillWidth: true
        }

        GridLayout {
            Layout.alignment: Qt.AlignVCenter
            flow: GridLayout.TopToBottom
            rows: 2
            rowSpacing: 18
            columnSpacing: 44

            SettingsLinkItem {
                icon: "start-here"
                iconTint: "#4CC2FF"
                title: SystemInfo.distroName
                subtitle: "Operating system"
            }

            SettingsLinkItem {
                icon: "desktop"
                iconTint: "#9AA3B2"
                title: "Hyprland"
                subtitle: "Window manager"
            }

            SettingsLinkItem {
                icon: "arrow-sync"
                iconTint: "#3C9CF0"
                title: "System update"
                subtitle: Updates.available ? (Updates.count > 0 ? `${Updates.count} updates available` : "You're up to date") : "Not checked"
            }
        }
    }

    Repeater {
        model: root.cards
        delegate: SettingsCard {
            required property var modelData
            icon: modelData.icon
            title: modelData.title
            subtitle: modelData.subtitle
        }
    }
}
