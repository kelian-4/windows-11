import QtQuick
import QtQuick.Layouts
import qs.modules.common
import qs.modules.common.widgets
import qs.modules.waffle.looks

ColumnLayout {
    id: root
    property string title: ""
    property string tooltip: ""
    property bool comingSoon: false
    default property alias contentData: sectionContent.data

    Layout.fillWidth: true
    Layout.topMargin: 6
    spacing: 4

    RowLayout {
        spacing: 8

        ContentSubsectionLabel {
            visible: root.title && root.title.length > 0
            text: root.title
        }

        Rectangle {
            visible: root.tooltip && root.tooltip.length > 0
            Layout.preferredWidth: 14
            Layout.preferredHeight: 14
            radius: 7
            color: "transparent"
            border.width: 1
            border.color: Looks.colors.fg1

            WText {
                anchors.centerIn: parent
                text: "i"
                color: Looks.colors.fg1
                font.pixelSize: 9
            }

            MouseArea {
                id: infoMouseArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.WhatsThisCursor
                StyledToolTip {
                    extraVisibleCondition: false
                    alternativeVisibleCondition: infoMouseArea.containsMouse
                    text: root.tooltip
                }
            }
        }

        ComingSoonBadge {
            visible: root.comingSoon
        }

        Item {
            Layout.fillWidth: true
        }
    }

    ColumnLayout {
        id: sectionContent
        Layout.fillWidth: true
        spacing: 4
        enabled: !root.comingSoon
        opacity: root.comingSoon ? 0.5 : 1
    }
}
