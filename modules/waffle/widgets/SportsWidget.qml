pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.modules.common
import qs.modules.waffle.looks

WidgetCard {
    id: root

    readonly property bool upcoming: Sports.data.state === "pre"
    readonly property string centerText: upcoming ? Qt.formatDateTime(new Date(Sports.data.date), "h:mm AP") : (Sports.data.away.score ?? "") + " - " + (Sports.data.home.score ?? "")

    widgetId: "sports"
    allowedSizes: ["small"]
    title: Sports.data.loaded ? Sports.data.league : Translation.tr("Sports")

    RowLayout {
        anchors.fill: parent
        visible: Sports.data.loaded
        spacing: 4

        TeamBadge {
            team: Sports.data.away
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: 0

            WText {
                Layout.alignment: Qt.AlignHCenter
                text: root.centerText
                font.pixelSize: Looks.font.pixelSize.large
                font.weight: Looks.font.weight.strong
            }

            WText {
                Layout.alignment: Qt.AlignHCenter
                text: Sports.data.detail
                color: Looks.colors.subfg
                font.pixelSize: 10
            }
        }

        TeamBadge {
            team: Sports.data.home
        }
    }

    WText {
        visible: !Sports.data.loaded
        text: Translation.tr("No game available")
        color: Looks.colors.subfg
    }

    component TeamBadge: ColumnLayout {
        required property var team

        spacing: 2

        Image {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 26
            Layout.preferredHeight: 26
            source: team.logo ?? ""
            sourceSize: Qt.size(52, 52)
            fillMode: Image.PreserveAspectFit
        }

        WText {
            Layout.alignment: Qt.AlignHCenter
            text: team.abbreviation ?? ""
            font.pixelSize: 10
        }
    }
}
