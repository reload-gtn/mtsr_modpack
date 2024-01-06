local S = minetest.get_translator("tech_additions")

minetest.register_node("tech_additions:iron_block", {
    description = S("TA1 Iron block"),
    tiles = { 'tech_additions_iron_block.png' },
    groups = { cracky = 3 }
})

minetest.register_craft({
    output = 'tech_additions:iron_block',
    recipe = {
        { "techage:iron_ingot", "techage:iron_ingot", "techage:iron_ingot", },
        { "techage:iron_ingot", "techage:iron_ingot", "techage:iron_ingot", },
        { "techage:iron_ingot", "techage:iron_ingot", "techage:iron_ingot", }
    }
})

minetest.register_craft({
    output = 'techage:iron_ingot 9',
    recipe = {
        { 'tech_additions:iron_block', },
    }
})

minetest.register_node("tech_additions:baborium_block", {
    description = S("Baborium block"),
    tiles = { 'tech_additions_baborium_block.png' },
    groups = { cracky = 3 }
})

minetest.register_craft({
    output = 'tech_additions:baborium_block',
    recipe = {
        { "techage:baborium_ingot", "techage:baborium_ingot", "techage:baborium_ingot", },
        { "techage:baborium_ingot", "techage:baborium_ingot", "techage:baborium_ingot", },
        { "techage:baborium_ingot", "techage:baborium_ingot", "techage:baborium_ingot", }
    }
})

minetest.register_craft({
    output = 'techage:baborium_ingot 9',
    recipe = {
        { 'tech_additions:baborium_block', },
    }
})

minetest.register_craft({
    output = 'techage:ta3_barrel_oil',
    recipe = {
        { 'multidecor:consolidated_oil', 'multidecor:consolidated_oil', 'techage:ta3_barrel_empty'},
        { 'multidecor:consolidated_oil', 'multidecor:consolidated_oil', 'multidecor:consolidated_oil'},
        { 'multidecor:consolidated_oil', 'multidecor:consolidated_oil', 'multidecor:consolidated_oil'},
    }
})

minetest.register_craft({
    output = 'techage:ta4_injector_pas',
    recipe = {
        { '', 'techage:aluminum', ''},
        { '', 'techage:ta3_injector_pas', ''},
        { '', 'techage:ta4_wlanchip', ''},
    }
})

techage.add_grinder_recipe({input="multidecor:consolidated_oil", output="techage:plastic_granules"})