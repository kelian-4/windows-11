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
        title: Translation.tr("Currently in use")

        SettingsCard {
            icon: Privacy.micActive ? "mic-on" : "mic-off"
            iconTint: "#A0A7B4"
            title: Translation.tr("Microphone")
            subtitle: Privacy.micActive ? Translation.tr("In use by an app") : Translation.tr("Not in use")
            chevron: false
            clickable: false
        }

        SettingsCard {
            icon: "video"
            iconTint: "#A0A7B4"
            title: Translation.tr("Screen sharing")
            subtitle: Privacy.screenSharing ? Translation.tr("Your screen is being shared") : Translation.tr("Not in use")
            chevron: false
            clickable: false
        }
    }
}
