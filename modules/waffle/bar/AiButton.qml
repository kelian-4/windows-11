import QtQuick
import qs
import qs.services
import qs.modules.common
import qs.modules.waffle.looks

BarIconButton {
    id: root

    visible: Config.options.policies.ai !== 0
    iconName: "wand"
    iconSize: 20
    iconMonochrome: true
    tooltipText: Translation.tr("AI assistant")

    checked: GlobalStates.aiChatOpen
    onClicked: {
        GlobalStates.aiChatOpen = !GlobalStates.aiChatOpen;
    }
}
