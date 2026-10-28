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

    property var clipboardPaths: []
    property bool clipboardCut: false
    property var externalTypes: []
    readonly property bool canPaste: clipboardPaths.length > 0 || externalTypes.includes("x-special/gnome-copied-files") || externalTypes.includes("text/uri-list")

    function setPosition(name, entry) {
        const next = Object.assign({}, stateAdapter.positions);
        next[name] = entry;
        stateAdapter.positions = next;
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

    function trash(path) {
        Quickshell.execDetached(["gio", "trash", path]);
    }

    function rename(oldName, newName) {
        const target = newName.trim();
        if (target.length === 0 || target === oldName || target.includes("/"))
            return;
        Quickshell.execDetached(["mv", "-n", "--", `${root.desktopPath}/${oldName}`, `${root.desktopPath}/${target}`]);
        const next = Object.assign({}, stateAdapter.positions);
        if (next[oldName] !== undefined) {
            next[target] = next[oldName];
            delete next[oldName];
            stateAdapter.positions = next;
        }
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
    }

    function createTextFile(name) {
        Quickshell.execDetached(["touch", "--", `${root.desktopPath}/${name}`]);
    }

    function createShortcut(path, name) {
        Quickshell.execDetached(["ln", "-s", "--", path, `${root.desktopPath}/${name} - Shortcut`]);
    }

    function compress(path) {
        Quickshell.execDetached(["python3", root.filesScript, "zip", root.desktopPath, path]);
    }

    function copyPath(path) {
        Quickshell.clipboardText = path;
    }

    function transfer(paths, cut) {
        if (paths.length === 0)
            return;
        Quickshell.execDetached(["python3", root.filesScript, "transfer", root.desktopPath, cut ? "move" : "copy", ...paths]);
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
