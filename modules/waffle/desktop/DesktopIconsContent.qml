pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import Qt.labs.folderlistmodel
import qs.services
import qs.modules.common
import qs.modules.waffle.looks

Item {
    id: root

    readonly property real cellWidth: 88
    readonly property real cellHeight: 100
    readonly property real padding: 8
    readonly property int columns: Math.max(1, Math.floor((width - padding * 2) / cellWidth))
    readonly property int rows: Math.max(1, Math.floor((height - padding * 2) / cellHeight))
    readonly property bool renaming: renamingName.length > 0

    property var cells: ({})
    property string selectedName: ""
    property string renamingName: ""
    property var contextTarget: null

    function fileNames() {
        const names = [];
        for (let index = 0; index < folderModel.count; index++)
            names.push(folderModel.get(index, "fileName"));
        return names;
    }

    function relayout() {
        const names = root.fileNames();
        const saved = DesktopIcons.positions ?? {};
        const taken = {};
        const result = {};
        for (const name of names) {
            const position = saved[name];
            if (!position || position.column >= root.columns || position.row >= root.rows)
                continue;
            const key = `${position.column},${position.row}`;
            if (taken[key])
                continue;
            taken[key] = true;
            result[name] = {
                column: position.column,
                row: position.row
            };
        }
        for (const name of names) {
            if (result[name])
                continue;
            for (let column = 0; result[name] === undefined; column++) {
                for (let row = 0; row < root.rows; row++) {
                    const key = `${column},${row}`;
                    if (taken[key])
                        continue;
                    taken[key] = true;
                    result[name] = {
                        column: column,
                        row: row
                    };
                    break;
                }
            }
        }
        root.cells = result;
    }

    function dropIcon(name, centerX, centerY) {
        const targetColumn = Math.min(root.columns - 1, Math.max(0, Math.round((centerX - root.padding - root.cellWidth / 2) / root.cellWidth)));
        const targetRow = Math.min(root.rows - 1, Math.max(0, Math.round((centerY - root.padding - root.cellHeight / 2) / root.cellHeight)));
        const taken = {};
        for (const other of Object.keys(root.cells)) {
            if (other !== name)
                taken[`${root.cells[other].column},${root.cells[other].row}`] = true;
        }
        let best = null;
        for (let column = 0; column < root.columns; column++) {
            for (let row = 0; row < root.rows; row++) {
                if (taken[`${column},${row}`])
                    continue;
                const distance = (column - targetColumn) ** 2 + (row - targetRow) ** 2;
                if (best === null || distance < best.distance)
                    best = {
                        column: column,
                        row: row,
                        distance: distance
                    };
            }
        }
        if (best !== null)
            DesktopIcons.setPosition(name, best.column, best.row);
    }

    function showIconMenu(icon, x, y) {
        root.contextTarget = icon;
        root.selectedName = icon.fileName;
        iconMenu.x = x;
        iconMenu.y = y;
        iconMenu.open();
    }

    function showBackgroundMenu(x, y) {
        backgroundMenu.x = x;
        backgroundMenu.y = y;
        backgroundMenu.open();
    }

    onColumnsChanged: relayout()
    onRowsChanged: relayout()
    Component.onCompleted: relayout()

    FolderListModel {
        id: folderModel
        folder: DesktopIcons.desktopUrl
        showDirs: true
        showFiles: true
        showDirsFirst: true
        showHidden: false
        showDotAndDotDot: false
        sortField: FolderListModel.Name
    }

    Connections {
        target: folderModel

        function onCountChanged() {
            root.relayout();
        }

        function onModelReset() {
            root.relayout();
        }

        function onRowsInserted() {
            root.relayout();
        }

        function onRowsRemoved() {
            root.relayout();
        }
    }

    Connections {
        target: DesktopIcons

        function onPositionsChanged() {
            root.relayout();
        }
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onPressed: {
            root.selectedName = "";
            root.renamingName = "";
        }
        onClicked: mouse => {
            if (mouse.button === Qt.RightButton)
                root.showBackgroundMenu(mouse.x, mouse.y);
        }
    }

    DropArea {
        anchors.fill: parent
        onDropped: drop => {
            if (drop.hasUrls)
                DesktopIcons.importUrls(drop.urls);
        }
    }

    Repeater {
        model: folderModel

        delegate: DesktopIcon {
            id: icon

            cellX: root.padding + (root.cells[fileName]?.column ?? 0) * root.cellWidth
            cellY: root.padding + (root.cells[fileName]?.row ?? 0) * root.cellHeight
            cellWidth: root.cellWidth
            cellHeight: root.cellHeight
            selected: root.selectedName === fileName
            renaming: root.renamingName === fileName

            onClicked: root.selectedName = fileName
            onContextRequested: (x, y) => root.showIconMenu(icon, x, y)
            onDropped: (centerX, centerY) => root.dropIcon(fileName, centerX, centerY)
            onRenameAccepted: newName => {
                DesktopIcons.rename(fileName, newName);
                root.renamingName = "";
            }
            onRenameCancelled: root.renamingName = ""
        }
    }

    WMenu {
        id: iconMenu
        downDirection: true

        Action {
            text: Translation.tr("Open")
            onTriggered: root.contextTarget?.open()
        }
        Action {
            text: Translation.tr("Rename")
            onTriggered: root.renamingName = root.contextTarget?.fileName ?? ""
        }
        Action {
            text: Translation.tr("Delete")
            onTriggered: DesktopIcons.trash(root.contextTarget?.filePath ?? "")
        }
    }

    WMenu {
        id: backgroundMenu
        downDirection: true

        Action {
            text: Translation.tr("Sort by name")
            onTriggered: DesktopIcons.clearPositions()
        }
        Action {
            text: Translation.tr("Refresh")
            onTriggered: root.relayout()
        }
        Action {
            text: Translation.tr("New folder")
            onTriggered: DesktopIcons.createFolder(DesktopIcons.uniqueName(Translation.tr("New folder"), root.fileNames()))
        }
        Action {
            text: Translation.tr("New text document")
            onTriggered: DesktopIcons.createTextFile(DesktopIcons.uniqueName(Translation.tr("New Text Document") + ".txt", root.fileNames()))
        }
        Action {
            text: Translation.tr("Open Desktop folder")
            onTriggered: DesktopIcons.open(DesktopIcons.desktopPath)
        }
    }
}
