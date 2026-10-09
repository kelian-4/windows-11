import QtQuick
import QtQuick.Layouts

SettingsPage {
    id: root

    property var cards: []

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
