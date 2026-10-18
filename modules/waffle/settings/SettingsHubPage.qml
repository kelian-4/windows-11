import QtQuick
import QtQuick.Layouts

SettingsPage {
    id: root

    property var subs: []
    property color tint: "white"

    signal opened(int index)

    Repeater {
        model: root.subs
        delegate: SettingsCard {
            required property var modelData
            required property int index
            icon: modelData.icon
            iconTint: root.tint
            title: modelData.title
            subtitle: modelData.subtitle
            onClicked: root.opened(index)
        }
    }
}
