import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import qs.modules.common
import qs.modules.waffle.looks

ColumnLayout {
    id: root

    required property string blockText
    property color textColor: Looks.colors.fg
    property int alignment: TextEdit.AlignLeft
    readonly property var parsed: root.extractLinks(root.blockText)

    function extractLinks(source) {
        const links = [];
        const seen = {};
        const add = (label, url) => {
            if (!seen[url]) {
                seen[url] = true;
                links.push({ "label": label, "url": url });
            }
        };
        let text = source.replace(/\[([^\]\n]+)\]\((https?:\/\/[^)\s]+)\)/g, (match, label, url) => {
            add(label, url);
            return label;
        });
        text = text.replace(/<?(https?:\/\/[^\s)<>\]]+)>?/g, (match, url) => {
            const host = url.replace(/^https?:\/\//, "").split(/[\/?#]/)[0];
            add(host, url);
            return host;
        });
        return { "text": text, "links": links };
    }

    Layout.fillWidth: true
    spacing: 6

    TextArea {
        Layout.fillWidth: true
        padding: 0
        leftPadding: 0
        rightPadding: 0
        topPadding: 0
        bottomPadding: 0
        background: null
        text: root.parsed.text
        readOnly: true
        selectByMouse: true
        wrapMode: TextEdit.Wrap
        textFormat: TextEdit.MarkdownText
        color: root.textColor
        horizontalAlignment: root.alignment
        selectionColor: Looks.colors.selection
        selectedTextColor: Looks.colors.selectionFg
        renderType: Text.NativeRendering

        font {
            hintingPreference: Font.PreferDefaultHinting
            family: Looks.font.family.ui
            pixelSize: Looks.font.pixelSize.large
            weight: Looks.font.weight.regular
            variableAxes: Looks.font.variableAxes.ui
        }
    }

    Flow {
        Layout.fillWidth: true
        visible: root.parsed.links.length > 0
        spacing: 6

        Repeater {
            model: ScriptModel {
                values: root.parsed.links
            }
            delegate: WBorderedButton {
                required property var modelData
                text: modelData.label.length > 34 ? modelData.label.substring(0, 33) + "…" : modelData.label
                icon.name: "link"
                onClicked: Qt.openUrlExternally(modelData.url)
            }
        }
    }
}
