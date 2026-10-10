pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import qs.services

Singleton {
    id: root

    readonly property var pages: [
        { name: Translation.tr("System"), icon: "desktop", tint: "#4CC2FF", source: "modules/settings/GeneralConfig.qml", hero: true },
        { name: Translation.tr("Personalization"), icon: "wand", tint: "#FF9F3D", source: "modules/settings/QuickConfig.qml", hero: false },
        { name: Translation.tr("Taskbar"), icon: "start-here", tint: "#4CA3FF", source: "modules/settings/BarConfig.qml", hero: false },
        { name: Translation.tr("Desktop"), icon: "image", tint: "#3DC98B", source: "modules/settings/BackgroundConfig.qml", hero: false },
        { name: Translation.tr("Interface"), icon: "apps", tint: "#5DA9F2", source: "modules/settings/InterfaceConfig.qml", hero: false },
        { name: Translation.tr("Services"), icon: "server", tint: "#3CC8E6", source: "modules/settings/ServicesConfig.qml", hero: false },
        { name: Translation.tr("Advanced"), icon: "settings-cog-multiple", tint: "#A0A7B4", source: "modules/settings/AdvancedConfig.qml", hero: false },
        { name: Translation.tr("About"), icon: "app-generic", tint: "#A0A7B4", source: "modules/settings/About.qml", hero: false }
    ]

    property var entries: []

    function indexPage(pageIndex, content) {
        const pattern = /(?:title|text|displayName|mainText|buttonText)\s*:\s*Translation\.tr\("((?:[^"\\]|\\.)*)"\)/g;
        const found = [];
        const seen = {};
        let match;
        while ((match = pattern.exec(content)) !== null) {
            const label = match[1].replace(/\\"/g, '"');
            if (label.length < 2 || label.length > 90 || seen[label]) continue;
            seen[label] = true;
            found.push({ page: pageIndex, text: label });
        }
        root.entries = root.entries.concat(found);
    }

    function search(query) {
        const q = query.trim().toLowerCase();
        if (q.length === 0) return [];
        const results = [];
        const seen = {};
        for (let i = 0; i < root.pages.length; i++) {
            const page = root.pages[i];
            if (page.name.toLowerCase().indexOf(q) !== -1) {
                results.push({ title: page.name, subtitle: "", index: i, icon: page.icon, tint: page.tint });
                seen[`${i}|${page.name}`] = true;
            }
        }
        for (const entry of root.entries) {
            const translated = Translation.tr(entry.text);
            if (entry.text.toLowerCase().indexOf(q) === -1 && translated.toLowerCase().indexOf(q) === -1) continue;
            const key = `${entry.page}|${translated}`;
            if (seen[key]) continue;
            seen[key] = true;
            const page = root.pages[entry.page];
            results.push({ title: translated, subtitle: page.name, index: entry.page, icon: page.icon, tint: page.tint });
        }
        return results.slice(0, 80);
    }

    Instantiator {
        model: root.pages
        delegate: FileView {
            required property var modelData
            required property int index
            path: Quickshell.shellPath(modelData.source)
            printErrors: false
            onLoaded: root.indexPage(index, text())
        }
    }
}
