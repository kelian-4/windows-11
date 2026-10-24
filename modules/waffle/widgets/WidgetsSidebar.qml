import QtQuick
import qs.services
import qs.modules.waffle.looks

Item {
    id: root

    implicitWidth: 64

    Rectangle {
        anchors {
            top: parent.top
            topMargin: 12
            horizontalCenter: parent.horizontalCenter
        }
        width: 52
        height: 56
        radius: Looks.radius.large
        color: Looks.colors.bg1Active

        Rectangle {
            anchors {
                left: parent.left
                leftMargin: -6
                verticalCenter: parent.verticalCenter
            }
            width: 3
            height: 18
            radius: 2
            color: Looks.colors.accent
        }

        Column {
            anchors.centerIn: parent
            spacing: 4

            FluentIcon {
                anchors.horizontalCenter: parent.horizontalCenter
                icon: "widgets"
                monochrome: false
                implicitSize: 22
            }

            WText {
                anchors.horizontalCenter: parent.horizontalCenter
                text: Translation.tr("Widgets")
                font.pixelSize: 10
            }
        }
    }
}
