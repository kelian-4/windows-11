import QtQuick
import QtQuick.Layouts
import qs.services
import qs.modules.common
import qs.modules.waffle.looks

Item {
    id: root

    property bool modelPickerOpen: false
    signal modelPickerToggled
    signal newChatRequested
    signal closeRequested

    implicitHeight: 52

    RowLayout {
        anchors {
            fill: parent
            leftMargin: 16
            rightMargin: 8
        }
        spacing: 8

        FluentIcon {
            icon: "wand"
            implicitSize: 18
            color: Looks.colors.accent
        }
        WText {
            text: Translation.tr("AI assistant")
            font.pixelSize: Looks.font.pixelSize.larger
            font.weight: Looks.font.weight.strong
        }

        Item {
            Layout.fillWidth: true
        }

        WBorderedButton {
            implicitWidth: modelRow.implicitWidth + horizontalPadding * 2
            implicitHeight: 32
            horizontalPadding: 10
            verticalPadding: 4
            checked: root.modelPickerOpen
            colBackgroundToggled: Looks.colors.bg2Active
            colBackgroundToggledHover: Looks.colors.bg2Active
            colBackgroundToggledActive: Looks.colors.bg2Active
            colForegroundToggled: Looks.colors.fg
            colBorderToggled: Looks.colors.bg2Border
            contentItem: RowLayout {
                id: modelRow
                spacing: 6

                WText {
                    Layout.maximumWidth: 150
                    text: Ai.getModel()?.name ?? Translation.tr("Choose a model")
                    elide: Text.ElideRight
                }
                FluentIcon {
                    icon: "chevron-down"
                    implicitSize: 12
                    rotation: root.modelPickerOpen ? 180 : 0
                    Behavior on rotation {
                        animation: Looks.transition.enter.createObject(this)
                    }
                }
            }
            onClicked: root.modelPickerToggled()
            WToolTip {
                text: Translation.tr("Choose a model")
            }
        }

        AiActionButton {
            implicitWidth: 32
            implicitHeight: 32
            iconSize: 16
            iconName: "add"
            enabled: Ai.messageIDs.length > 0
            tooltipText: Translation.tr("New chat")
            onClicked: root.newChatRequested()
        }

        AiActionButton {
            implicitWidth: 32
            implicitHeight: 32
            iconSize: 16
            iconName: "dismiss"
            tooltipText: Translation.tr("Close")
            onClicked: root.closeRequested()
        }
    }
}
