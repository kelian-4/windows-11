import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.modules.common
import qs.modules.common.functions
import qs.modules.waffle.looks

AcrylicButton {
    id: root

    property var altAction: () => {}
    property var middleClickAction: () => {}

    Layout.fillHeight: !Looks.barVertical
    Layout.fillWidth: Looks.barVertical
    topInset: Looks.barVertical ? 2 : 4
    bottomInset: Looks.barVertical ? 2 : 4
    leftInset: Looks.barVertical ? 8 : 0
    rightInset: Looks.barVertical ? 8 : 0
    horizontalPadding: 8

    colBackground: ColorUtils.transparentize(Looks.colors.bg1)

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
        onPressed: (event) => {
            root.down = true;
        }
        onReleased: (event) => {
            root.down = false;
        }
        onClicked: (event) => {
            if (event.button === Qt.LeftButton) root.clicked();
            if (event.button === Qt.RightButton) root.altAction();
            if (event.button === Qt.MiddleButton) root.middleClickAction();
        }
    }

}
