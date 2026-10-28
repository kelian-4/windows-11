pragma ComponentBehavior: Bound
import QtQuick
import Qt.labs.folderlistmodel
import qs.services
import qs.modules.common
import qs.modules.waffle.looks

Item {
    id: root

    readonly property var viewMetrics: ({
            small: {
                cellWidth: 76,
                cellHeight: 88,
                iconSize: 32
            },
            medium: {
                cellWidth: 88,
                cellHeight: 100,
                iconSize: 48
            },
            large: {
                cellWidth: 112,
                cellHeight: 124,
                iconSize: 72
            }
        })
    readonly property var metrics: viewMetrics[DesktopIcons.viewSize] ?? viewMetrics.medium
    readonly property real cellWidth: metrics.cellWidth
    readonly property real cellHeight: metrics.cellHeight
    readonly property real padding: 8
    readonly property int columns: Math.max(1, Math.floor((width - padding * 2) / cellWidth))
    readonly property int rows: Math.max(1, Math.floor((height - padding * 2) / cellHeight))
    readonly property var sortFields: ({
            name: FolderListModel.Name,
            size: FolderListModel.Size,
            type: FolderListModel.Type,
            date: FolderListModel.Time
        })

    property var cells: ({})
    property string selectedName: ""
    property string renamingName: ""
    property bool reloading: false
    property var lastMenu: null

    readonly property bool renaming: renamingName.length > 0

    function fileNames() {
        const names = [];
        for (let index = 0; index < folderModel.count; index++)
            names.push(folderModel.get(index, "fileName"));
        return names;
    }

    function iconByName(name) {
        for (let index = 0; index < repeater.count; index++) {
            const icon = repeater.itemAt(index);
            if (icon && icon.fileName === name)
                return icon;
        }
        return null;
    }

    function selectedIcon() {
        return root.iconByName(root.selectedName);
    }

    function columnOf(x) {
        return Math.round((x - root.padding) / root.cellWidth);
    }

    function rowOf(y) {
        return Math.round((y - root.padding) / root.cellHeight);
    }

    function clampX(x) {
        return Math.max(0, Math.min(x, root.width - root.cellWidth));
    }

    function clampY(y) {
        return Math.max(0, Math.min(y, root.height - root.cellHeight));
    }

    function relayout() {
        const names = root.fileNames();
        const saved = DesktopIcons.autoArrange ? {} : (DesktopIcons.positions ?? {});
        const taken = {};
        const result = {};
        for (const name of names) {
            const position = saved[name];
            if (!position)
                continue;
            if (DesktopIcons.alignToGrid) {
                const column = position.column ?? root.columnOf(position.x ?? 0);
                const row = position.row ?? root.rowOf(position.y ?? 0);
                const key = `${column},${row}`;
                if (column < 0 || row < 0 || column >= root.columns || row >= root.rows || taken[key])
                    continue;
                taken[key] = true;
                result[name] = {
                    x: root.padding + column * root.cellWidth,
                    y: root.padding + row * root.cellHeight
                };
            } else {
                const x = root.clampX(position.x ?? root.padding + (position.column ?? 0) * root.cellWidth);
                const y = root.clampY(position.y ?? root.padding + (position.row ?? 0) * root.cellHeight);
                taken[`${root.columnOf(x)},${root.rowOf(y)}`] = true;
                result[name] = {
                    x: x,
                    y: y
                };
            }
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
                        x: root.padding + column * root.cellWidth,
                        y: root.padding + row * root.cellHeight
                    };
                    break;
                }
            }
        }
        root.cells = result;
    }

    function dropIcon(name, centerX, centerY) {
        if (DesktopIcons.autoArrange)
            return;
        if (!DesktopIcons.alignToGrid) {
            DesktopIcons.setPosition(name, {
                x: root.clampX(centerX - root.cellWidth / 2),
                y: root.clampY(centerY - root.cellHeight / 2)
            });
            return;
        }
        const targetColumn = Math.min(root.columns - 1, Math.max(0, root.columnOf(centerX - root.cellWidth / 2 + root.padding)));
        const targetRow = Math.min(root.rows - 1, Math.max(0, root.rowOf(centerY - root.cellHeight / 2 + root.padding)));
        const taken = {};
        for (const other of Object.keys(root.cells)) {
            if (other !== name)
                taken[`${root.columnOf(root.cells[other].x)},${root.rowOf(root.cells[other].y)}`] = true;
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
            DesktopIcons.setPosition(name, {
                column: best.column,
                row: best.row
            });
    }

    function refresh() {
        root.reloading = true;
        reloadTimer.restart();
    }

    function createFolder() {
        DesktopIcons.createFolder(DesktopIcons.uniqueName(Translation.tr("New folder"), root.fileNames()));
    }

    function createTextDocument() {
        DesktopIcons.createTextFile(DesktopIcons.uniqueName(Translation.tr("New Text Document") + ".txt", root.fileNames()));
    }

    function copyIcon(icon, cut) {
        DesktopIcons.copyFiles([icon.filePath], cut);
    }

    function showProperties(icon) {
        propertiesDialog.info = icon.propertiesInfo();
        propertiesDialog.open();
    }

    function closeMenu() {
        contextMenu.closeAll();
    }

    function openMenu(model, x, y) {
        contextMenu.closeAll();
        DesktopIcons.refreshClipboard();
        contextMenu.model = model;
        contextMenu.openAt(x, y);
    }

    function openItemMenu(icon, x, y, classic) {
        root.selectedName = icon.fileName;
        root.lastMenu = {
            kind: "item",
            icon: icon,
            x: x,
            y: y
        };
        root.openMenu(classic ? root.classicItemModel(icon) : root.itemModel(icon), x, y);
    }

    function openBackgroundMenu(x, y, classic) {
        root.lastMenu = {
            kind: "background",
            x: x,
            y: y
        };
        root.openMenu(classic ? root.classicBackgroundModel() : root.backgroundModel(), x, y);
    }

    function showMoreOptions() {
        const menu = root.lastMenu;
        if (menu === null)
            return;
        Qt.callLater(() => {
            if (menu.kind === "item")
                root.openItemMenu(menu.icon, menu.x, menu.y, true);
            else
                root.openBackgroundMenu(menu.x, menu.y, true);
        });
    }

    function itemModel(icon) {
        return [
            {
                type: "row",
                items: [
                    {
                        icon: "cut",
                        action: () => root.copyIcon(icon, true)
                    },
                    {
                        icon: "copy",
                        action: () => root.copyIcon(icon, false)
                    },
                    {
                        icon: "rename",
                        action: () => root.renamingName = icon.fileName
                    },
                    {
                        icon: "delete",
                        action: () => DesktopIcons.trash(icon.filePath)
                    }
                ]
            },
            {
                text: Translation.tr("Open"),
                icon: "open",
                shortcut: "Enter",
                action: () => icon.open()
            },
            icon.fileIsDir ? {
                text: Translation.tr("Open in Terminal"),
                icon: "window-dev-tools",
                action: () => DesktopIcons.openTerminal(icon.filePath)
            } : null,
            {
                type: "separator"
            },
            {
                text: Translation.tr("Compress to ZIP file"),
                icon: "folder-zip",
                action: () => DesktopIcons.compress(icon.filePath)
            },
            {
                text: Translation.tr("Copy as path"),
                icon: "link",
                shortcut: "Ctrl+Shift+C",
                action: () => DesktopIcons.copyPath(icon.filePath)
            },
            {
                text: Translation.tr("Properties"),
                icon: "info",
                shortcut: "Alt+Enter",
                action: () => root.showProperties(icon)
            },
            {
                type: "separator"
            },
            {
                text: Translation.tr("Show more options"),
                icon: "options",
                shortcut: "Shift+F10",
                action: () => root.showMoreOptions()
            }
        ].filter(entry => entry !== null);
    }

    function classicItemModel(icon) {
        return [
            {
                text: Translation.tr("Open"),
                action: () => icon.open()
            },
            icon.fileIsDir ? {
                text: Translation.tr("Open in Terminal"),
                action: () => DesktopIcons.openTerminal(icon.filePath)
            } : null,
            {
                type: "separator"
            },
            {
                text: Translation.tr("Cut"),
                shortcut: "Ctrl+X",
                action: () => root.copyIcon(icon, true)
            },
            {
                text: Translation.tr("Copy"),
                shortcut: "Ctrl+C",
                action: () => root.copyIcon(icon, false)
            },
            {
                type: "separator"
            },
            {
                text: Translation.tr("Create shortcut"),
                action: () => DesktopIcons.createShortcut(icon.filePath, icon.fileName)
            },
            {
                text: Translation.tr("Delete"),
                shortcut: "Del",
                action: () => DesktopIcons.trash(icon.filePath)
            },
            {
                text: Translation.tr("Rename"),
                shortcut: "F2",
                action: () => root.renamingName = icon.fileName
            },
            {
                type: "separator"
            },
            {
                text: Translation.tr("Properties"),
                shortcut: "Alt+Enter",
                action: () => root.showProperties(icon)
            }
        ].filter(entry => entry !== null);
    }

    function viewModel() {
        return [
            {
                text: Translation.tr("Large icons"),
                checked: DesktopIcons.viewSize === "large",
                action: () => DesktopIcons.setViewSize("large")
            },
            {
                text: Translation.tr("Medium icons"),
                checked: DesktopIcons.viewSize === "medium",
                action: () => DesktopIcons.setViewSize("medium")
            },
            {
                text: Translation.tr("Small icons"),
                checked: DesktopIcons.viewSize === "small",
                action: () => DesktopIcons.setViewSize("small")
            },
            {
                type: "separator"
            },
            {
                text: Translation.tr("Auto arrange icons"),
                checked: DesktopIcons.autoArrange,
                action: () => DesktopIcons.setAutoArrange(!DesktopIcons.autoArrange)
            },
            {
                text: Translation.tr("Align icons to grid"),
                checked: DesktopIcons.alignToGrid,
                action: () => DesktopIcons.setAlignToGrid(!DesktopIcons.alignToGrid)
            },
            {
                type: "separator"
            },
            {
                text: Translation.tr("Show desktop icons"),
                checked: DesktopIcons.showIcons,
                action: () => DesktopIcons.setShowIcons(!DesktopIcons.showIcons)
            }
        ];
    }

    function sortModel() {
        return [
            {
                text: Translation.tr("Name"),
                checked: DesktopIcons.sortBy === "name",
                action: () => DesktopIcons.setSort("name")
            },
            {
                text: Translation.tr("Size"),
                checked: DesktopIcons.sortBy === "size",
                action: () => DesktopIcons.setSort("size")
            },
            {
                text: Translation.tr("Item type"),
                checked: DesktopIcons.sortBy === "type",
                action: () => DesktopIcons.setSort("type")
            },
            {
                text: Translation.tr("Date modified"),
                checked: DesktopIcons.sortBy === "date",
                action: () => DesktopIcons.setSort("date")
            }
        ];
    }

    function newModel() {
        return [
            {
                text: Translation.tr("Folder"),
                icon: "folder-add",
                action: () => root.createFolder()
            },
            {
                text: Translation.tr("Text Document"),
                icon: "document-add",
                action: () => root.createTextDocument()
            }
        ];
    }

    function backgroundModel() {
        return [
            {
                text: Translation.tr("View"),
                icon: "apps",
                submenu: root.viewModel()
            },
            {
                text: Translation.tr("Sort by"),
                icon: "arrow-sort",
                submenu: root.sortModel()
            },
            {
                text: Translation.tr("Refresh"),
                icon: "arrow-sync",
                shortcut: "F5",
                action: () => root.refresh()
            },
            {
                type: "separator"
            },
            {
                text: Translation.tr("Paste"),
                icon: "clipboard-paste",
                shortcut: "Ctrl+V",
                enabled: DesktopIcons.canPaste,
                action: () => DesktopIcons.paste()
            },
            {
                text: Translation.tr("New"),
                icon: "add",
                submenu: root.newModel()
            },
            {
                type: "separator"
            },
            {
                text: Translation.tr("Display settings"),
                icon: "settings",
                action: () => DesktopIcons.openSettings()
            },
            {
                text: Translation.tr("Personalize"),
                icon: "paint-brush",
                action: () => DesktopIcons.openSettings()
            },
            {
                type: "separator"
            },
            {
                text: Translation.tr("Open in Terminal"),
                icon: "window-dev-tools",
                action: () => DesktopIcons.openTerminal(DesktopIcons.desktopPath)
            },
            {
                type: "separator"
            },
            {
                text: Translation.tr("Show more options"),
                icon: "options",
                shortcut: "Shift+F10",
                action: () => root.showMoreOptions()
            }
        ];
    }

    function classicBackgroundModel() {
        return [
            {
                text: Translation.tr("View"),
                submenu: root.viewModel()
            },
            {
                text: Translation.tr("Sort by"),
                submenu: root.sortModel()
            },
            {
                text: Translation.tr("Refresh"),
                shortcut: "F5",
                action: () => root.refresh()
            },
            {
                type: "separator"
            },
            {
                text: Translation.tr("Paste"),
                shortcut: "Ctrl+V",
                enabled: DesktopIcons.canPaste,
                action: () => DesktopIcons.paste()
            },
            {
                type: "separator"
            },
            {
                text: Translation.tr("New"),
                submenu: root.newModel()
            },
            {
                type: "separator"
            },
            {
                text: Translation.tr("Open Desktop folder"),
                action: () => DesktopIcons.open(DesktopIcons.desktopPath)
            },
            {
                text: Translation.tr("Display settings"),
                action: () => DesktopIcons.openSettings()
            },
            {
                text: Translation.tr("Personalize"),
                action: () => DesktopIcons.openSettings()
            }
        ];
    }

    function handleKey(event) {
        const control = (event.modifiers & Qt.ControlModifier) !== 0;
        const shift = (event.modifiers & Qt.ShiftModifier) !== 0;
        const alt = (event.modifiers & Qt.AltModifier) !== 0;
        const icon = root.selectedIcon();
        if (event.key === Qt.Key_F5) {
            root.refresh();
            return true;
        }
        if (control && event.key === Qt.Key_V) {
            DesktopIcons.paste();
            return true;
        }
        if (icon === null)
            return false;
        if (event.key === Qt.Key_Delete) {
            DesktopIcons.trash(icon.filePath);
            return true;
        }
        if (event.key === Qt.Key_F2) {
            root.renamingName = icon.fileName;
            return true;
        }
        if (alt && (event.key === Qt.Key_Return || event.key === Qt.Key_Enter)) {
            root.showProperties(icon);
            return true;
        }
        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
            icon.open();
            return true;
        }
        if (control && shift && event.key === Qt.Key_C) {
            DesktopIcons.copyPath(icon.filePath);
            return true;
        }
        if (control && event.key === Qt.Key_C) {
            root.copyIcon(icon, false);
            return true;
        }
        if (control && event.key === Qt.Key_X) {
            root.copyIcon(icon, true);
            return true;
        }
        return false;
    }

    focus: true
    Keys.onPressed: event => {
        if (event.key === Qt.Key_Escape) {
            root.closeMenu();
            event.accepted = true;
            return;
        }
        event.accepted = root.handleKey(event);
    }

    onColumnsChanged: relayout()
    onRowsChanged: relayout()
    onCellWidthChanged: relayout()
    Component.onCompleted: relayout()

    Timer {
        id: reloadTimer
        interval: 80
        onTriggered: root.reloading = false
    }

    FolderListModel {
        id: folderModel
        folder: root.reloading ? "" : DesktopIcons.desktopUrl
        showDirs: true
        showFiles: true
        showDirsFirst: true
        showHidden: false
        showDotAndDotDot: false
        sortField: root.sortFields[DesktopIcons.sortBy] ?? FolderListModel.Name
        sortReversed: DesktopIcons.sortReversed
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

        function onAutoArrangeChanged() {
            root.relayout();
        }

        function onAlignToGridChanged() {
            root.relayout();
        }
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onPressed: mouse => {
            root.forceActiveFocus();
            root.closeMenu();
            root.selectedName = "";
            root.renamingName = "";
            if (mouse.button === Qt.RightButton)
                root.openBackgroundMenu(mouse.x, mouse.y, false);
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
        id: repeater
        model: folderModel

        delegate: DesktopIcon {
            id: icon

            visible: DesktopIcons.showIcons
            iconSize: root.metrics.iconSize
            cellX: root.cells[fileName]?.x ?? root.padding
            cellY: root.cells[fileName]?.y ?? root.padding
            cellWidth: root.cellWidth
            cellHeight: root.cellHeight
            selected: root.selectedName === fileName
            renaming: root.renamingName === fileName

            onClicked: {
                root.forceActiveFocus();
                root.closeMenu();
                root.selectedName = fileName;
            }
            onContextRequested: (x, y) => root.openItemMenu(icon, x, y, false)
            onDropped: (centerX, centerY) => root.dropIcon(fileName, centerX, centerY)
            onRenameAccepted: newName => {
                DesktopIcons.rename(fileName, newName);
                root.renamingName = "";
                root.forceActiveFocus();
            }
            onRenameCancelled: {
                root.renamingName = "";
                root.forceActiveFocus();
            }
        }
    }

    DesktopMenu {
        id: contextMenu
        parent: root
    }

    DesktopProperties {
        id: propertiesDialog
        parent: root
    }
}
