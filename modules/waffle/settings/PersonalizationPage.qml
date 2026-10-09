import QtQuick
import QtQuick.Layouts
import qs.services
import qs.modules.common
import qs.modules.waffle.looks

SettingsPage {
    id: root

    SettingsCard {
        icon: "image"
        iconTint: "#FF9F3D"
        title: "Background"
        subtitle: "Background image, color, slideshow"
    }

    SettingsCard {
        icon: "wand"
        iconTint: "#FF9F3D"
        title: "Colors"
        subtitle: "Accent color, transparency effects, color theme"
    }

    SettingsCard {
        icon: "dark-theme"
        iconTint: "#FF9F3D"
        title: "Dark mode"
        subtitle: "Switch between the light and dark color themes"
        chevron: false

        WText {
            text: darkSwitch.checked ? "On" : "Off"
            font.pixelSize: Looks.font.pixelSize.large
        }

        WSwitch {
            id: darkSwitch
            checked: Appearance.m3colors.darkmode
            onToggled: MaterialThemeLoader.toggleLightDark()
        }
    }

    SettingsCard {
        icon: "eye"
        iconTint: "#FF9F3D"
        title: "Transparency effects"
        subtitle: "Windows and surfaces appear translucent"
        chevron: false

        WText {
            text: transparencySwitch.checked ? "On" : "Off"
            font.pixelSize: Looks.font.pixelSize.large
        }

        WSwitch {
            id: transparencySwitch
            checked: Config.options.appearance.transparency.enable
            onToggled: Config.options.appearance.transparency.enable = checked
        }
    }

    SettingsCard {
        icon: "apps"
        iconTint: "#FF9F3D"
        title: "Themes"
        subtitle: "Install, create, manage"
    }

    SettingsCard {
        icon: "lock-closed"
        iconTint: "#FF9F3D"
        title: "Lock screen"
        subtitle: "Lock screen images, apps, animations"
    }

    SettingsCard {
        icon: "start-here"
        iconTint: "#FF9F3D"
        title: "Start"
        subtitle: "Recent apps and items, folders"
    }

    SettingsCard {
        icon: "subtract"
        iconTint: "#FF9F3D"
        title: "Taskbar position"
        subtitle: "Show the taskbar at the bottom of the screen"
        chevron: false

        WText {
            text: bottomSwitch.checked ? "On" : "Off"
            font.pixelSize: Looks.font.pixelSize.large
        }

        WSwitch {
            id: bottomSwitch
            checked: Config.options.waffles.bar.bottom
            onToggled: Config.options.waffles.bar.bottom = checked
        }
    }

    SettingsCard {
        icon: "subtract"
        iconTint: "#FF9F3D"
        title: "Taskbar alignment"
        subtitle: "Align taskbar icons to the left"
        chevron: false

        WText {
            text: leftSwitch.checked ? "On" : "Off"
            font.pixelSize: Looks.font.pixelSize.large
        }

        WSwitch {
            id: leftSwitch
            checked: Config.options.waffles.bar.leftAlignApps
            onToggled: Config.options.waffles.bar.leftAlignApps = checked
        }
    }

    SettingsCard {
        icon: "keyboard"
        iconTint: "#FF9F3D"
        title: "Fonts"
        subtitle: "Install, manage"
    }
}
