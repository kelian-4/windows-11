import QtQuick
import QtQuick.Layouts
import qs.modules.common.widgets

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
            chevron: !modelData.soon
            clickable: !modelData.soon
            opacity: modelData.soon ? 0.6 : 1
            onClicked: root.opened(index)

            ComingSoonBadge {
                visible: modelData.soon === true
            }
        }
    }
}
