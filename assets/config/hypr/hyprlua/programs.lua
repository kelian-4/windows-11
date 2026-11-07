local function firstAvailable(candidates)
    local parts = {}
    for i, cmd in ipairs(candidates) do
        local bin = cmd:match("^%S+")
        parts[#parts + 1] = (i == 1 and "if" or "elif") .. " command -v " .. bin .. " >/dev/null 2>&1; then exec " .. cmd
    end
    return table.concat(parts, "; ") .. "; fi"
end

return {
    terminal = firstAvailable({ "kitty", "foot", "alacritty", "wezterm", "ghostty", "konsole", "gnome-terminal", "xterm" }),
    fileManager = firstAvailable({ "nautilus", "dolphin", "thunar", "pcmanfm-qt", "pcmanfm", "nemo", "caja" }),
    browser = firstAvailable({ "microsoft-edge-stable", "firefox", "zen-browser", "brave", "google-chrome-stable", "chromium", "librewolf", "vivaldi", "opera" }),
    codeEditor = firstAvailable({ "code", "codium", "cursor", "zeditor", "zed", "kate", "gnome-text-editor", "gedit" }),
    shell = "qs -c windows-11",
    settings = "qs -p ~/.config/quickshell/windows-11/settings.qml",
    cursor = {
        theme = "Win11-Cursor",
        size = 24,
    },
}
