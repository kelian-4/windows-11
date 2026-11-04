pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import qs.services
import qs.modules.common
import qs.modules.waffle.looks

WListView {
    id: root

    property bool stickToBottom: true

    function scrollToEnd() {
        root.stickToBottom = true;
        Qt.callLater(root.positionViewAtEnd);
    }

    clip: true
    spacing: 14
    topMargin: 12
    bottomMargin: 12
    leftMargin: 16
    rightMargin: 16

    model: ScriptModel {
        values: Ai.messageIDs.filter(id => Ai.messageByID[id]?.visibleToUser ?? true)
    }

    delegate: AiMessageItem {
        required property var modelData
        messageId: modelData
        messageData: Ai.messageByID[modelData]
        width: ListView.view.width - ListView.view.leftMargin - ListView.view.rightMargin
    }

    onContentHeightChanged: {
        if (root.stickToBottom)
            Qt.callLater(root.positionViewAtEnd);
    }
    onAtYEndChanged: {
        if (root.atYEnd)
            root.stickToBottom = true;
    }
    onMovingChanged: {
        if (root.moving && !root.atYEnd)
            root.stickToBottom = false;
    }
}
