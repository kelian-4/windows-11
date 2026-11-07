hl.config({
    animations = {
        enabled = true,
    },
})

hl.curve("fluentOut", { type = "bezier", points = { { 0.1, 0.9 }, { 0.2, 1 } } })
hl.curve("fluentIn", { type = "bezier", points = { { 0.7, 0 }, { 0.84, 0 } } })

hl.animation({ leaf = "windowsIn", enabled = true, speed = 4, bezier = "fluentOut", style = "popin 90%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "fluentIn", style = "popin 90%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 4, bezier = "fluentOut" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 3, bezier = "fluentOut" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 2.5, bezier = "fluentIn" })
hl.animation({ leaf = "border", enabled = true, speed = 5, bezier = "fluentOut" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "fluentOut", style = "slide" })

hl.animation({ leaf = "layers", enabled = false })
hl.animation({ leaf = "fadeLayers", enabled = false })
