hl.config({
    input = {
        kb_layout = "us",
        follow_mouse = 1,
        sensitivity = 0,

        touchpad = {
            natural_scroll = false,
            clickfinger_behavior = true,
            tap_to_click = true,
            disable_while_typing = true,
        },
    },

    cursor = {
        hide_on_key_press = true,
    },
})

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
