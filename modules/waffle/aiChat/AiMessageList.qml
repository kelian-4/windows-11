pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import Quickshell
import qs.services
import qs.modules.common
import qs.modules.waffle.looks

Flickable {
    id: root

    readonly property real topPadding: 12
    readonly property real bottomPadding: 12
    readonly property real sidePadding: 16
    property bool stickToBottom: true
    property bool adjusting: false

    function endY() {
        return Math.max(0, root.contentHeight - root.height);
    }

    function followEnd() {
        root.adjusting = true;
        root.contentY = root.endY();
        root.adjusting = false;
    }

    function scrollToEnd() {
        root.stickToBottom = true;
        root.followEnd();
    }

    clip: true
    flickableDirection: Flickable.VerticalFlick
    boundsBehavior: Flickable.StopAtBounds
    contentWidth: root.width
    contentHeight: column.implicitHeight + root.topPadding + root.bottomPadding

    ScrollBar.vertical: WScrollBar {}

    onContentHeightChanged: {
        if (root.stickToBottom)
            root.followEnd();
    }
    onHeightChanged: {
        if (root.stickToBottom)
            root.followEnd();
    }
    onContentYChanged: {
        if (!root.adjusting)
            root.stickToBottom = root.contentY >= root.endY() - 2;
    }

    Column {
        id: column
        x: root.sidePadding
        y: root.topPadding
        width: root.width - root.sidePadding * 2
        spacing: 8

        Repeater {
            model: ScriptModel {
                values: Ai.messageIDs.filter(id => Ai.messageByID[id]?.visibleToUser ?? true)
            }
            delegate: AiMessageItem {
                required property var modelData
                width: column.width
                messageId: modelData
                messageData: Ai.messageByID[modelData]
            }
        }
    }
}
