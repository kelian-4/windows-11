import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import qs.services
import qs.modules.common
import qs.modules.waffle.looks

RowLayout {
    id: root

    property string hostname: ""
    readonly property string wallpaper: Config.options.background.wallpaperPath.length > 0 ? Config.options.background.wallpaperPath : `${Directories.assetsPath}/images/default_wallpaper.png`

    spacing: 20

    FileView {
        path: "/proc/sys/kernel/hostname"
        printErrors: false
        onLoaded: root.hostname = text().trim()
    }

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
            subtitle: Translation.tr("Operating system")
        }

        SettingsLinkItem {
            icon: "desktop"
            iconTint: "#9AA3B2"
            title: "Hyprland"
            subtitle: Translation.tr("Window manager")
        }

        SettingsLinkItem {
            icon: "arrow-sync"
            iconTint: "#3C9CF0"
            title: Translation.tr("System updates")
            subtitle: Updates.available ? (Updates.count > 0 ? Translation.tr("%1 updates available").arg(Updates.count) : Translation.tr("Up to date")) : Translation.tr("Not available")
        }
    }
}
