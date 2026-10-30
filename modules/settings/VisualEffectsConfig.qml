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
        ConfigSwitch {
            buttonIcon: "visibility"
            text: Translation.tr("Transparency")
            checked: Config.options.appearance.transparency.enable
            onCheckedChanged: {
                Config.options.appearance.transparency.enable = checked;
            }
        }

        ConfigSlider {
            enabled: Config.options.appearance.transparency.enable
            buttonIcon: "ev_shadow"
            text: Translation.tr("Transparency level")
            from: 0
            to: 0.6
            value: Config.options.appearance.transparency.level
            onValueChanged: {
                Config.options.appearance.transparency.level = value;
            }
        }
    }
}
