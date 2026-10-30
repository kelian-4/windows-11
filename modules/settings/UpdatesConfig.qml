import QtQuick
import QtQuick.Layouts
import qs.services
import qs.modules.common
import qs.modules.common.widgets
import qs.modules.waffle.looks
import qs.modules.waffle.settings

ContentPage {
    forceWidth: true

    ContentSection {
        SettingsCard {
            icon: "arrow-sync"
            iconTint: "#3C9CF0"
            title: !Updates.available ? Translation.tr("Update checks are not available") : (Updates.count > 0 ? Translation.tr("%1 updates available").arg(Updates.count) : Translation.tr("You're up to date"))
            subtitle: !Updates.available ? Translation.tr("Requires checkupdates (Arch Linux)") : (Updates.checking ? Translation.tr("Checking for updates...") : "")
            chevron: false
            clickable: false

            SettingsButton {
                accent: true
                enabled: Updates.available && !Updates.checking
                text: Translation.tr("Check for updates")
                onClicked: Updates.refresh()
            }
        }
    }

    ContentSection {
        title: Translation.tr("Update settings")

        ConfigSwitch {
            buttonIcon: "sync_alt"
            text: Translation.tr("Enable update checks")
            checked: Config.options.updates.enableCheck
            onCheckedChanged: {
                Config.options.updates.enableCheck = checked;
            }
        }

        ConfigSpinBox {
            icon: "timer_off"
            text: Translation.tr("Check interval (mins)")
            value: Config.options.updates.checkInterval
            from: 60
            to: 1440
            stepSize: 60
            onValueChanged: {
                Config.options.updates.checkInterval = value;
            }
        }

        ConfigRow {
            ConfigSpinBox {
                icon: "warning"
                text: Translation.tr("Advise at (packages)")
                value: Config.options.updates.adviseUpdateThreshold
                from: 0
                to: 1000
                stepSize: 25
                onValueChanged: {
                    Config.options.updates.adviseUpdateThreshold = value;
                }
            }
            ConfigSpinBox {
                icon: "dangerous"
                text: Translation.tr("Strongly advise at (packages)")
                value: Config.options.updates.stronglyAdviseUpdateThreshold
                from: 0
                to: 1000
                stepSize: 25
                onValueChanged: {
                    Config.options.updates.stronglyAdviseUpdateThreshold = value;
                }
            }
        }
    }

    ContentSection {
        title: Translation.tr("More options")

        SettingsSoonCard { icon: "arrow-counterclockwise"; title: Translation.tr("Update history"); subtitle: Translation.tr("Recently installed updates") }
        SettingsSoonCard { icon: "settings"; title: Translation.tr("Advanced options"); subtitle: Translation.tr("Package manager, optional updates, rollback") }
    }
}
