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
    readonly property var positions: stateAdapter.positions

    function setPosition(name, column, row) {
        const next = Object.assign({}, stateAdapter.positions);
        next[name] = {
            column: column,
            row: row
        };
        stateAdapter.positions = next;
    }

    function clearPositions() {
        stateAdapter.positions = ({});
    }

    function open(path) {
        Quickshell.execDetached(["xdg-open", path]);
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

    function importUrls(urls) {
        const paths = urls.map(url => decodeURIComponent(String(url).replace(/^file:\/\//, "")));
        if (paths.length === 0)
            return;
        Quickshell.execDetached(["cp", "-rn", "--", ...paths, root.desktopPath]);
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
        }
    }
}
