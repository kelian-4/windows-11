import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Bluetooth
import qs.services
import qs.modules.common
import qs.modules.common.widgets
import qs.modules.waffle.looks
import qs.modules.waffle.settings

ContentPage {
    id: root
    forceWidth: true

    property string hostname: ""
    readonly property bool scanning: Bluetooth.defaultAdapter?.discovering ?? false

    FileView {
        path: "/proc/sys/kernel/hostname"
        printErrors: false
        onLoaded: root.hostname = text().trim()
    }

    component DeviceCard: SettingsCard {
        id: card
        required property var device
        property string actionText: ""
        property bool removable: false

        icon: WIcons.bluetoothDeviceIcon(card.device)
        iconTint: "#4CA3FF"
        title: card.device?.name ?? ""
        subtitle: {
            if (!card.device) return "";
            const state = card.device.connected ? Translation.tr("Connected") : (card.device.paired ? Translation.tr("Paired") : Translation.tr("Available to pair"));
            return card.device.batteryAvailable ? `${state}  ·  ${Math.round(card.device.battery * 100)}%` : state;
        }
        chevron: false
        clickable: false

        SettingsButton {
            text: card.actionText
            accent: !card.device?.connected
            onClicked: {
                if (card.device.connected) card.device.disconnect();
                else card.device.connect();
            }
        }

        SettingsButton {
            visible: card.removable
            text: Translation.tr("Remove")
            onClicked: {
                if (card.device.forget) card.device.forget();
            }
        }
    }

    ContentSection {
        SettingsSwitchCard {
            icon: "bluetooth"
            iconTint: "#4CA3FF"
            title: Translation.tr("Bluetooth")
            subtitle: !BluetoothStatus.available ? Translation.tr("No Bluetooth adapter found") : (BluetoothStatus.enabled ? Translation.tr("Discoverable as \"%1\"").arg(root.hostname) : Translation.tr("Off"))
            enabled: BluetoothStatus.available
            checked: BluetoothStatus.enabled
            onToggled: value => {
                Bluetooth.defaultAdapter.enabled = value;
            }
        }

        SettingsCard {
            icon: "add"
            iconTint: "#4CA3FF"
            title: Translation.tr("Add device")
            subtitle: root.scanning ? Translation.tr("Searching for devices...") : Translation.tr("Bluetooth, keyboards, mice, audio and more")
            enabled: BluetoothStatus.enabled
            chevron: false
            clickable: false

            SettingsButton {
                accent: !root.scanning
                text: root.scanning ? Translation.tr("Stop") : Translation.tr("Search")
                onClicked: {
                    Bluetooth.defaultAdapter.discovering = !root.scanning;
                }
            }
        }
    }

    ContentSection {
        visible: BluetoothStatus.enabled && (BluetoothStatus.connectedDevices.length + BluetoothStatus.pairedButNotConnectedDevices.length) > 0
        title: Translation.tr("My devices")

        Repeater {
            model: ScriptModel {
                values: [...BluetoothStatus.connectedDevices, ...BluetoothStatus.pairedButNotConnectedDevices]
            }
            delegate: DeviceCard {
                required property var modelData
                device: modelData
                removable: true
                actionText: modelData.connected ? Translation.tr("Disconnect") : Translation.tr("Connect")
            }
        }
    }

    ContentSection {
        visible: BluetoothStatus.enabled && BluetoothStatus.unpairedDevices.length > 0
        title: Translation.tr("Other devices")

        Repeater {
            model: ScriptModel {
                values: BluetoothStatus.unpairedDevices
            }
            delegate: DeviceCard {
                required property var modelData
                device: modelData
                actionText: Translation.tr("Pair")
            }
        }
    }

    ContentSection {
        title: Translation.tr("Related settings")

        SettingsSoonCard { icon: "desktop-speaker"; title: Translation.tr("Printers & scanners"); subtitle: Translation.tr("Preferences, troubleshoot") }
        SettingsSoonCard { icon: "phone"; title: Translation.tr("Phone Link"); subtitle: Translation.tr("Instantly access your Android device's photos, texts, and more") }
        SettingsSoonCard { icon: "camera"; title: Translation.tr("Cameras"); subtitle: Translation.tr("Connected cameras, default image settings") }
        SettingsSoonCard { icon: "options"; title: Translation.tr("Mouse"); subtitle: Translation.tr("Buttons, mouse pointer speed, scrolling") }
        SettingsSoonCard { icon: "options"; title: Translation.tr("Touchpad"); subtitle: Translation.tr("Taps, gestures, scrolling, zooming") }
        SettingsSoonCard { icon: "play"; title: Translation.tr("AutoPlay"); subtitle: Translation.tr("Defaults for removable drives and memory cards") }
        SettingsSoonCard { icon: "flash-on"; title: Translation.tr("USB"); subtitle: Translation.tr("Notifications, USB battery saver, mobile device preferences") }
    }
}
