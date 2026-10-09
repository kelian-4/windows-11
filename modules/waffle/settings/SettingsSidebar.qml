import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.services
import qs.modules.common
import qs.modules.waffle.looks

Item {
    id: root

    property alias query: searchBox.text
    property int currentIndex: 0
    property var pages: []

    signal pageSelected(int index)

    implicitWidth: 308

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        RowLayout {
            Layout.leftMargin: 20
            Layout.topMargin: 4
            Layout.bottomMargin: 22
            spacing: 14

            Item {
                Layout.preferredWidth: 60
                Layout.preferredHeight: 60
                Layout.alignment: Qt.AlignVCenter

                Rectangle {
                    anchors.fill: parent
                    radius: width / 2
                    color: Looks.colors.bg2Base
                    border.width: 1
                    border.color: Looks.colors.bg2Border

                    SettingsIcon {
                        anchors.centerIn: parent
                        icon: "people"
                        size: 30
                        tint: Looks.colors.fg1
                    }
                }

                WUserAvatar {
                    anchors.fill: parent
                    sourceSize: Qt.size(60, 60)
                }
            }

            ColumnLayout {
                spacing: 0
                Layout.alignment: Qt.AlignVCenter

                WText {
                    text: SystemInfo.username
                    font.pixelSize: Looks.font.pixelSize.large
                    font.weight: Looks.font.weight.strong
                }

                WText {
                    text: SystemInfo.distroName
                    color: Looks.colors.fg1
                    font.pixelSize: Looks.font.pixelSize.normal
                }
            }
        }

        SettingsSearchBox {
            id: searchBox
            Layout.fillWidth: true
            Layout.leftMargin: 20
            Layout.rightMargin: 20
            Layout.bottomMargin: 10
        }

        Flickable {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            boundsBehavior: Flickable.StopAtBounds
            contentWidth: width
            contentHeight: navColumn.implicitHeight

            ColumnLayout {
                id: navColumn
                x: 8
                width: parent.width - 16
                spacing: 0

                Repeater {
                    model: root.pages
                    delegate: SettingsNavItem {
                        required property var modelData
                        required property int index
                        icon: modelData.icon
                        iconTint: modelData.tint
                        text: modelData.name
                        selected: index === root.currentIndex && root.query.length === 0
                        onClicked: root.pageSelected(index)
                    }
                }
            }
        }
    }
}
