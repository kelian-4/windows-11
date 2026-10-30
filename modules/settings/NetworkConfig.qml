import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Bluetooth
import qs.services
import qs.modules.common
import qs.modules.common.widgets
import qs.modules.waffle.looks
import qs.modules.waffle.settings

ContentPage {
    id: root
    forceWidth: true

    readonly property bool connected: Network.ethernet || (Network.wifiEnabled && Network.networkName.length > 0)

    component NetworkCard: SettingsCard {
        id: card
        required property var accessPoint

        icon: WIcons.wifiIconForStrength(card.accessPoint.strength)
        iconTint: "#3CC8E6"
        title: card.accessPoint.ssid
        subtitle: card.accessPoint.active ? Translation.tr("Connected") + (card.accessPoint.isSecure ? `, ${Translation.tr("Secured")}` : "") : (card.accessPoint.isSecure ? Translation.tr("Secured") : Translation.tr("Not secured"))
        chevron: false
        clickable: false

        Rectangle {
            visible: card.accessPoint.askingPassword
            Layout.preferredWidth: 190
            Layout.preferredHeight: 32
            radius: Looks.radius.medium
            color: Looks.colors.bg0Base
            border.width: 1
            border.color: Looks.colors.accent

            TextInput {
                id: passwordInput
                anchors {
                    fill: parent
                    leftMargin: 10
                    rightMargin: 10
                }
                verticalAlignment: TextInput.AlignVCenter
                echoMode: TextInput.Password
                clip: true
                color: Looks.colors.fg
                font.family: Looks.font.family.ui
                font.pixelSize: Looks.font.pixelSize.large
                onAccepted: Network.changePassword(card.accessPoint, text)
            }
        }

        SettingsButton {
            visible: card.accessPoint.askingPassword
            accent: true
            text: Translation.tr("Connect")
            onClicked: Network.changePassword(card.accessPoint, passwordInput.text)
        }

        SettingsButton {
            visible: !card.accessPoint.askingPassword
            accent: !card.accessPoint.active
            enabled: !Network.wifiConnecting
            text: card.accessPoint.active ? Translation.tr("Disconnect") : Translation.tr("Connect")
            onClicked: {
                if (card.accessPoint.active) Network.disconnectWifiNetwork();
                else Network.connectToWifiNetwork(card.accessPoint);
            }
        }
    }

    ContentSection {
        SettingsCard {
            icon: Network.ethernet ? "ethernet" : WIcons.internetIcon
            iconTint: "#3CC8E6"
            title: root.connected ? (Network.ethernet ? Translation.tr("Ethernet") : Network.networkName) : Translation.tr("Not connected")
            subtitle: root.connected ? Translation.tr("Connected") + (Network.active?.isSecure && !Network.ethernet ? `, ${Translation.tr("Secured")}` : "") : Translation.tr("No network connection")
            chevron: false
            clickable: false
        }
    }

    ContentSection {
        SettingsSwitchCard {
            icon: WIcons.wifiIconForStrength(100)
            iconTint: "#3CC8E6"
            title: Translation.tr("Wi-Fi")
            subtitle: Network.wifiEnabled ? (Network.networkName.length > 0 && !Network.ethernet ? Network.networkName : Translation.tr("Not connected")) : Translation.tr("Off")
            checked: Network.wifiEnabled
            onToggled: value => Network.enableWifi(value)
        }

        SettingsCard {
            visible: Network.wifiEnabled
            icon: "arrow-sync"
            iconTint: "#3CC8E6"
            title: Translation.tr("Available networks")
            subtitle: Network.wifiScanning ? Translation.tr("Searching for networks...") : Translation.tr("%1 networks found").arg(Network.wifiNetworks.length)
            chevron: false
            clickable: false

            SettingsButton {
                enabled: !Network.wifiScanning
                text: Translation.tr("Refresh")
                onClicked: Network.rescanWifi()
            }
        }

        Repeater {
            model: ScriptModel {
                values: Network.wifiEnabled ? Network.friendlyWifiNetworks : []
            }
            delegate: NetworkCard {
                required property var modelData
                accessPoint: modelData
            }
        }
    }

    ContentSection {
        title: Translation.tr("More")

        SettingsCard {
            icon: "ethernet"
            iconTint: "#3CC8E6"
            title: Translation.tr("Ethernet")
            subtitle: Network.ethernet ? Translation.tr("Connected") : Translation.tr("Not connected")
            chevron: false
            clickable: false
        }

        SettingsSwitchCard {
            icon: "flash-off"
            iconTint: "#3CC8E6"
            title: Translation.tr("Airplane mode")
            subtitle: Translation.tr("Stop all wireless communication")
            checked: !Network.wifiEnabled && !BluetoothStatus.enabled
            onToggled: value => {
                Network.enableWifi(!value);
                if (BluetoothStatus.available) Bluetooth.defaultAdapter.enabled = !value;
            }
        }

        SettingsSoonCard { icon: "shield-lock"; title: Translation.tr("VPN"); subtitle: Translation.tr("Add, connect, manage") }
        SettingsSoonCard { icon: "globe-search"; title: Translation.tr("Mobile hotspot"); subtitle: Translation.tr("Share your internet connection") }
        SettingsSoonCard { icon: "globe-shield"; title: Translation.tr("Proxy"); subtitle: Translation.tr("Proxy server for Wi-Fi and Ethernet connections") }
        SettingsSoonCard { icon: "settings"; title: Translation.tr("Advanced network settings"); subtitle: Translation.tr("View all network adapters, network reset") }
    }
}
