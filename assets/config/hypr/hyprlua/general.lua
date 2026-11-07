hl.config({
    general = {
        gaps_in = 4,
        gaps_out = 8,
        border_size = 1,

        col = {
            active_border = "rgba(ffffff40)",
            inactive_border = "rgba(ffffff14)",
        },

        resize_on_border = true,
        allow_tearing = false,
        layout = "dwindle",

        snap = {
            enabled = true,
            window_gap = 8,
            monitor_gap = 8,
            respect_gaps = true,
        },
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },
})
