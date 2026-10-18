import QtQuick
import QtQuick.Layouts
import Quickshell
import qs
import qs.services
import qs.modules.common
import qs.modules.common.functions
import qs.modules.waffle.looks
import qs.modules.waffle.actionCenter
import qs.modules.waffle.actionCenter.volumeControl

ColumnLayout {
    id: root
    property var screen: root.QsWindow.window?.screen
    property var brightnessMonitor: Brightness.getMonitorForScreen(screen)
    spacing: 12

    RowLayout {
        visible: Config.options.sidebar.quickSliders.showBrightness
        spacing: 4

        WPanelIconButton {
            color: colBackground
            property real animationValue: root.brightnessMonitor?.brightness ?? 0
            rotation: animationValue * 180
            scale: 0.8 + animationValue * 0.2
            iconName: "weather-sunny"

            Behavior on animationValue {
                animation: Looks.transition.longMovement.createObject(this)
            }
        }
        
        WSlider {
            Layout.fillWidth: true
            value: root.brightnessMonitor?.brightness ?? 0
            scrollable: true
            onMoved: {
                root.brightnessMonitor?.setBrightness(value)
            }
        }

        WPanelIconButton {
            opacity: 0
        }
    }
    
    RowLayout {
        visible: Config.options.sidebar.quickSliders.showVolume
        spacing: 4

        WPanelIconButton {
            iconName: WIcons.volumeIcon
            onClicked: Audio.toggleMute();
        }
        
        WSlider {
            Layout.fillWidth: true
            value: Audio.sink.audio.volume
            scrollable: true
            onMoved: {
                Audio.sink.audio.volume = value;
            }
        }

        WPanelIconButton {
            Component {
                id: volumeControlComp
                VolumeControl {}
            }
            onClicked: {
                ActionCenterContext.push(volumeControlComp)
            }
            contentItem: Item {
                anchors.centerIn: parent
                Row {
                    anchors.centerIn: parent
                    spacing: -1
                    FluentIcon {
                        anchors.verticalCenter: parent.verticalCenter
                        implicitSize: 18
                        icon: "options"
                    }
                    FluentIcon {
                        anchors.verticalCenter: parent.verticalCenter
                        implicitSize: 12
                        icon: "chevron-right"
                    }
                }
            }
        }
    }

    RowLayout {
        visible: Config.options.sidebar.quickSliders.showMic
        spacing: 4

        WPanelIconButton {
            iconName: Audio.source?.audio?.muted ? "mic-off" : "mic"
            onClicked: Audio.toggleMicMute()
        }

        WSlider {
            Layout.fillWidth: true
            value: Audio.source?.audio?.volume ?? 0
            scrollable: true
            onMoved: {
                Audio.source.audio.volume = value;
            }
        }

        WPanelIconButton {
            opacity: 0
        }
    }
}
