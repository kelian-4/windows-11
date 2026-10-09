import QtQuick
import QtQuick.Layouts
import QtQuick.Window
import qs.modules.waffle.looks

Item {
    id: root

    required property Window window
    property bool canGoBack: false

    signal backRequested()

    implicitHeight: 48

    DragHandler {
        target: null
        onActiveChanged: if (active) root.window.startSystemMove()
    }

    TapHandler {
        acceptedButtons: Qt.LeftButton
        onDoubleTapped: root.window.visibility === Window.Maximized ? root.window.showNormal() : root.window.showMaximized()
    }

    Item {
        id: backButton
        x: 12
        anchors.verticalCenter: parent.verticalCenter
        width: 32
        height: 32
        opacity: root.canGoBack ? 1 : 0.4

        Rectangle {
            anchors.fill: parent
            radius: Looks.radius.medium
            color: backMouse.pressed ? Looks.colors.bg1Active : (backMouse.containsMouse && root.canGoBack ? Looks.colors.bg1Hover : "transparent")
        }

        FluentIcon {
            anchors.centerIn: parent
            icon: "arrow-left"
            implicitSize: 16
        }

        MouseArea {
            id: backMouse
            anchors.fill: parent
            hoverEnabled: true
            enabled: root.canGoBack
            onClicked: root.backRequested()
        }
    }

    WText {
        anchors {
            left: backButton.right
            leftMargin: 10
            verticalCenter: parent.verticalCenter
        }
        text: "Settings"
        font.pixelSize: Looks.font.pixelSize.normal + 1
    }

    Row {
        anchors {
            top: parent.top
            right: parent.right
        }

        SettingsCaptionButton {
            onClicked: root.window.showMinimized()

            Rectangle {
                anchors.centerIn: parent
                width: 10
                height: 1
                color: Looks.colors.fg
            }
        }

        SettingsCaptionButton {
            onClicked: root.window.visibility === Window.Maximized ? root.window.showNormal() : root.window.showMaximized()

            Rectangle {
                anchors.centerIn: parent
                width: 10
                height: 10
                radius: 1
                color: "transparent"
                border.width: 1
                border.color: Looks.colors.fg
            }
        }

        SettingsCaptionButton {
            hoverColor: Looks.colors.danger
            pressColor: Looks.colors.dangerActive
            onClicked: root.window.close()

            FluentIcon {
                anchors.centerIn: parent
                icon: "dismiss"
                implicitSize: 12
            }
        }
    }
}
