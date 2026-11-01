pragma ComponentBehavior: Bound
import QtQuick
import Qt.labs.folderlistmodel
import Quickshell
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
    property var selectedNames: []
    property string anchorName: ""
    property string renamingName: ""
    property string dragPrimary: ""
    property real dragDeltaX: 0
    property real dragDeltaY: 0
    property bool bandActive: false
    property real bandX: 0
    property real bandY: 0
    property real bandWidth: 0
    property real bandHeight: 0
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

    function selectedIcons() {
        return root.selectedNames.map(name => root.iconByName(name)).filter(icon => icon !== null);
    }

    function isSelected(name) {
        return root.selectedNames.includes(name);
    }

    function selectOnly(name) {
        root.selectedNames = [name];
        root.anchorName = name;
    }

    function clearSelection() {
        root.selectedNames = [];
        root.anchorName = "";
    }

    function toggleSelected(name) {
        root.selectedNames = root.isSelected(name) ? root.selectedNames.filter(other => other !== name) : root.selectedNames.concat([name]);
        root.anchorName = name;
    }

    function selectRange(name) {
        const names = root.fileNames();
        const from = names.indexOf(root.anchorName);
        const to = names.indexOf(name);
        if (from < 0 || to < 0) {
            root.selectOnly(name);
            return;
        }
        root.selectedNames = names.slice(Math.min(from, to), Math.max(from, to) + 1);
    }

    function selectAll() {
        root.selectedNames = root.fileNames();
    }

    function selectInBand(base) {
        const names = root.fileNames().filter(name => {
            const cell = root.cells[name];
            return cell && cell.x < root.bandX + root.bandWidth && cell.x + root.cellWidth > root.bandX && cell.y < root.bandY + root.bandHeight && cell.y + root.cellHeight > root.bandY;
        });
        root.selectedNames = base.concat(names.filter(name => !base.includes(name)));
    }

    function handlePress(icon, modifiers) {
        root.forceActiveFocus();
        root.closeMenu();
        const control = (modifiers & Qt.ControlModifier) !== 0;
        const shift = (modifiers & Qt.ShiftModifier) !== 0;
        if (shift && root.anchorName.length > 0)
            root.selectRange(icon.fileName);
        else if (control)
            root.toggleSelected(icon.fileName);
        else if (!root.isSelected(icon.fileName))
            root.selectOnly(icon.fileName);
    }

    function handleRelease(icon, modifiers) {
        const plain = (modifiers & (Qt.ControlModifier | Qt.ShiftModifier)) === 0;
        if (plain && root.selectedNames.length > 1)
            root.selectOnly(icon.fileName);
    }

    function followDrag(name, deltaX, deltaY) {
        root.dragPrimary = name;
        root.dragDeltaX = deltaX;
        root.dragDeltaY = deltaY;
    }

    function endDrag() {
        root.dragPrimary = "";
        root.dragDeltaX = 0;
        root.dragDeltaY = 0;
    }

    function paths(icons) {
        return icons.map(icon => icon.filePath);
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

    function nearestFree(taken, column, row) {
        let best = null;
        for (let candidateColumn = 0; candidateColumn < root.columns; candidateColumn++) {
            for (let candidateRow = 0; candidateRow < root.rows; candidateRow++) {
                if (taken[`${candidateColumn},${candidateRow}`])
                    continue;
                const distance = (candidateColumn - column) ** 2 + (candidateRow - row) ** 2;
                if (best === null || distance < best.distance)
                    best = {
                        column: candidateColumn,
                        row: candidateRow,
                        distance: distance
                    };
            }
        }
        return best;
    }

    function dropSelection(primary, centerX, centerY) {
        if (DesktopIcons.autoArrange)
            return;
        const names = root.isSelected(primary) ? root.selectedNames : [primary];
        const origin = root.cells[primary];
        if (!origin)
            return;
        const deltaX = centerX - root.cellWidth / 2 - origin.x;
        const deltaY = centerY - root.cellHeight / 2 - origin.y;
        const updates = {};
        const moving = names.filter(name => root.cells[name]);
        if (!DesktopIcons.alignToGrid) {
            for (const name of moving) {
                updates[name] = {
                    x: root.clampX(root.cells[name].x + deltaX),
                    y: root.clampY(root.cells[name].y + deltaY)
                };
            }
            DesktopIcons.setPositions(updates);
            return;
        }
        const deltaColumns = Math.round(deltaX / root.cellWidth);
        const deltaRows = Math.round(deltaY / root.cellHeight);
        const taken = {};
        for (const other of Object.keys(root.cells)) {
            if (!moving.includes(other))
                taken[`${root.columnOf(root.cells[other].x)},${root.rowOf(root.cells[other].y)}`] = true;
        }
        const ordered = moving.slice().sort((a, b) => (root.cells[a].y - root.cells[b].y) || (root.cells[a].x - root.cells[b].x));
        for (const name of ordered) {
            const column = Math.min(root.columns - 1, Math.max(0, root.columnOf(root.cells[name].x) + deltaColumns));
            const row = Math.min(root.rows - 1, Math.max(0, root.rowOf(root.cells[name].y) + deltaRows));
            const spot = root.nearestFree(taken, column, row);
            if (spot === null)
                continue;
            taken[`${spot.column},${spot.row}`] = true;
            updates[name] = {
                column: spot.column,
                row: spot.row
            };
        }
        DesktopIcons.setPositions(updates);
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

    function copyIcons(icons, cut) {
        DesktopIcons.copyFiles(root.paths(icons), cut);
    }

    function showProperties(icons) {
        if (icons.length === 1) {
            propertiesDialog.info = icons[0].propertiesInfo();
        } else {
            const files = icons.filter(icon => !icon.fileIsDir);
            const total = files.reduce((sum, icon) => sum + Number(icon.fileSize), 0);
            propertiesDialog.info = {
                name: Translation.tr("%1 items").arg(icons.length),
                icon: Quickshell.iconPath("text-x-generic"),
                rows: [
                    {
                        label: Translation.tr("Type"),
                        value: Translation.tr("Multiple types")
                    },
                    {
                        label: Translation.tr("Location"),
                        value: DesktopIcons.desktopPath
                    },
                    {
                        label: Translation.tr("Size"),
                        value: icons[0].formatSize(total)
                    },
                    {
                        label: Translation.tr("Contains"),
                        value: Translation.tr("%1 files, %2 folders").arg(files.length).arg(icons.length - files.length)
                    }
                ]
            };
        }
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

    function openItemMenu(icons, x, y, classic) {
        root.lastMenu = {
            kind: "item",
            icons: icons,
            x: x,
            y: y,
            classic: classic
        };
        if (icons.length === 1)
            DesktopIcons.queryOpenWith(icons[0].filePath);
        root.openMenu(classic ? root.classicItemModel(icons) : root.itemModel(icons), x, y);
    }

    function openBackgroundMenu(x, y, classic) {
        root.lastMenu = {
            kind: "background",
            x: x,
            y: y,
            classic: classic
        };
        root.openMenu(classic ? root.classicBackgroundModel() : root.backgroundModel(), x, y);
    }

    function refreshItemMenu() {
        const menu = root.lastMenu;
        if (!contextMenu.visible || menu === null || menu.kind !== "item")
            return;
        contextMenu.closeSub();
        contextMenu.model = menu.classic ? root.classicItemModel(menu.icons) : root.itemModel(menu.icons);
    }

    function showMoreOptions() {
        const menu = root.lastMenu;
        if (menu === null)
            return;
        Qt.callLater(() => {
            if (menu.kind === "item")
                root.openItemMenu(menu.icons, menu.x, menu.y, true);
            else
                root.openBackgroundMenu(menu.x, menu.y, true);
        });
    }

    function openWithModel(icon) {
        if (DesktopIcons.openWithPath !== icon.filePath)
            return [
                {
                    text: Translation.tr("Searching..."),
                    enabled: false
                }
            ];
        const entries = DesktopIcons.openWithApps.map(id => DesktopEntries.byId(id.replace(/\.desktop$/, ""))).filter(entry => entry !== null && entry !== undefined);
        if (entries.length === 0)
            return [
                {
                    text: Translation.tr("No application found"),
                    enabled: false
                }
            ];
        return entries.map(entry => ({
                    text: entry.name,
                    iconSource: Quickshell.iconPath(entry.icon, "application-x-executable"),
                    action: () => DesktopIcons.openWith(entry, [icon.filePath])
                }));
    }

    function openAll(icons) {
        for (const icon of icons)
            icon.open();
    }

    function startRename(icon) {
        root.renamingName = icon.fileName;
    }

    function itemModel(icons) {
        const single = icons.length === 1;
        const icon = icons[0];
        const actions = [
            {
                icon: "cut",
                action: () => root.copyIcons(icons, true)
            },
            {
                icon: "copy",
                action: () => root.copyIcons(icons, false)
            }
        ];
        if (single)
            actions.push({
                icon: "rename",
                action: () => root.startRename(icon)
            });
        actions.push({
            icon: "delete",
            action: () => DesktopIcons.trash(root.paths(icons))
        });
        return [
            {
                type: "row",
                items: actions
            },
            {
                text: Translation.tr("Open"),
                icon: "open",
                shortcut: "Enter",
                action: () => root.openAll(icons)
            },
            single ? {
                text: Translation.tr("Open with"),
                icon: "apps",
                submenu: root.openWithModel(icon)
            } : null,
            single && icon.fileIsDir ? {
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
                action: () => DesktopIcons.compress(root.paths(icons))
            },
            {
                text: Translation.tr("Copy as path"),
                icon: "link",
                shortcut: "Ctrl+Shift+C",
                action: () => DesktopIcons.copyPath(root.paths(icons))
            },
            {
                text: Translation.tr("Properties"),
                icon: "info",
                shortcut: "Alt+Enter",
                action: () => root.showProperties(icons)
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

    function classicItemModel(icons) {
        const single = icons.length === 1;
        const icon = icons[0];
        return [
            {
                text: Translation.tr("Open"),
                action: () => root.openAll(icons)
            },
            single ? {
                text: Translation.tr("Open with"),
                submenu: root.openWithModel(icon)
            } : null,
            single && icon.fileIsDir ? {
                text: Translation.tr("Open in Terminal"),
                action: () => DesktopIcons.openTerminal(icon.filePath)
            } : null,
            {
                type: "separator"
            },
            {
                text: Translation.tr("Cut"),
                shortcut: "Ctrl+X",
                action: () => root.copyIcons(icons, true)
            },
            {
                text: Translation.tr("Copy"),
                shortcut: "Ctrl+C",
                action: () => root.copyIcons(icons, false)
            },
            {
                type: "separator"
            },
            {
                text: Translation.tr("Create shortcut"),
                action: () => {
                    for (const target of icons)
                        DesktopIcons.createShortcut(target.filePath, target.fileName);
                }
            },
            {
                text: Translation.tr("Delete"),
                shortcut: "Del",
                action: () => DesktopIcons.trash(root.paths(icons))
            },
            single ? {
                text: Translation.tr("Rename"),
                shortcut: "F2",
                action: () => root.startRename(icon)
            } : null,
            {
                type: "separator"
            },
            {
                text: Translation.tr("Properties"),
                shortcut: "Alt+Enter",
                action: () => root.showProperties(icons)
            }
        ].filter(entry => entry !== null);
    }

    function undoEntry() {
        if (DesktopIcons.undoLabel.length === 0)
            return null;
        return {
            text: Translation.tr("Undo %1").arg(DesktopIcons.undoLabel),
            icon: "arrow-undo",
            shortcut: "Ctrl+Z",
            action: () => DesktopIcons.undo()
        };
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
            root.undoEntry(),
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
        ].filter(entry => entry !== null);
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
            root.undoEntry(),
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
        ].filter(entry => entry !== null);
    }

    function handleKey(event) {
        const control = (event.modifiers & Qt.ControlModifier) !== 0;
        const shift = (event.modifiers & Qt.ShiftModifier) !== 0;
        const alt = (event.modifiers & Qt.AltModifier) !== 0;
        const icons = root.selectedIcons();
        if (event.key === Qt.Key_F5) {
            root.refresh();
            return true;
        }
        if (control && event.key === Qt.Key_V) {
            DesktopIcons.paste();
            return true;
        }
        if (control && event.key === Qt.Key_Z) {
            DesktopIcons.undo();
            return true;
        }
        if (control && event.key === Qt.Key_A) {
            root.selectAll();
            return true;
        }
        if (icons.length === 0)
            return false;
        if (event.key === Qt.Key_Delete) {
            DesktopIcons.trash(root.paths(icons));
            return true;
        }
        if (event.key === Qt.Key_F2 && icons.length === 1) {
            root.startRename(icons[0]);
            return true;
        }
        if (alt && (event.key === Qt.Key_Return || event.key === Qt.Key_Enter)) {
            root.showProperties(icons);
            return true;
        }
        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
            root.openAll(icons);
            return true;
        }
        if (control && shift && event.key === Qt.Key_C) {
            DesktopIcons.copyPath(root.paths(icons));
            return true;
        }
        if (control && event.key === Qt.Key_C) {
            root.copyIcons(icons, false);
            return true;
        }
        if (control && event.key === Qt.Key_X) {
            root.copyIcons(icons, true);
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

        function onOpenWithAppsChanged() {
            root.refreshItemMenu();
        }
    }

    MouseArea {
        id: background

        property point origin: Qt.point(0, 0)
        property var baseSelection: []

        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onPressed: mouse => {
            root.forceActiveFocus();
            root.closeMenu();
            root.renamingName = "";
            if (mouse.button === Qt.RightButton) {
                root.clearSelection();
                root.openBackgroundMenu(mouse.x, mouse.y, false);
                return;
            }
            origin = Qt.point(mouse.x, mouse.y);
            const keep = (mouse.modifiers & Qt.ControlModifier) !== 0;
            baseSelection = keep ? root.selectedNames : [];
            if (!keep)
                root.clearSelection();
            root.bandActive = false;
        }
        onPositionChanged: mouse => {
            if (!(pressedButtons & Qt.LeftButton))
                return;
            if (!root.bandActive && Math.hypot(mouse.x - origin.x, mouse.y - origin.y) < 6)
                return;
            root.bandActive = true;
            root.bandX = Math.min(origin.x, mouse.x);
            root.bandY = Math.min(origin.y, mouse.y);
            root.bandWidth = Math.abs(mouse.x - origin.x);
            root.bandHeight = Math.abs(mouse.y - origin.y);
            root.selectInBand(baseSelection);
        }
        onReleased: root.bandActive = false
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
            selected: root.isSelected(fileName)
            renaming: root.renamingName === fileName
            following: root.dragPrimary.length > 0
            followX: root.dragPrimary.length > 0 && fileName !== root.dragPrimary && root.isSelected(fileName) ? root.dragDeltaX : 0
            followY: root.dragPrimary.length > 0 && fileName !== root.dragPrimary && root.isSelected(fileName) ? root.dragDeltaY : 0

            onClicked: modifiers => root.handlePress(icon, modifiers)
            onClickReleased: modifiers => root.handleRelease(icon, modifiers)
            onDragMoved: (deltaX, deltaY) => root.followDrag(fileName, deltaX, deltaY)
            onContextRequested: (x, y) => {
                if (!root.isSelected(fileName))
                    root.selectOnly(fileName);
                root.openItemMenu(root.selectedIcons(), x, y, false);
            }
            onDropped: (centerX, centerY) => {
                root.dropSelection(fileName, centerX, centerY);
                root.endDrag();
            }
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

    Rectangle {
        visible: root.bandActive
        x: root.bandX
        y: root.bandY
        width: root.bandWidth
        height: root.bandHeight
        color: Qt.alpha(Looks.colors.accent, 0.25)
        border.width: 1
        border.color: Looks.colors.accent
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
