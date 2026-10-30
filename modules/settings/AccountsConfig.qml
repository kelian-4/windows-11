import QtQuick
import QtQuick.Layouts
import qs.services
import qs.modules.common
import qs.modules.common.functions
import qs.modules.common.widgets
import qs.modules.waffle.looks
import qs.modules.waffle.settings

ContentPage {
    id: root
    forceWidth: true

    RowLayout {
        Layout.fillWidth: true
        spacing: 20

        SettingsAvatar {
            size: 80
            Layout.alignment: Qt.AlignVCenter
        }

        ColumnLayout {
            Layout.alignment: Qt.AlignVCenter
            spacing: 2

            WText {
                text: SystemInfo.username
                font.pixelSize: Looks.font.pixelSize.xlarger + 3
                font.weight: Looks.font.weight.strong
            }

            WText {
                text: Translation.tr("Local account")
                color: Looks.colors.fg1
                font.pixelSize: Looks.font.pixelSize.large
            }
        }
    }

    ContentSection {
        title: Translation.tr("Account settings")

        SettingsCard {
            icon: "lock-closed"
            iconTint: "#3DC98B"
            title: Translation.tr("Lock")
            subtitle: Translation.tr("Lock the screen now")
            onClicked: Session.lock()
        }

        SettingsCard {
            icon: "lock-open"
            iconTint: "#3DC98B"
            title: Translation.tr("Change password")
            subtitle: Translation.tr("Opens your password change command")
            onClicked: Session.changePassword()
        }

        SettingsCard {
            id: signOutCard
            property bool armed: false

            icon: "power"
            iconTint: "#3DC98B"
            title: Translation.tr("Sign out")
            subtitle: armed ? Translation.tr("Click again to confirm") : Translation.tr("End your session and close all apps")
            onClicked: {
                if (armed) {
                    Session.logout();
                } else {
                    armed = true;
                    disarm.restart();
                }
            }

            Timer {
                id: disarm
                interval: 4000
                onTriggered: signOutCard.armed = false
            }
        }
    }

    ContentSection {
        title: Translation.tr("Related settings")

        SettingsSoonCard { icon: "library"; title: Translation.tr("Email & accounts"); subtitle: Translation.tr("Accounts used by email, calendar, and contacts") }
        SettingsSoonCard { icon: "lock-closed"; title: Translation.tr("Sign-in options"); subtitle: Translation.tr("Password, fingerprint, security key") }
        SettingsSoonCard { icon: "arrow-sync"; title: Translation.tr("Backup"); subtitle: Translation.tr("Back up your files, apps, preferences to restore them across devices") }
        SettingsSoonCard { icon: "corporation"; title: Translation.tr("Access work or school"); subtitle: Translation.tr("Organization resources like email, apps, and network") }
        SettingsSoonCard { icon: "people-team"; title: Translation.tr("Other users"); subtitle: Translation.tr("Device access, other accounts") }
    }
}
