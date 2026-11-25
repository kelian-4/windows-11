import qs
import qs.services
import qs.modules.common
import qs.modules.common.widgets
import qs.modules.common.functions
import qs.modules.waffle.looks
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root

    readonly property int columns: Math.max(2, Math.floor(grid.width / 190))
    property bool useDarkMode: Appearance.m3colors.darkmode

    function updateThumbnails() {
        const thumbnailSizeName = Images.thumbnailSizeNameForDimensions(grid.cellWidth, grid.cellHeight);
        Wallpapers.generateThumbnail(thumbnailSizeName);
    }

    Connections {
        target: Wallpapers
        function onDirectoryChanged() {
            root.updateThumbnails();
        }
    }

    Keys.onPressed: event => {
        if (event.key === Qt.Key_Escape) {
            GlobalStates.wallpaperSelectorOpen = false;
            event.accepted = true;
        } else if (event.modifiers & Qt.AltModifier && event.key === Qt.Key_Up) {
            Wallpapers.navigateUp();
            event.accepted = true;
        } else if (event.modifiers & Qt.AltModifier && event.key === Qt.Key_Left) {
            Wallpapers.navigateBack();
            event.accepted = true;
        } else if (event.modifiers & Qt.AltModifier && event.key === Qt.Key_Right) {
            Wallpapers.navigateForward();
            event.accepted = true;
        }
    }

    WAmbientShadow {
        target: panel
    }

    Rectangle {
        id: panel
        anchors.fill: parent
        radius: Looks.radius.xLarge
        color: Looks.colors.bgPanelBody
        border.width: 1
        border.color: Looks.colors.bg0Border

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 12
            spacing: 10

            RowLayout {
                Layout.fillWidth: true
                spacing: 6

                WBorderlessButton {
                    implicitWidth: 36
                    implicitHeight: 36
                    onClicked: Wallpapers.navigateBack()
                    contentItem: FluentIcon {
                        icon: "arrow-left"
                        implicitSize: 16
                    }
                }

                WBorderlessButton {
                    implicitWidth: 36
                    implicitHeight: 36
                    onClicked: Wallpapers.navigateUp()
                    contentItem: FluentIcon {
                        icon: "arrow-up-left"
                        implicitSize: 16
                    }
                }

                WText {
                    Layout.fillWidth: true
                    Layout.leftMargin: 6
                    elide: Text.ElideMiddle
                    text: Wallpapers.effectiveDirectory
                }

                WBorderlessButton {
                    implicitWidth: 36
                    implicitHeight: 36
                    onClicked: GlobalStates.wallpaperSelectorOpen = false
                    contentItem: FluentIcon {
                        icon: "dismiss"
                        implicitSize: 16
                    }
                }
            }

            Rectangle {
                Layout.fillWidth: true
                implicitHeight: 1
                color: Looks.colors.bg0Border
            }

            GridView {
                id: grid
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
                boundsBehavior: Flickable.StopAtBounds
                cellWidth: width / root.columns
                cellHeight: cellWidth * 0.75
                model: Wallpapers.folderModel
                visible: Wallpapers.folderModel.count > 0
                ScrollBar.vertical: ScrollBar {}

                Component.onCompleted: root.updateThumbnails()

                delegate: MouseArea {
                    id: item
                    required property var modelData
                    readonly property bool isDirectory: modelData.fileIsDir
                    readonly property bool isCurrent: modelData.filePath === Config.options.background.wallpaperPath

                    width: grid.cellWidth
                    height: grid.cellHeight
                    hoverEnabled: true
                    onClicked: {
                        if (item.isDirectory)
                            Wallpapers.setDirectory(modelData.filePath);
                        else
                            Wallpapers.select(modelData.filePath, root.useDarkMode);
                    }

                    Rectangle {
                        anchors.fill: parent
                        anchors.margins: 4
                        radius: Looks.radius.large
                        color: item.containsMouse ? Looks.colors.bg2Hover : "transparent"
                        border.width: item.isCurrent ? 2 : 0
                        border.color: Looks.colors.accent

                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 6
                            spacing: 4

                            Item {
                                Layout.fillWidth: true
                                Layout.fillHeight: true

                                ThumbnailImage {
                                    anchors.fill: parent
                                    visible: !item.isDirectory
                                    generateThumbnail: false
                                    sourcePath: item.modelData.filePath
                                    cache: false
                                    fillMode: Image.PreserveAspectCrop
                                    clip: true
                                }

                                FluentIcon {
                                    anchors.centerIn: parent
                                    visible: item.isDirectory
                                    icon: "folder-open"
                                    implicitSize: 48
                                }
                            }

                            WText {
                                Layout.fillWidth: true
                                horizontalAlignment: Text.AlignHCenter
                                elide: Text.ElideRight
                                font.pixelSize: Looks.font.pixelSize.small
                                text: item.modelData.fileName
                            }
                        }
                    }
                }
            }

            WText {
                Layout.fillWidth: true
                Layout.fillHeight: true
                visible: Wallpapers.folderModel.count === 0
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: Looks.colors.subfg
                text: Translation.tr("No images in this folder")
            }
        }
    }
}
