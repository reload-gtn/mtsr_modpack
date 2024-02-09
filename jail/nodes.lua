---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by vinamin.
--- DateTime: 05.02.2024 12:12
---
local x = jail.escape_boundary

minetest.register_node("jail:borders", {
    tiles = {"jail_display.png"},
    use_texture_alpha = "clip",
    walkable = false,
    drawtype = "nodebox",
    node_box = {
        type = "fixed",
        fixed = {
            -- sides
            {-(x+.55), -(x+.55), -(x+.55), -(x+.45), (x+.55), (x+.55)},
            {-(x+.55), -(x+.55), (x+.45), (x+.55), (x+.55), (x+.55)},
            {(x+.45), -(x+.55), -(x+.55), (x+.55), (x+.55), (x+.55)},
            {-(x+.55), -(x+.55), -(x+.55), (x+.55), (x+.55), -(x+.45)},
            -- top
            {-(x+.55), (x+.45), -(x+.55), (x+.55), (x+.55), (x+.55)},
            -- bottom
            {-(x+.55), -(x+.55), -(x+.55), (x+.55), -(x+.45), (x+.55)},
            -- middle (surround protector)
            {-.55,-.55,-.55, .55,.55,.55}
        }
    },
    selection_box = {
        type = "regular",
    },
    paramtype = "light",
    groups = {dig_immediate = 3, not_in_creative_inventory = 1},
    drop = ""
})