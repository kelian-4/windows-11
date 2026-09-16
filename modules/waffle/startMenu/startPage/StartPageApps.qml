pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import qs
import qs.services
import qs.modules.common
import qs.modules.common.functions
import qs.modules.common.widgets
import qs.modules.waffle.looks

BodyRectangle {
    id: root

    ColumnLayout {
        anchors {
            fill: parent
            leftMargin: 20
            rightMargin: 20
            topMargin: 16
            bottomMargin: 20
        }
        spacing: 14

        PinnedApps {
            Layout.fillWidth: true
        }

        AllApps {
            implicitHeight: 340
        }
    }

    component PinnedApps: PageSection {
        title: Translation.tr("Pinned")
        showLink: true
        linkText: (showAllApps ? Translation.tr("Show less") + "  <" : Translation.tr("Show all") + "  >")
        onLinkClicked: showAllApps = !showAllApps

        property bool showAllApps: false

        BigAppGrid {
            Layout.fillWidth: true
            columns: 6
            opacity: showAllApps ? 0 : 1
            visible: opacity > 0
            Behavior on opacity {
                NumberAnimation { duration: 150; easing.type: Easing.OutCubic }
            }
            desktopEntries: Config.options.launcher.pinnedApps
                .map(appId => DesktopEntries.byId(appId))
                .filter(entry => entry !== null && entry !== undefined)
        }

        ColumnLayout {
            Layout.fillWidth: true
            opacity: showAllApps ? 1 : 0
            visible: opacity > 0
            spacing: 0
            Behavior on opacity {
                NumberAnimation { duration: 150; easing.type: Easing.OutCubic }
            }

            Repeater {
                model: [...DesktopEntries.applications.values].sort((a, b) => (a.name || "").localeCompare(b.name || ""))
                delegate: StartAppListRow {
                    required property DesktopEntry modelData
                    Layout.fillWidth: true
                    desktopEntry: modelData
                }
            }
        }
    }

    component StartAppListRow: WButton {
        id: listRow
        required property DesktopEntry desktopEntry
        implicitHeight: 40
        onClicked: {
            GlobalStates.searchOpen = false;
            desktopEntry.execute();
        }

        contentItem: RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 12
            anchors.rightMargin: 12
            spacing: 12
            WAppIcon {
                Layout.alignment: Qt.AlignVCenter
                iconName: listRow.desktopEntry.icon
                implicitSize: 20
                tryCustomIcon: false
            }
            WText {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignVCenter
                text: listRow.desktopEntry.name
                elide: Text.ElideRight
            }
        }
    }

    component AllApps: PageSection {
        title: Translation.tr("All")
        // TODO: Do we wanna also implement list view and grid view?
        //       (instead of only category view)
        AllAppsGrid {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.leftMargin: 0
            Layout.rightMargin: 0
        }
    }

    component PageSection: ColumnLayout {
        id: pageSection
        required property string title
        property bool showLink: false
        property string linkText: ""
        signal linkClicked
        default property alias pageData: pageSectionContentArea.data

        spacing: 16

        RowLayout {
            Layout.leftMargin: 32
            Layout.rightMargin: 32
            Layout.fillWidth: true

            WText {
                text: pageSection.title
                font.pixelSize: Looks.font.pixelSize.large
                font.weight: Looks.font.weight.stronger
            }

            Item {
                Layout.fillWidth: true
            }

            WText {
                visible: pageSection.showLink
                text: pageSection.linkText
                color: "white"
                font.pixelSize: Looks.font.pixelSize.normal

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: pageSection.linkClicked()
                }
            }
        }

        ColumnLayout {
            id: pageSectionContentArea
            Layout.fillWidth: true
        }
    }
}
