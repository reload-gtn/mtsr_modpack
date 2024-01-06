local S = minetest.get_translator("tech_additions")

minetest.register_node("tech_additions:amphibolite_cobble", {
    description = S("Amphibolite cobble"),
    tiles = { 'tech_additions_amphibolite_cobble.png' },
    groups = { cracky = 3 }
})

minetest.register_craft({
    output = 'tech_additions:amphibolite_cobble',
    recipe = {
        { "default:cobble", "default:cobble", '', },
        { "default:cobble", "default:cobble", '', },
        { '', '', '', }
    }
})

minetest.register_craft({
    output = 'default:cobble 4',
    recipe = {
        { "tech_additions:amphibolite_cobble"}
    }
})

minetest.register_node("tech_additions:amphibolite", {
    description = S("Amphibolite"),
    tiles = { 'tech_additions_amphibolite.png' },
    groups = {crumbly = 2},
})

--techage.add_grinder_recipe({input="tech_additions:amphibolite_cobble", output="tech_additions:amphibolite"})

minetest.register_craft({
	type = "cooking",
	output = "tech_additions:amphibolite",
	recipe = "tech_additions:amphibolite_cobble",
	cooktime = 20,
})

minetest.register_node("tech_additions:amphibolite_brick", {
    description = S("Amphibolite brick"),
    tiles = { 'tech_additions_amphibolite_brick.png' },
    groups = { cracky = 3 }
})

minetest.register_craft({
    output = 'tech_additions:amphibolite_brick 4',
    recipe = {
        { "tech_additions:amphibolite", "tech_additions:amphibolite", '',},
        { "tech_additions:amphibolite", "tech_additions:amphibolite", '',},
        { '', '', '',}
    }
})

minetest.register_node("tech_additions:andesite_cobble", {
    description = S("Andesite cobble"),
    tiles = { 'tech_additions_andesite_cobble.png' },
    groups = { cracky = 3 }
})

minetest.register_craft({
    output = 'tech_additions:andesite_cobble',
    recipe = {
        { "default:cobble", "default:cobble", "default:cobble", }
    }
})

minetest.register_craft({
    output = 'default:cobble 3',
    recipe = {
        { "tech_additions:andesite_cobble"}
    }
})

minetest.register_node("tech_additions:conglomerate", {
    description = S("Conglomerate"),
    tiles = { 'tech_additions_conglomerate.png' },
	groups = {crumbly = 2},
	sounds = default.node_sound_gravel_defaults(),
})

minetest.register_craft({
    output = 'tech_additions:conglomerate',
    recipe = {
        { "default:gravel", "default:gravel", '',},
        { "default:gravel", "default:gravel", '',},
        { '', '', '', }
    }
})

minetest.register_craft({
    output = 'default:gravel 4',
    recipe = {
        { "tech_additions:conglomerate"}
    }
})

minetest.register_node("tech_additions:conglomerate_block", {
    description = S("Conglomerate block"),
    tiles = { 'tech_additions_conglomerate_block.png' },
    groups = { cracky = 3 }
})

minetest.register_craft({
    output = 'tech_additions:conglomerate_block 9',
    recipe = {
        { "tech_additions:conglomerate", "tech_additions:conglomerate", "tech_additions:conglomerate",},
        { "tech_additions:conglomerate", "tech_additions:conglomerate", "tech_additions:conglomerate",},
        { "tech_additions:conglomerate", "tech_additions:conglomerate", "tech_additions:conglomerate",}
    }
})

minetest.register_node("tech_additions:conglomerate_brick", {
    description = S("Conglomerate brick"),
    tiles = { 'tech_additions_conglomerate_brick.png' },
    groups = { cracky = 3 }
})

minetest.register_craft({
    output = 'tech_additions:conglomerate_brick 4',
    recipe = {
        { "tech_additions:conglomerate", "tech_additions:conglomerate", '',},
        { "tech_additions:conglomerate", "tech_additions:conglomerate", '',},
        { '', '', '',}
    }
})