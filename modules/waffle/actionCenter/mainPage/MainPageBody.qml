import QtQuick
import QtQuick.Layouts
import Quickshell
import qs
import qs.services
import qs.modules.common
import qs.modules.common.functions
import qs.modules.waffle.looks
import qs.modules.waffle.actionCenter

BodyRectangle {
    id: root
    implicitHeight: contentLayout.implicitHeight

    ColumnLayout {
        id: contentLayout
        anchors.fill: parent
        spacing: 0

        MainPageBodyToggles {
            id: togglesContainer
            Layout.fillWidth: true
        }

        Rectangle {
            visible: (Config.options.sidebar.quickSliders.showVolume || Config.options.sidebar.quickSliders.showBrightness || Config.options.sidebar.quickSliders.showMic)
            implicitHeight: 1
            Layout.fillWidth: true
            color: Looks.colors.bg1Border
        }

        MainPageBodySliders {
            visible: (Config.options.sidebar.quickSliders.showVolume || Config.options.sidebar.quickSliders.showBrightness || Config.options.sidebar.quickSliders.showMic)
            Layout.margins: 12
            Layout.topMargin: 18
            Layout.bottomMargin: 14
        }
    }
}
