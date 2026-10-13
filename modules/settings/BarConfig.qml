import QtQuick
import QtQuick.Layouts
import qs.services
import qs.modules.common
import qs.modules.common.widgets

ContentPage {
    forceWidth: true

    ContentSection {
        icon: "workspaces"
        title: Translation.tr("Taskbar")

        ConfigRow {
            ContentSubsection {
                title: Translation.tr("Taskbar position")
                ConfigSelectionArray {
                    currentValue: Config.options.waffles.bar.bottom ? 1 : 0
                    onSelected: newValue => {
                        Config.options.waffles.bar.bottom = newValue === 1;
                    }
                    options: [
                        {
                            displayName: Translation.tr("Top"),
                            icon: "arrow_upward",
                            value: 0
                        },
                        {
                            displayName: Translation.tr("Bottom"),
                            icon: "arrow_downward",
                            value: 1
                        }
                    ]
                }
            }
            ContentSubsection {
                title: Translation.tr("Taskbar alignment")
                ConfigSelectionArray {
                    currentValue: Config.options.waffles.bar.leftAlignApps ? 1 : 0
                    onSelected: newValue => {
                        Config.options.waffles.bar.leftAlignApps = newValue === 1;
                    }
                    options: [
                        {
                            displayName: Translation.tr("Center"),
                            icon: "",
                            value: 0
                        },
                        {
                            displayName: Translation.tr("Left"),
                            icon: "arrow_back",
                            value: 1
                        }
                    ]
                }
            }
        }
    }

    ContentSection {
        icon: "tune"
        title: Translation.tr("Notification area")

        ConfigSwitch {
            buttonIcon: "keep"
            text: Translation.tr('Make icons pinned by default')
            checked: Config.options.tray.invertPinnedItems
            onCheckedChanged: {
                Config.options.tray.invertPinnedItems = checked;
            }
        }

        ConfigSwitch {
            buttonIcon: "visibility"
            text: Translation.tr('Hide passive items')
            checked: Config.options.tray.filterPassive
            onCheckedChanged: {
                Config.options.tray.filterPassive = checked;
            }
        }
    }

    ContentSection {
        icon: "wand_stars"
        title: Translation.tr("Appearance tweaks")

        ConfigSwitch {
            buttonIcon: "animation"
            text: Translation.tr('Smoother menu animations')
            checked: Config.options.waffles.tweaks.smootherMenuAnimations
            onCheckedChanged: {
                Config.options.waffles.tweaks.smootherMenuAnimations = checked;
            }
        }

        ConfigSwitch {
            buttonIcon: "search"
            text: Translation.tr('Smoother search bar')
            checked: Config.options.waffles.tweaks.smootherSearchBar
            onCheckedChanged: {
                Config.options.waffles.tweaks.smootherSearchBar = checked;
            }
        }

        ConfigSwitch {
            buttonIcon: "tune"
            text: Translation.tr('Fix switch handle position')
            checked: Config.options.waffles.tweaks.switchHandlePositionFix
            onCheckedChanged: {
                Config.options.waffles.tweaks.switchHandlePositionFix = checked;
            }
        }

        ConfigSwitch {
            buttonIcon: "language"
            text: Translation.tr('Two-letter day names in the calendar')
            checked: Config.options.waffles.calendar.force2CharDayOfWeek
            onCheckedChanged: {
                Config.options.waffles.calendar.force2CharDayOfWeek = checked;
            }
        }
    }
}
