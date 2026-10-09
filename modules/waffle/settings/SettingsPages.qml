pragma Singleton
import QtQuick
import Quickshell

Singleton {
    id: root

    readonly property var pages: [
        {
            id: "system", name: "System", icon: "desktop", tint: "#4CC2FF", cards: [
                { icon: "desktop", title: "Display", subtitle: "Monitors, brightness, night light, display profile" },
                { icon: "speaker", title: "Sound", subtitle: "Volume levels, output, input, sound devices" },
                { icon: "alert", title: "Notifications", subtitle: "Alerts from apps and system" },
                { icon: "weather-moon", title: "Focus assist", subtitle: "Notifications, automatic rules" },
                { icon: "power", title: "Power", subtitle: "Sleep, battery usage, battery saver" },
                { icon: "server", title: "Storage", subtitle: "Storage space, drives, configuration rules" },
                { icon: "open", title: "Nearby sharing", subtitle: "Discoverability, received files location" },
                { icon: "apps", title: "Multitasking", subtitle: "Snap windows, desktops, task switching" },
                { icon: "settings-cog-multiple", title: "For developers", subtitle: "These settings are intended for development use only" },
                { icon: "checkmark", title: "Activation", subtitle: "Activation state, subscriptions, product key" },
                { icon: "wand", title: "Troubleshoot", subtitle: "Recommended troubleshooters, preferences, history" },
                { icon: "arrow-counterclockwise", title: "Recovery", subtitle: "Reset, advanced startup, go back" },
                { icon: "desktop-speaker", title: "Projecting to this PC", subtitle: "Permissions, pairing PIN, discoverability" },
                { icon: "desktop", title: "Remote Desktop", subtitle: "Remote Desktop users, connection permissions" },
                { icon: "library", title: "Clipboard", subtitle: "Cut and copy history, sync, clear" },
                { icon: "corporation", title: "About", subtitle: "Device specifications, rename PC, Windows specifications" }
            ]
        },
        {
            id: "bluetooth", name: "Bluetooth & devices", icon: "bluetooth", tint: "#4CA3FF", cards: [
                { icon: "bluetooth", title: "Devices", subtitle: "Mouse, keyboard, pen, audio, displays and docks, other devices" },
                { icon: "desktop-speaker", title: "Printers & scanners", subtitle: "Preferences, troubleshoot" },
                { icon: "phone", title: "Phone Link", subtitle: "Instantly access your Android device's photos, texts, and more" },
                { icon: "camera", title: "Cameras", subtitle: "Connected cameras, default image settings" },
                { icon: "options", title: "Mouse", subtitle: "Buttons, mouse pointer speed, scrolling" },
                { icon: "options", title: "Touchpad", subtitle: "Taps, gestures, scrolling, zooming" },
                { icon: "options", title: "Pen & Windows Ink", subtitle: "Right-handed or left-handed, pen button shortcuts, handwriting" },
                { icon: "play", title: "AutoPlay", subtitle: "Defaults for removable drives and memory cards" },
                { icon: "flash-on", title: "USB", subtitle: "Notifications, USB battery saver, mobile device preferences" }
            ]
        },
        {
            id: "network", name: "Network & internet", icon: "wifi-1", tint: "#3CC8E6", cards: [
                { icon: "wifi-1", title: "Wi-Fi", subtitle: "Connect, known networks, metered connection" },
                { icon: "ethernet", title: "Ethernet", subtitle: "Authentication, metered connection" },
                { icon: "shield-lock", title: "VPN", subtitle: "Add, connect, manage" },
                { icon: "globe-search", title: "Mobile hotspot", subtitle: "Share your internet connection" },
                { icon: "flash-off", title: "Airplane mode", subtitle: "Stop all wireless communication" },
                { icon: "globe-shield", title: "Proxy", subtitle: "Proxy server for Wi-Fi and Ethernet connections" },
                { icon: "phone", title: "Dial-up", subtitle: "Set up a dial-up internet connection" },
                { icon: "settings", title: "Advanced network settings", subtitle: "View all network adapters, network reset" }
            ]
        },
        {
            id: "personalization", name: "Personalization", icon: "wand", tint: "#FF9F3D", cards: []
        },
        {
            id: "apps", name: "Apps", icon: "apps", tint: "#7FA6D9", cards: [
                { icon: "apps", title: "Installed apps", subtitle: "Uninstall and manage apps on your device" },
                { icon: "settings", title: "Advanced app settings", subtitle: "Choose where to get apps, app execution aliases, archive apps" },
                { icon: "checkmark", title: "Default apps", subtitle: "Defaults for file and link types, other defaults" },
                { icon: "globe-search", title: "Offline maps", subtitle: "Downloads, storage location, map updates" },
                { icon: "add", title: "Optional features", subtitle: "Extra functionality for your device" },
                { icon: "open", title: "Apps for websites", subtitle: "Websites that can open in an app instead of a browser" },
                { icon: "play", title: "Video playback", subtitle: "Video adjustments, HDR streaming, battery options" },
                { icon: "start-here", title: "Startup", subtitle: "Apps that start automatically when you sign in" }
            ]
        },
        {
            id: "accounts", name: "Accounts", icon: "people", tint: "#3DC98B", cards: [
                { icon: "people", title: "Your info", subtitle: "Account settings: email, calendar, contacts, account picture" },
                { icon: "library", title: "Email & accounts", subtitle: "Accounts used by email, calendar, and contacts" },
                { icon: "lock-closed", title: "Sign-in options", subtitle: "Windows Hello, security key, password, dynamic lock" },
                { icon: "arrow-sync", title: "Windows backup", subtitle: "Back up your files, apps, preferences to restore them across devices" },
                { icon: "corporation", title: "Access work or school", subtitle: "Organization resources like email, apps, and network" },
                { icon: "people-team", title: "Family & other users", subtitle: "Device access, work or school users, kiosk" }
            ]
        },
        {
            id: "time", name: "Time & language", icon: "globe-search", tint: "#5DA9F2", cards: [
                { icon: "calendar-add", title: "Date & time", subtitle: "Time zones, automatic clock settings, calendar display" },
                { icon: "globe-search", title: "Language & region", subtitle: "Windows display language, preferred language, regional format" },
                { icon: "keyboard", title: "Typing", subtitle: "Touch keyboard, text suggestions, autocorrect" },
                { icon: "mic", title: "Speech", subtitle: "Speech language, speech recognition microphone setup, voices" }
            ]
        },
        {
            id: "gaming", name: "Gaming", icon: "games", tint: "#A0A7B4", cards: [
                { icon: "games", title: "Xbox Game Bar", subtitle: "Controller and keyboard shortcuts, game recording preferences" },
                { icon: "record", title: "Captures", subtitle: "Screen captures, game recording, audio, capture location" },
                { icon: "flash-on", title: "Game Mode", subtitle: "Optimize your PC for playing games" }
            ]
        },
        {
            id: "accessibility", name: "Accessibility", icon: "eye", tint: "#4CA3FF", cards: [
                { icon: "options", title: "Text size", subtitle: "Text size that appears across Windows and your apps" },
                { icon: "eye", title: "Visual effects", subtitle: "Scroll bars, transparency, animations, notification timeouts" },
                { icon: "options", title: "Mouse pointer and touch", subtitle: "Pointer color, size" },
                { icon: "keyboard", title: "Text cursor", subtitle: "Text cursor indicator, thickness" },
                { icon: "search-visual", title: "Magnifier", subtitle: "Magnifier reading, zoom increment" },
                { icon: "eyedropper", title: "Color filters", subtitle: "Color filters for colorblindness, grayscale" },
                { icon: "dark-theme", title: "Contrast themes", subtitle: "Color themes for low vision, light sensitivity" },
                { icon: "speaker", title: "Narrator", subtitle: "Voice, verbosity, keyboard, braille" }
            ]
        },
        {
            id: "privacy", name: "Privacy & security", icon: "shield", tint: "#A0A7B4", cards: [
                { icon: "shield", title: "Windows Security", subtitle: "Antivirus, browser, firewall, and network protection for your device" },
                { icon: "temperature", title: "Find my device", subtitle: "Track your device in case it's lost or stolen" },
                { icon: "settings-cog-multiple", title: "For developers", subtitle: "These settings are intended for development use only" },
                { icon: "window-shield", title: "General", subtitle: "Advertising ID, local content, app launch, settings suggestions" },
                { icon: "mic", title: "Speech", subtitle: "Online speech recognition" },
                { icon: "camera", title: "Camera", subtitle: "Apps that can use your camera" },
                { icon: "mic-on", title: "Microphone", subtitle: "Apps that can use your microphone" }
            ]
        },
        {
            id: "update", name: "Windows Update", icon: "arrow-sync", tint: "#3C9CF0", cards: [
                { icon: "arrow-sync", title: "Check for updates", subtitle: "You're up to date" },
                { icon: "pause", title: "Pause updates", subtitle: "Pause for 1 week" },
                { icon: "arrow-counterclockwise", title: "Update history", subtitle: "" },
                { icon: "settings", title: "Advanced options", subtitle: "Delivery optimization, optional updates, active hours, other update settings" },
                { icon: "people", title: "Windows Insider Program", subtitle: "Get preview builds of Windows to share feedback on new features and updates" }
            ]
        }
    ]

    function search(query) {
        const q = query.trim().toLowerCase();
        if (q.length === 0) return [];
        const results = [];
        for (const page of root.pages) {
            for (const card of page.cards) {
                const hay = `${card.title} ${card.subtitle}`.toLowerCase();
                if (hay.indexOf(q) !== -1) results.push({ page: page.name, icon: card.icon, tint: page.tint, title: card.title, subtitle: card.subtitle });
            }
        }
        return results;
    }
}
