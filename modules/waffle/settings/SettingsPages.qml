pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import qs.services

Singleton {
    id: root

    readonly property var pages: [
        {
            name: Translation.tr("System"), icon: "desktop", tint: "#4CC2FF", kind: "page", hero: true,
            source: "modules/settings/GeneralConfig.qml",
            subs: [
                { title: Translation.tr("About"), subtitle: Translation.tr("Distribution, project and links"), icon: "app-generic", source: "modules/settings/About.qml" }
            ]
        },
        { name: Translation.tr("Bluetooth & devices"), icon: "bluetooth", tint: "#4CA3FF", kind: "page", source: "modules/settings/BluetoothConfig.qml", subs: [] },
        { name: Translation.tr("Network & internet"), icon: "wifi-1", tint: "#3CC8E6", kind: "page", source: "modules/settings/NetworkConfig.qml", subs: [] },
        {
            name: Translation.tr("Personalization"), icon: "wand", tint: "#FF9F3D", kind: "hub",
            subs: [
                { title: Translation.tr("Background & colors"), subtitle: Translation.tr("Wallpaper, light or dark mode, accent color"), icon: "image", source: "modules/settings/QuickConfig.qml" },
                { title: Translation.tr("Desktop"), subtitle: Translation.tr("Parallax, clock and weather widgets"), icon: "apps", source: "modules/settings/BackgroundConfig.qml" },
                { title: Translation.tr("Taskbar"), subtitle: Translation.tr("Position, alignment, notification area"), icon: "start-here", source: "modules/settings/BarConfig.qml" },
                { title: Translation.tr("Interface"), subtitle: Translation.tr("Lock screen, notifications, cheat sheet, overlay"), icon: "desktop", source: "modules/settings/InterfaceConfig.qml" },
                { title: Translation.tr("Color generation"), subtitle: Translation.tr("Themes for apps and terminal"), icon: "eyedropper", source: "modules/settings/AdvancedConfig.qml" }
            ]
        },
        {
            name: Translation.tr("Apps"), icon: "apps", tint: "#7FA6D9", kind: "hub",
            subs: [
                { title: Translation.tr("Services"), subtitle: Translation.tr("AI, music recognition, networking, search and weather"), icon: "server", source: "modules/settings/ServicesConfig.qml" }
            ]
        },
        { name: Translation.tr("Accounts"), icon: "people", tint: "#3DC98B", kind: "page", source: "modules/settings/AccountsConfig.qml", subs: [] },
        {
            name: Translation.tr("Time & language"), icon: "globe-search", tint: "#5DA9F2", kind: "hub",
            subs: [
                { title: Translation.tr("Date & time"), subtitle: Translation.tr("Clock format, date format, seconds"), icon: "calendar-add", source: "modules/settings/DateTimeConfig.qml" },
                { title: Translation.tr("Language & region"), subtitle: Translation.tr("Interface language, translations"), icon: "globe-search", source: "modules/settings/LanguageConfig.qml" },
                { title: Translation.tr("Typing"), subtitle: Translation.tr("Touch keyboard, text suggestions, autocorrect"), icon: "keyboard", soon: true },
                { title: Translation.tr("Speech"), subtitle: Translation.tr("Speech language, microphone setup, voices"), icon: "mic", soon: true }
            ]
        },
        {
            name: Translation.tr("Gaming"), icon: "games", tint: "#A0A7B4", kind: "hub",
            subs: [
                { title: Translation.tr("Captures"), subtitle: Translation.tr("Screenshot and recording locations"), icon: "record", source: "modules/settings/CapturesConfig.qml" },
                { title: Translation.tr("Game Mode"), subtitle: Translation.tr("Optimize your PC for playing games"), icon: "flash-on", soon: true },
                { title: Translation.tr("Game Bar"), subtitle: Translation.tr("Controller and keyboard shortcuts, game recording preferences"), icon: "games", soon: true }
            ]
        },
        {
            name: Translation.tr("Accessibility"), icon: "eye", tint: "#4CA3FF", kind: "hub",
            subs: [
                { title: Translation.tr("Visual effects"), subtitle: Translation.tr("Transparency and transparency level"), icon: "eye", source: "modules/settings/VisualEffectsConfig.qml" },
                { title: Translation.tr("Text size"), subtitle: Translation.tr("Text size that appears across the system and your apps"), icon: "options", soon: true },
                { title: Translation.tr("Mouse pointer and touch"), subtitle: Translation.tr("Pointer color, size"), icon: "options", soon: true },
                { title: Translation.tr("Text cursor"), subtitle: Translation.tr("Text cursor indicator, thickness"), icon: "keyboard", soon: true },
                { title: Translation.tr("Magnifier"), subtitle: Translation.tr("Magnifier reading, zoom increment"), icon: "search-visual", soon: true },
                { title: Translation.tr("Color filters"), subtitle: Translation.tr("Color filters for colorblindness, grayscale"), icon: "eyedropper", soon: true },
                { title: Translation.tr("Contrast themes"), subtitle: Translation.tr("Color themes for low vision, light sensitivity"), icon: "dark-theme", soon: true },
                { title: Translation.tr("Narrator"), subtitle: Translation.tr("Voice, verbosity, keyboard, braille"), icon: "speaker", soon: true }
            ]
        },
        {
            name: Translation.tr("Privacy & security"), icon: "shield", tint: "#A0A7B4", kind: "hub",
            subs: [
                { title: Translation.tr("Microphone & screen sharing"), subtitle: Translation.tr("See which features are currently in use"), icon: "mic-on", source: "modules/settings/PrivacyActivityConfig.qml" },
                { title: Translation.tr("Work safety"), subtitle: Translation.tr("Clipboard and content safety"), icon: "shield-lock", source: "modules/settings/WorkSafetyConfig.qml" },
                { title: Translation.tr("Security"), subtitle: Translation.tr("Firewall and device protection"), icon: "shield", soon: true },
                { title: Translation.tr("Find my device"), subtitle: Translation.tr("Track your device in case it's lost or stolen"), icon: "temperature", soon: true }
            ]
        },
        { name: Translation.tr("System updates"), icon: "arrow-sync", tint: "#3C9CF0", kind: "page", source: "modules/settings/UpdatesConfig.qml", subs: [] }
    ]

    readonly property var sources: {
        const list = [];
        for (let i = 0; i < root.pages.length; i++) {
            const page = root.pages[i];
            if (page.source) list.push({ page: i, sub: -1, source: page.source });
            for (let j = 0; j < page.subs.length; j++) if (page.subs[j].source) list.push({ page: i, sub: j, source: page.subs[j].source });
        }
        return list;
    }

    property var entries: []

    function indexPage(pageIndex, subIndex, content) {
        const pattern = /(?:title|text|displayName|mainText|buttonText)\s*:\s*Translation\.tr\("((?:[^"\\]|\\.)*)"\)/g;
        const found = [];
        const seen = {};
        let match;
        while ((match = pattern.exec(content)) !== null) {
            const label = match[1].replace(/\\"/g, '"');
            if (label.length < 2 || label.length > 90 || seen[label]) continue;
            seen[label] = true;
            found.push({ page: pageIndex, sub: subIndex, text: label });
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
                results.push({ title: page.name, subtitle: "", page: i, sub: -1, icon: page.icon, tint: page.tint });
                seen[`${i}|-1|${page.name}`] = true;
            }
            for (let j = 0; j < page.subs.length; j++) {
                const sub = page.subs[j];
                if (sub.title.toLowerCase().indexOf(q) !== -1) {
                    results.push({ title: sub.title, subtitle: page.name, page: i, sub: sub.soon ? -1 : j, icon: sub.icon, tint: page.tint });
                    seen[`${i}|${j}|${sub.title}`] = true;
                }
            }
        }
        for (const entry of root.entries) {
            const translated = Translation.tr(entry.text);
            if (entry.text.toLowerCase().indexOf(q) === -1 && translated.toLowerCase().indexOf(q) === -1) continue;
            const key = `${entry.page}|${entry.sub}|${translated}`;
            if (seen[key]) continue;
            seen[key] = true;
            const page = root.pages[entry.page];
            const where = entry.sub >= 0 ? `${page.name}  ›  ${page.subs[entry.sub].title}` : page.name;
            results.push({ title: translated, subtitle: where, page: entry.page, sub: entry.sub, icon: page.icon, tint: page.tint });
        }
        return results.slice(0, 80);
    }

    Instantiator {
        model: root.sources
        delegate: FileView {
            required property var modelData
            path: Quickshell.shellPath(modelData.source)
            printErrors: false
            onLoaded: root.indexPage(modelData.page, modelData.sub, text())
        }
    }
}
