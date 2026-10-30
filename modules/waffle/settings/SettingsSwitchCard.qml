import QtQuick
import QtQuick.Layouts
import qs.services
import qs.modules.waffle.looks

SettingsCard {
    id: root

    property bool checked: false

    signal toggled(bool value)

    chevron: false
    clickable: false

    WText {
        text: root.checked ? Translation.tr("On") : Translation.tr("Off")
        font.pixelSize: Looks.font.pixelSize.large
        opacity: root.enabled ? 1 : 0.4
    }

    WSwitch {
        checkable: false
        checked: root.checked
        enabled: root.enabled
        onClicked: root.toggled(!root.checked)
    }
}
