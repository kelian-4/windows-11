local programs = require("hyprlua/programs")

local mainMod = "SUPER"

local function shellShortcut(name)
    return hl.dsp.global("quickshell:" .. name)
end

hl.bind(mainMod .. " + S", shellShortcut("searchToggle"))
hl.bind(mainMod .. " + A", shellShortcut("sidebarLeftToggle"))
hl.bind(mainMod .. " + N", shellShortcut("sidebarRightToggle"))
hl.bind(mainMod .. " + W", shellShortcut("widgetsToggle"))
hl.bind(mainMod .. " + C", shellShortcut("aiToggle"))
hl.bind(mainMod .. " + V", shellShortcut("overviewClipboardToggle"))
hl.bind(mainMod .. " + period", shellShortcut("overviewEmojiToggle"))
hl.bind(mainMod .. " + X", shellShortcut("sessionToggle"))
hl.bind(mainMod .. " + K", shellShortcut("mediaControlsToggle"))
hl.bind(mainMod .. " + F1", shellShortcut("cheatsheetToggle"))
hl.bind(mainMod .. " + L", shellShortcut("lock"))
hl.bind("CTRL + " .. mainMod .. " + O", shellShortcut("oskToggle"))
hl.bind(mainMod .. " + SHIFT + S", shellShortcut("regionScreenshot"))
hl.bind(mainMod .. " + SHIFT + R", shellShortcut("regionRecord"))
hl.bind(mainMod .. " + SHIFT + T", shellShortcut("regionOcr"))
hl.bind("PRINT", shellShortcut("regionScreenshot"))

hl.bind(mainMod .. " + I", hl.dsp.exec_cmd(programs.settings))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(programs.fileManager))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(programs.browser))
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(programs.terminal))
hl.bind("CTRL + ALT + T", hl.dsp.exec_cmd(programs.terminal))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd(programs.codeEditor))
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd("hyprctl switchxkblayout all next"))

hl.bind("ALT + F4", hl.dsp.window.close())
hl.bind("F11", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + Z", hl.dsp.window.float())
hl.bind("CTRL + ALT + Escape", hl.dsp.exec_cmd("hyprctl kill"))

hl.bind("ALT + Tab", hl.dsp.window.cycle_next(), { repeating = true })
hl.bind("ALT + SHIFT + Tab", hl.dsp.window.cycle_next({ next = false }), { repeating = true })
hl.bind(mainMod .. " + Tab", shellShortcut("overviewWorkspacesToggle"))

local resizeStep = 40
local resizeDeltas = {
    left = { -resizeStep, 0 },
    right = { resizeStep, 0 },
    up = { 0, -resizeStep },
    down = { 0, resizeStep },
}

for _, direction in ipairs({ "left", "right", "up", "down" }) do
    local delta = resizeDeltas[direction]
    hl.bind(mainMod .. " + " .. direction, hl.dsp.focus({ direction = direction }))
    hl.bind(mainMod .. " + SHIFT + " .. direction, hl.dsp.window.move({ direction = direction }))
    hl.bind(
        mainMod .. " + ALT + " .. direction,
        hl.dsp.window.resize({ x = delta[1], y = delta[2], relative = true }),
        { repeating = true }
    )
end

for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind("CTRL + " .. mainMod .. " + left", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("CTRL + " .. mainMod .. " + right", hl.dsp.focus({ workspace = "e+1" }))

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e2 set 5%-"), { locked = true, repeating = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

hl.on("config.reloaded", function()
    hl.dispatch(hl.dsp.submap("reset"))
end)
