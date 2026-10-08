pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell
import qs
import qs.services
import qs.modules.common
import qs.modules.common.functions
import qs.modules.common.widgets
import qs.modules.waffle.looks

Item {
    id: root
    Layout.alignment: Qt.AlignTop
    property alias sourceSize: avatar.sourceSize
    implicitWidth: sourceSize.width
    implicitHeight: sourceSize.height

    Rectangle {
        anchors.fill: parent
        radius: width / 2
        clip: true
        color: "transparent"

        StyledImage {
            id: avatar
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
            source: Directories.userAvatarPathAccountsService
            fallbacks: [Directories.userAvatarPathRicersAndWeirdSystems, Directories.userAvatarPathRicersAndWeirdSystems2]
        }
    }
}
