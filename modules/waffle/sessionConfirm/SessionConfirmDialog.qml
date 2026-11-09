import QtQuick
import QtQuick.Layouts
import qs
import qs.services
import qs.modules.common
import qs.modules.common.functions
import qs.modules.waffle.looks

Item {
    id: root

    property bool dark: false
    readonly property string action: GlobalStates.sessionConfirmAction
    readonly property var colors: root.dark ? Looks.darkColors : Looks.colors
    readonly property var infos: ({
            "poweroff": {
                "icon": "power",
                "title": Translation.tr("Shut down?"),
                "message": Translation.tr("Your apps will be closed and the computer will turn off."),
                "confirm": Translation.tr("Shut down")
            },
            "reboot": {
                "icon": "arrow-counterclockwise",
                "title": Translation.tr("Restart?"),
                "message": Translation.tr("Your apps will be closed and the computer will restart."),
                "confirm": Translation.tr("Restart")
            },
            "logout": {
                "icon": "people",
                "title": Translation.tr("Sign out?"),
                "message": Translation.tr("Your apps will be closed and your session will end."),
                "confirm": Translation.tr("Sign out")
            }
        })
    readonly property var info: root.infos[root.action] ?? null

    function accept() {
        const chosen = GlobalStates.sessionConfirmAction;
        GlobalStates.sessionConfirmAction = "";
        Session.execute(chosen);
    }

    function cancel() {
        GlobalStates.sessionConfirmAction = "";
    }

    function focusConfirm() {
        if (root.visible)
            confirmButton.forceActiveFocus();
    }

    visible: root.info !== null
    onVisibleChanged: root.focusConfirm()
    Component.onCompleted: root.focusConfirm()

    Keys.onPressed: event => {
        if (event.key === Qt.Key_Escape) {
            root.cancel();
            event.accepted = true;
        } else if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
            if (cancelButton.activeFocus)
                root.cancel();
            else
                root.accept();
            event.accepted = true;
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "#000000"
        opacity: 0.55
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.AllButtons
        onWheel: wheel => wheel.accepted = true
    }

    Rectangle {
        id: card
        anchors.centerIn: parent
        width: Math.min(root.width - 48, 420)
        implicitHeight: column.implicitHeight + 48
        height: implicitHeight
        radius: Looks.radius.large
        color: root.colors.bg1Base
        border.width: 1
        border.color: root.colors.bg2Border

        ColumnLayout {
            id: column
            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
                margins: 24
            }
            spacing: 14

            RowLayout {
                Layout.fillWidth: true
                spacing: 12

                FluentIcon {
                    icon: root.info?.icon ?? "power"
                    implicitSize: 28
                    color: root.colors.fg
                }
                WText {
                    Layout.fillWidth: true
                    text: root.info?.title ?? ""
                    wrapMode: Text.Wrap
                    color: root.colors.fg
                    font.pixelSize: Looks.font.pixelSize.xlarger
                    font.weight: Looks.font.weight.strong
                }
            }

            WText {
                Layout.fillWidth: true
                text: root.info?.message ?? ""
                wrapMode: Text.Wrap
                color: root.colors.subfg
                font.pixelSize: Looks.font.pixelSize.large
            }

            RowLayout {
                Layout.fillWidth: true
                Layout.topMargin: 10
                spacing: 8

                WBorderedButton {
                    id: confirmButton
                    Layout.fillWidth: true
                    Layout.preferredWidth: 1
                    implicitHeight: 36
                    checked: true
                    text: root.info?.confirm ?? ""
                    KeyNavigation.right: cancelButton
                    onClicked: root.accept()
                }
                WBorderedButton {
                    id: cancelButton
                    Layout.fillWidth: true
                    Layout.preferredWidth: 1
                    implicitHeight: 36
                    colBackground: root.colors.bg2
                    colBackgroundHover: root.colors.bg2Hover
                    colBackgroundActive: root.colors.bg2Active
                    colBorder: root.colors.bg2Border
                    colForeground: root.colors.fg
                    text: Translation.tr("Cancel")
                    KeyNavigation.left: confirmButton
                    onClicked: root.cancel()
                }
            }
        }
    }
}
