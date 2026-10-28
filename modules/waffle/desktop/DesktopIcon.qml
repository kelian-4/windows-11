pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import qs.services
import qs.modules.common
import qs.modules.waffle.looks

Item {
    id: root

    required property string fileName
    required property string filePath
    required property url fileUrl
    required property bool fileIsDir
    required property string fileSuffix
    required property var fileSize
    required property var fileModified
    required property real cellX
    required property real cellY
    required property real cellWidth
    required property real cellHeight
    property real iconSize: 48
    property bool selected: false
    property bool renaming: false

    signal clicked
    signal contextRequested(real x, real y)
    signal dropped(real centerX, real centerY)
    signal renameAccepted(string newName)
    signal renameCancelled

    readonly property bool isLauncher: fileSuffix === "desktop"
    readonly property string launcherId: fileName.replace(/\.desktop$/, "")
    readonly property var launcherEntry: isLauncher ? DesktopEntries.byId(launcherId) : null
    readonly property var parsedLauncher: isLauncher ? DesktopIcons.parseLauncher(launcherFile.text()) : null
    readonly property string displayName: {
        if (!isLauncher)
            return fileName;
        return launcherEntry?.name || parsedLauncher?.name || launcherId;
    }
    readonly property bool isImage: ["png", "jpg", "jpeg", "webp", "gif", "bmp", "svg"].includes(fileSuffix.toLowerCase())
    readonly property string iconSource: {
        if (fileIsDir)
            return Quickshell.iconPath("folder", "inode-directory");
        if (isImage)
            return fileUrl;
        if (isLauncher) {
            const name = launcherEntry?.icon || parsedLauncher?.icon || "";
            if (name.startsWith("/"))
                return `file://${name}`;
            return Quickshell.iconPath(name.length > 0 ? name : "application-x-executable", "application-x-executable");
        }
        return Quickshell.iconPath(root.mimeIcon(fileSuffix.toLowerCase()), "text-x-generic");
    }

    readonly property string typeLabel: {
        if (fileIsDir)
            return Translation.tr("File folder");
        if (isLauncher)
            return Translation.tr("Desktop entry");
        if (fileSuffix.length > 0)
            return `${fileSuffix.toUpperCase()} ${Translation.tr("File")}`;
        return Translation.tr("File");
    }

    function formatSize(bytes) {
        const units = ["B", "KB", "MB", "GB", "TB"];
        let value = bytes;
        let unit = 0;
        while (value >= 1024 && unit < units.length - 1) {
            value /= 1024;
            unit++;
        }
        return unit === 0 ? `${bytes} B` : `${value.toFixed(1)} ${units[unit]} (${bytes.toLocaleString()} B)`;
    }

    function propertiesInfo() {
        return {
            name: displayName,
            icon: iconSource,
            rows: [
                {
                    label: Translation.tr("Type"),
                    value: typeLabel
                },
                {
                    label: Translation.tr("Location"),
                    value: DesktopIcons.desktopPath
                },
                {
                    label: Translation.tr("Size"),
                    value: fileIsDir ? "—" : formatSize(fileSize)
                },
                {
                    label: Translation.tr("Modified"),
                    value: new Date(fileModified).toLocaleString()
                }
            ]
        };
    }

    function mimeIcon(suffix) {
        if (suffix === "pdf")
            return "application-pdf";
        if (["zip", "tar", "gz", "xz", "7z", "rar", "bz2", "zst"].includes(suffix))
            return "application-zip";
        if (["mp3", "flac", "ogg", "wav", "m4a", "opus"].includes(suffix))
            return "audio-x-generic";
        if (["mp4", "mkv", "webm", "avi", "mov"].includes(suffix))
            return "video-x-generic";
        if (["sh", "py", "js", "lua"].includes(suffix))
            return "text-x-script";
        if (["appimage", "exe", "bin"].includes(suffix))
            return "application-x-executable";
        return "text-x-generic";
    }

    function open() {
        if (launcherEntry) {
            launcherEntry.execute();
            return;
        }
        if (isLauncher) {
            DesktopIcons.runExec(parsedLauncher?.exec ?? "");
            return;
        }
        DesktopIcons.open(filePath);
    }

    function resetPosition() {
        x = Qt.binding(() => root.cellX);
        y = Qt.binding(() => root.cellY);
    }

    x: cellX
    y: cellY
    width: cellWidth
    height: cellHeight
    opacity: DesktopIcons.clipboardCut && DesktopIcons.clipboardPaths.includes(filePath) ? 0.5 : 1

    Behavior on x {
        enabled: !area.drag.active
        NumberAnimation {
            duration: 120
            easing.type: Easing.OutCubic
        }
    }

    Behavior on y {
        enabled: !area.drag.active
        NumberAnimation {
            duration: 120
            easing.type: Easing.OutCubic
        }
    }

    FileView {
        id: launcherFile
        path: root.isLauncher ? root.filePath : ""
        printErrors: false
        watchChanges: true
        onFileChanged: reload()
    }

    Rectangle {
        anchors {
            fill: parent
            margins: 2
        }
        radius: 4
        color: root.selected ? Qt.alpha(Looks.colors.accent, 0.35) : (area.containsMouse ? Qt.alpha("white", 0.12) : "transparent")
        border.width: root.selected ? 1 : 0
        border.color: Looks.colors.accent
    }

    ColumnLayout {
        anchors {
            fill: parent
            topMargin: 6
            leftMargin: 4
            rightMargin: 4
        }
        spacing: 4

        Image {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: root.iconSize
            Layout.preferredHeight: root.iconSize
            source: root.iconSource
            sourceSize: Qt.size(root.iconSize * 2, root.iconSize * 2)
            fillMode: Image.PreserveAspectFit
            asynchronous: true
        }

        WText {
            Layout.fillWidth: true
            visible: !root.renaming
            horizontalAlignment: Text.AlignHCenter
            text: root.displayName
            color: "white"
            style: Text.Outline
            styleColor: "#99000000"
            wrapMode: Text.Wrap
            maximumLineCount: 2
            elide: Text.ElideRight
            font.pixelSize: Looks.font.pixelSize.normal
        }

        WTextField {
            id: renameField

            Layout.fillWidth: true
            visible: root.renaming
            text: root.fileName
            horizontalAlignment: Text.AlignHCenter
            onAccepted: root.renameAccepted(text)
            Keys.onEscapePressed: root.renameCancelled()
            onVisibleChanged: {
                if (!visible)
                    return;
                forceActiveFocus();
                selectAll();
            }
        }

        Item {
            Layout.fillHeight: true
        }
    }

    MouseArea {
        id: area

        property bool moved: false

        anchors.fill: parent
        enabled: !root.renaming
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        drag.target: pressedButtons === Qt.LeftButton ? root : null
        drag.threshold: 6

        onPressed: root.clicked()
        onPositionChanged: {
            if (drag.active)
                moved = true;
        }
        onReleased: {
            if (!moved)
                return;
            moved = false;
            root.dropped(root.x + root.width / 2, root.y + root.height / 2);
            root.resetPosition();
        }
        onClicked: mouse => {
            if (mouse.button === Qt.RightButton)
                root.contextRequested(root.x + mouse.x, root.y + mouse.y);
        }
        onDoubleClicked: mouse => {
            if (mouse.button === Qt.LeftButton)
                root.open();
        }
    }
}
