import QtQuick
import QtQuick.Layouts
import qs.modules.common
import qs.modules.common.widgets
import qs.modules.waffle.looks
import qs.modules.waffle.settings

RippleButton {
    id: buttonWithIconRoot
    property string nerdIcon
    property string materialIcon
    property bool materialIconFill: true
    property string mainText: "Button text"
    property Component mainContentComponent: Component {
        WText {
            visible: text !== ""
            text: buttonWithIconRoot.mainText
            font.pixelSize: Looks.font.pixelSize.large
        }
    }
    implicitHeight: 34
    horizontalPadding: 14
    buttonRadius: Looks.radius.medium
    colBackground: Looks.colors.bg2Base

    contentItem: RowLayout {
        spacing: 8

        Item {
            Layout.fillWidth: false
            visible: nerdIconLoader.active || fluentIcon.visible
            implicitWidth: Math.max(fluentIcon.visible ? 16 : 0, nerdIconLoader.implicitWidth)
            implicitHeight: 16

            SettingsIcon {
                id: fluentIcon
                anchors.centerIn: parent
                visible: !buttonWithIconRoot.nerdIcon && icon.length > 0
                icon: MaterialIconMap.fluent(buttonWithIconRoot.materialIcon)
                size: 16
            }

            Loader {
                id: nerdIconLoader
                anchors.centerIn: parent
                active: !!buttonWithIconRoot.nerdIcon
                sourceComponent: WText {
                    text: buttonWithIconRoot.nerdIcon
                    font.pixelSize: Looks.font.pixelSize.larger
                    font.family: Appearance.font.family.iconNerd
                }
            }
        }

        Loader {
            Layout.fillWidth: true
            sourceComponent: buttonWithIconRoot.mainContentComponent
            Layout.alignment: Qt.AlignVCenter
        }
    }
}
