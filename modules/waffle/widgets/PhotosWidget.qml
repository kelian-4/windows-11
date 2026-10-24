pragma ComponentBehavior: Bound
import QtQuick
import Qt.labs.folderlistmodel
import Quickshell.Widgets
import qs.services
import qs.modules.common
import qs.modules.waffle.looks

WidgetCard {
    id: root

    property int currentIndex: 0
    readonly property string configuredFolder: Config.options.waffles.widgets.photos.folder

    widgetId: "photos"
    showHeader: false
    contentMargin: 0
    textColor: "white"
    color: Looks.colors.bg2Base

    FolderListModel {
        id: folderModel
        folder: root.configuredFolder.length > 0 ? root.configuredFolder : Directories.pictures
        nameFilters: ["*.jpg", "*.jpeg", "*.png", "*.webp"]
        showDirs: false
        sortField: FolderListModel.Name
    }

    Timer {
        running: folderModel.count > 1
        repeat: true
        interval: 8000
        onTriggered: root.currentIndex = (root.currentIndex + 1) % folderModel.count
    }

    ClippingRectangle {
        anchors.fill: parent
        radius: root.radius
        color: "transparent"

        Image {
            anchors.fill: parent
            visible: folderModel.count > 0
            source: folderModel.count > 0 ? folderModel.get(root.currentIndex % folderModel.count, "fileUrl") : ""
            fillMode: Image.PreserveAspectCrop
            asynchronous: true
            sourceSize: Qt.size(root.width * 2, root.height * 2)
        }
    }

    WText {
        anchors.centerIn: parent
        visible: folderModel.count === 0
        text: Translation.tr("No photos found")
        color: Looks.colors.subfg
    }
}
