import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs.services
import qs.modules.common
import qs.modules.common.widgets
import qs.modules.waffle.looks

ContentPage {
    forceWidth: true

    ContentSection {
        icon: "box"
        title: Translation.tr("Distro")
        
        RowLayout {
            Layout.alignment: Qt.AlignLeft
            spacing: 20
            Layout.topMargin: 10
            Layout.bottomMargin: 10
            IconImage {
                implicitSize: 80
                source: Quickshell.iconPath(SystemInfo.logo)
            }
            ColumnLayout {
                Layout.alignment: Qt.AlignVCenter
                // spacing: 10
                WText {
                    text: SystemInfo.distroName
                    font.pixelSize: Looks.font.pixelSize.xlarger + 3
                    font.weight: Looks.font.weight.strong
                }
                WText {
                    font.pixelSize: Looks.font.pixelSize.large
                    text: `<a href="${SystemInfo.homeUrl}"><span style="color:${Looks.colors.accent}">${SystemInfo.homeUrl}</span></a>`
                    textFormat: Text.RichText
                    linkColor: Looks.colors.accent
                    onLinkActivated: (link) => {
                        Qt.openUrlExternally(link)
                    }
                    PointingHandLinkHover {}
                }
            }
        }

        Flow {
            Layout.fillWidth: true
            spacing: 5

            RippleButtonWithIcon {
                materialIcon: "auto_stories"
                mainText: Translation.tr("Documentation")
                onClicked: {
                    Qt.openUrlExternally(SystemInfo.documentationUrl)
                }
            }
            RippleButtonWithIcon {
                materialIcon: "support"
                mainText: Translation.tr("Help & Support")
                onClicked: {
                    Qt.openUrlExternally(SystemInfo.supportUrl)
                }
            }
            RippleButtonWithIcon {
                materialIcon: "bug_report"
                mainText: Translation.tr("Report a Bug")
                onClicked: {
                    Qt.openUrlExternally(SystemInfo.bugReportUrl)
                }
            }
            RippleButtonWithIcon {
                materialIcon: "policy"
                materialIconFill: false
                mainText: Translation.tr("Privacy Policy")
                onClicked: {
                    Qt.openUrlExternally(SystemInfo.privacyPolicyUrl)
                }
            }
            
        }

    }
    ContentSection {
        icon: "folder_managed"
        title: Translation.tr("Project")

        RowLayout {
            Layout.alignment: Qt.AlignLeft
            spacing: 20
            Layout.topMargin: 10
            Layout.bottomMargin: 10
            IconImage {
                implicitSize: 80
                source: `file://${Directories.assetsPath}/icons/fluent/start-here.svg`
            }
            ColumnLayout {
                Layout.alignment: Qt.AlignVCenter
                WText {
                    text: "windows-11"
                    font.pixelSize: Looks.font.pixelSize.xlarger + 3
                    font.weight: Looks.font.weight.strong
                }
                WText {
                    text: `<a href="https://github.com/kelian-4/windows-11"><span style="color:${Looks.colors.accent}">https://github.com/kelian-4/windows-11</span></a>`
                    font.pixelSize: Looks.font.pixelSize.large
                    textFormat: Text.RichText
                    onLinkActivated: (link) => {
                        Qt.openUrlExternally(link)
                    }
                    PointingHandLinkHover {}
                }
            }
        }

        Flow {
            Layout.fillWidth: true
            spacing: 5

            RippleButtonWithIcon {
                materialIcon: "open_in_new"
                mainText: Translation.tr("Repository")
                onClicked: {
                    Qt.openUrlExternally("https://github.com/kelian-4/windows-11")
                }
            }
            RippleButtonWithIcon {
                materialIcon: "adjust"
                materialIconFill: false
                mainText: Translation.tr("Issues")
                onClicked: {
                    Qt.openUrlExternally("https://github.com/kelian-4/windows-11/issues")
                }
            }
        }

        WText {
            Layout.topMargin: 6
            text: `${Translation.tr("Based on")} <a href="https://github.com/end-4/dots-hyprland"><span style="color:${Looks.colors.accent}">dots-hyprland</span></a> ${Translation.tr("by end-4")}`
            color: Looks.colors.fg1
            font.pixelSize: Looks.font.pixelSize.normal
            textFormat: Text.RichText
            onLinkActivated: (link) => {
                Qt.openUrlExternally(link)
            }
            PointingHandLinkHover {}
        }
    }
}
