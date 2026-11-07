import QtQuick
import QtQuick.Layouts
import qs.services
import qs.modules.common
import qs.modules.waffle.looks

ColumnLayout {
    id: root

    property var textHorizontalAlignment: Text.AlignHCenter

    spacing: 0

    Text {
        Layout.fillWidth: true
        horizontalAlignment: root.textHorizontalAlignment
        text: DateTime.time.replace(/^0/, "")
        color: "white"
        style: Text.Raised
        styleColor: "#66000000"
        renderType: Text.NativeRendering
        font {
            family: Looks.font.family.ui
            pixelSize: 104
            weight: Font.Light
            hintingPreference: Font.PreferDefaultHinting
        }
    }

    Text {
        Layout.fillWidth: true
        Layout.topMargin: -8
        horizontalAlignment: root.textHorizontalAlignment
        text: Qt.locale().toString(DateTime.clock.date, "dddd, d MMMM")
        color: "white"
        style: Text.Raised
        styleColor: "#66000000"
        renderType: Text.NativeRendering
        font {
            family: Looks.font.family.ui
            pixelSize: 26
            weight: Font.Normal
            hintingPreference: Font.PreferDefaultHinting
        }
    }
}
