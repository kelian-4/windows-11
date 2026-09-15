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

        BigAppGrid {
            Layout.fillWidth: true
            columns: 6
            desktopEntries: Config.options.launcher.pinnedApps
                .map(appId => DesktopEntries.byId(appId))
                .filter(entry => entry !== null && entry !== undefined)
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
        default property alias pageData: pageSectionContentArea.data

        spacing: 16

        WText {
            Layout.leftMargin: 32
            text: pageSection.title
            font.pixelSize: Looks.font.pixelSize.large
            font.weight: Looks.font.weight.stronger
        }

        ColumnLayout {
            id: pageSectionContentArea
            Layout.fillWidth: true
        }
    }
}
