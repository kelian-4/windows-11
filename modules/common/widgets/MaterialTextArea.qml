import QtQuick
import QtQuick.Controls
import qs.modules.common
import qs.modules.waffle.looks

TextArea {
    renderType: Text.NativeRendering
    selectedTextColor: Looks.colors.selectionFg
    selectionColor: Looks.colors.selection
    placeholderTextColor: Looks.colors.fg1
    color: Looks.colors.fg
    wrapMode: TextEdit.Wrap
    selectByMouse: true
    leftPadding: 11
    rightPadding: 11
    topPadding: 8
    bottomPadding: 8

    font {
        family: Looks.font.family.ui
        pixelSize: Looks.font.pixelSize.large
        hintingPreference: Font.PreferDefaultHinting
    }

    background: Rectangle {
        radius: Looks.radius.medium
        color: parent.activeFocus ? Looks.colors.bg0Base : Looks.colors.bg2Base
        border.width: 1
        border.color: Looks.colors.bg2Border

        Rectangle {
            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
            height: parent.parent.activeFocus ? 2 : 0
            color: Looks.colors.accent
        }
    }
}
