pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import QtQuick

import qs.modules.common
import qs.modules.common.functions

Singleton {
    id: root

    readonly property string desktopUrl: Directories.desktop
    readonly property string desktopPath: FileUtils.trimFileProtocol(Directories.desktop)
    readonly property string filesScript: Quickshell.shellPath("scripts/desktop/files.py")
    readonly property var positions: stateAdapter.positions
    readonly property string viewSize: stateAdapter.viewSize
    readonly property bool autoArrange: stateAdapter.autoArrange
    readonly property bool alignToGrid: stateAdapter.alignToGrid
    readonly property bool showIcons: stateAdapter.showIcons
    readonly property string sortBy: stateAdapter.sortBy
    readonly property bool sortReversed: stateAdapter.sortReversed

    property var undoStack: []
    property string openWithPath: ""
    property var openWithApps: []
    property var clipboardPaths: []
    property bool clipboardCut: false
    property var externalTypes: []
    readonly property string undoLabel: undoStack.length > 0 ? undoStack[undoStack.length - 1].label : ""
    readonly property bool canPaste: clipboardPaths.length > 0 || externalTypes.includes("x-special/gnome-copied-files") || externalTypes.includes("text/uri-list")

    function setPosition(name, entry) {
        const next = Object.assign({}, stateAdapter.positions);
        next[name] = entry;
        stateAdapter.positions = next;
    }

    function setPositions(updates) {
        stateAdapter.positions = Object.assign({}, stateAdapter.positions, updates);
    }

    function clearPositions() {
        stateAdapter.positions = ({});
    }

    function setViewSize(size) {
        stateAdapter.viewSize = size;
    }

    function setAutoArrange(enabled) {
        stateAdapter.autoArrange = enabled;
    }

    function setAlignToGrid(enabled) {
        stateAdapter.alignToGrid = enabled;
    }

    function setShowIcons(enabled) {
        stateAdapter.showIcons = enabled;
    }

    function setSort(key) {
        if (stateAdapter.sortBy === key) {
            stateAdapter.sortReversed = !stateAdapter.sortReversed;
        } else {
            stateAdapter.sortBy = key;
            stateAdapter.sortReversed = false;
        }
        root.clearPositions();
    }

    function open(path) {
        Quickshell.execDetached(["xdg-open", path]);
    }

    function openTerminal(directory) {
        Quickshell.execDetached({
            command: ["bash", "-c", Config.options.apps.terminal],
            workingDirectory: directory
        });
    }

    function openSettings() {
        Quickshell.execDetached(["qs", "-p", Quickshell.shellPath("settings.qml")]);
    }

    function runJob(command, handler) {
        jobComponent.createObject(root, {
            command: command,
            handler: handler,
            running: true
        });
    }

    function parseResult(text) {
        try {
            return JSON.parse(text);
        } catch (error) {
            return {
                created: [],
                moved: []
            };
        }
    }

    function pushUndo(entry) {
        root.undoStack = root.undoStack.concat([entry]).slice(-20);
    }

    function undo() {
        if (root.undoStack.length === 0)
            return;
        const entry = root.undoStack[root.undoStack.length - 1];
        root.undoStack = root.undoStack.slice(0, -1);
        if (entry.kind === "rename") {
            Quickshell.execDetached(["mv", "-n", "--", entry.to, entry.from]);
            root.movePosition(entry.toName, entry.fromName);
        } else if (entry.kind === "delete") {
            Quickshell.execDetached(["python3", root.filesScript, "restore", ...entry.paths]);
        } else {
            for (const move of entry.moved ?? [])
                Quickshell.execDetached(["mv", "-n", "--", move.to, move.from]);
            if ((entry.created ?? []).length > 0)
                Quickshell.execDetached(["gio", "trash", ...entry.created]);
        }
    }

    function movePosition(fromName, toName) {
        const next = Object.assign({}, stateAdapter.positions);
        if (next[fromName] === undefined)
            return;
        next[toName] = next[fromName];
        delete next[fromName];
        stateAdapter.positions = next;
    }

    function trash(paths) {
        const list = Array.isArray(paths) ? paths : [paths];
        if (list.length === 0)
            return;
        Quickshell.execDetached(["gio", "trash", ...list]);
        root.pushUndo({
            kind: "delete",
            label: Translation.tr("Delete"),
            paths: list
        });
    }

    function rename(oldName, newName) {
        const target = newName.trim();
        if (target.length === 0 || target === oldName || target.includes("/"))
            return;
        Quickshell.execDetached(["mv", "-n", "--", `${root.desktopPath}/${oldName}`, `${root.desktopPath}/${target}`]);
        root.movePosition(oldName, target);
        root.pushUndo({
            kind: "rename",
            label: Translation.tr("Rename"),
            from: `${root.desktopPath}/${oldName}`,
            to: `${root.desktopPath}/${target}`,
            fromName: oldName,
            toName: target
        });
    }

    function uniqueName(base, existing) {
        if (!existing.includes(base))
            return base;
        for (let index = 2; ; index++) {
            const candidate = `${base} (${index})`;
            if (!existing.includes(candidate))
                return candidate;
        }
    }

    function createFolder(name) {
        Quickshell.execDetached(["mkdir", "-p", "--", `${root.desktopPath}/${name}`]);
        root.pushUndo({
            kind: "create",
            label: Translation.tr("New"),
            created: [`${root.desktopPath}/${name}`]
        });
    }

    function createTextFile(name) {
        Quickshell.execDetached(["touch", "--", `${root.desktopPath}/${name}`]);
        root.pushUndo({
            kind: "create",
            label: Translation.tr("New"),
            created: [`${root.desktopPath}/${name}`]
        });
    }

    function createShortcut(path, name) {
        const link = `${root.desktopPath}/${name} - Shortcut`;
        Quickshell.execDetached(["ln", "-s", "--", path, link]);
        root.pushUndo({
            kind: "create",
            label: Translation.tr("Create shortcut"),
            created: [link]
        });
    }

    function compress(paths) {
        const list = Array.isArray(paths) ? paths : [paths];
        root.runJob(["python3", root.filesScript, "zip", root.desktopPath, ...list], text => {
            const result = root.parseResult(text);
            root.pushUndo({
                kind: "zip",
                label: Translation.tr("Compress"),
                created: result.created,
                moved: result.moved
            });
        });
    }

    function copyPath(paths) {
        Quickshell.clipboardText = (Array.isArray(paths) ? paths : [paths]).join("\n");
    }

    function transfer(paths, cut) {
        if (paths.length === 0)
            return;
        root.runJob(["python3", root.filesScript, "transfer", root.desktopPath, cut ? "move" : "copy", ...paths], text => {
            const result = root.parseResult(text);
            if (result.created.length + result.moved.length === 0)
                return;
            root.pushUndo({
                kind: "paste",
                label: cut ? Translation.tr("Move") : Translation.tr("Copy"),
                created: result.created,
                moved: result.moved
            });
        });
    }

    function queryOpenWith(path) {
        root.openWithPath = path;
        root.openWithApps = [];
        root.runJob(["sh", "-c", "mime=$(gio info -a standard::content-type -- \"$1\" 2>/dev/null | sed -n 's/^ *standard::content-type: //p'); [ -n \"$mime\" ] && gio mime \"$mime\" 2>/dev/null", "sh", path], text => {
            const ids = [];
            for (const line of text.split("\n")) {
                const match = line.match(/^\s+(\S+\.desktop)\s*$/);
                if (match && !ids.includes(match[1]))
                    ids.push(match[1]);
            }
            if (root.openWithPath === path)
                root.openWithApps = ids;
        });
    }

    function openWith(entry, paths) {
        const command = entry.runInTerminal ? ["bash", "-c", Config.options.apps.terminal + " -e " + entry.command.concat(paths).map(part => "'" + part.replace(/'/g, "'\\''") + "'").join(" ")] : entry.command.concat(paths);
        Quickshell.execDetached(command);
    }

    function importUrls(urls) {
        root.transfer(urls.map(url => decodeURIComponent(String(url).replace(/^file:\/\//, ""))), false);
    }

    function copyFiles(paths, cut) {
        root.clipboardPaths = paths;
        root.clipboardCut = cut;
        const payload = `${cut ? "cut" : "copy"}\n${paths.map(path => "file://" + encodeURI(path)).join("\n")}`;
        Quickshell.execDetached(["sh", "-c", "printf '%s' \"$1\" | wl-copy --type x-special/gnome-copied-files", "sh", payload]);
    }

    function refreshClipboard() {
        typesProbe.running = true;
    }

    function paste() {
        pasteReader.running = true;
    }

    function finishPaste(text) {
        const lines = text.split("\n").map(line => line.trim()).filter(line => line.length > 0 && !line.startsWith("#"));
        let cut = false;
        if (lines.length > 0 && (lines[0] === "copy" || lines[0] === "cut")) {
            cut = lines[0] === "cut";
            lines.shift();
        }
        const paths = lines.filter(line => line.startsWith("file://")).map(line => decodeURIComponent(line.replace(/^file:\/\//, "")));
        if (paths.length > 0) {
            root.transfer(paths, cut);
            return;
        }
        root.transfer(root.clipboardPaths, root.clipboardCut);
        if (root.clipboardCut)
            root.clipboardPaths = [];
    }

    function parseLauncher(text) {
        const result = {
            name: "",
            icon: "",
            exec: ""
        };
        let inEntry = false;
        for (const line of text.split("\n")) {
            const trimmed = line.trim();
            if (trimmed.startsWith("[")) {
                inEntry = trimmed === "[Desktop Entry]";
                continue;
            }
            const separator = trimmed.indexOf("=");
            if (!inEntry || separator < 0)
                continue;
            const key = trimmed.slice(0, separator);
            const value = trimmed.slice(separator + 1);
            if (key === "Name")
                result.name = value;
            else if (key === "Icon")
                result.icon = value;
            else if (key === "Exec")
                result.exec = value;
        }
        return result;
    }

    function runExec(exec) {
        const command = exec.replace(/%[a-zA-Z%]/g, "").trim();
        if (command.length === 0)
            return;
        Quickshell.execDetached(["sh", "-c", command]);
    }

    Component {
        id: jobComponent

        Process {
            id: job

            property var handler: null

            stdout: StdioCollector {
                onStreamFinished: {
                    if (job.handler)
                        job.handler(text);
                    job.destroy();
                }
            }
        }
    }

    Process {
        id: typesProbe
        command: ["sh", "-c", "wl-paste --list-types 2>/dev/null"]
        stdout: StdioCollector {
            onStreamFinished: root.externalTypes = text.split("\n").map(line => line.trim())
        }
    }

    Process {
        id: pasteReader
        command: ["sh", "-c", "wl-paste --no-newline --type x-special/gnome-copied-files 2>/dev/null || wl-paste --no-newline --type text/uri-list 2>/dev/null"]
        stdout: StdioCollector {
            onStreamFinished: root.finishPaste(text)
        }
    }

    Timer {
        id: reloadTimer
        interval: 100
        onTriggered: stateFile.reload()
    }

    Timer {
        id: writeTimer
        interval: 100
        onTriggered: stateFile.writeAdapter()
    }

    FileView {
        id: stateFile
        path: `${Directories.state}/desktop-icons.json`
        printErrors: false
        watchChanges: true
        onFileChanged: reloadTimer.restart()
        onAdapterUpdated: writeTimer.restart()
        onLoadFailed: error => {
            if (error == FileViewError.FileNotFound)
                writeTimer.restart();
        }

        adapter: JsonAdapter {
            id: stateAdapter

            property var positions: ({})
            property string viewSize: "medium"
            property bool autoArrange: false
            property bool alignToGrid: true
            property bool showIcons: true
            property string sortBy: "name"
            property bool sortReversed: false
        }
    }
}
