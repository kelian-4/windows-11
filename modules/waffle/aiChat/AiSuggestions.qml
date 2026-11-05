pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import qs.modules.common
import qs.modules.waffle.looks

ColumnLayout {
    id: root

    property var suggestions: []
    property int selectedIndex: 0
    readonly property var shown: root.suggestions.slice(0, 10)
    signal accepted(string word)

    function acceptSelected() {
        if (root.selectedIndex >= 0 && root.selectedIndex < root.shown.length)
            root.accepted(root.shown[root.selectedIndex].name);
    }

    onSuggestionsChanged: root.selectedIndex = 0

    visible: root.shown.length > 0
    spacing: 6

    WText {
        Layout.fillWidth: true
        visible: text.length > 0
        wrapMode: Text.Wrap
        color: Looks.colors.subfg
        text: root.shown[root.selectedIndex]?.description ?? ""
    }

    Flow {
        Layout.fillWidth: true
        spacing: 6

        Repeater {
            model: root.shown
            delegate: WBorderedButton {
                id: suggestion
                required property var modelData
                required property int index
                checked: root.selectedIndex === suggestion.index
                text: suggestion.modelData.displayName ?? suggestion.modelData.name
                onHoveredChanged: {
                    if (suggestion.hovered)
                        root.selectedIndex = suggestion.index;
                }
                onClicked: root.accepted(suggestion.modelData.name)
            }
        }
    }
}
