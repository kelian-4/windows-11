import QtQuick
import QtQuick.Layouts
import qs.modules.waffle.looks

SettingsPage {
    id: root

    property var results: []
    property string query: ""

    signal resultClicked(int index)

    WText {
        visible: root.results.length === 0
        text: `No results found for "${root.query}"`
        color: Looks.colors.fg1
        font.pixelSize: Looks.font.pixelSize.large
        Layout.topMargin: 8
    }

    Repeater {
        model: root.results
        delegate: SettingsCard {
            required property var modelData
            icon: modelData.icon
            iconTint: modelData.tint
            title: modelData.title
            subtitle: modelData.subtitle
            onClicked: root.resultClicked(modelData.index)
        }
    }
}
