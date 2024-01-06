local S = minetest.get_translator("tech_additions")

minetest.register_node("tech_additions:wolfram_ingot_block", {
    description = S("Wolfram block"),
    tiles = { 'tech_additions_wolfram_block.png' },
    groups = { cracky = 3 }
})

minetest.register_node("tech_additions:zinc_ingot_block", {
    description = S("Zinc block"),
    tiles = { 'tech_additions_zinc_block.png' },
    groups = { cracky = 3 }
})

minetest.register_craft({
    output = 'tech_additions:wolfram_ingot_block',
    recipe = {
        { "multidecor:wolfram_ingot", "multidecor:wolfram_ingot", "multidecor:wolfram_ingot", },
        { "multidecor:wolfram_ingot", "multidecor:wolfram_ingot", "multidecor:wolfram_ingot", },
        { "multidecor:wolfram_ingot", "multidecor:wolfram_ingot", "multidecor:wolfram_ingot", }
    }
})

minetest.register_craft({
    output = 'multidecor:wolfram_ingot 9',
    recipe = {
        { 'tech_additions:wolfram_ingot_block', },
    }
})

minetest.register_craft({
    output = 'tech_additions:zinc_ingot_block',
    recipe = {
        { "multidecor:zinc_ingot", "multidecor:zinc_ingot", "multidecor:zinc_ingot", },
        { "multidecor:zinc_ingot", "multidecor:zinc_ingot", "multidecor:zinc_ingot", },
        { "multidecor:zinc_ingot", "multidecor:zinc_ingot", "multidecor:zinc_ingot", }
    }
})

minetest.register_craft({
    output = 'multidecor:zinc_ingot 9',
    recipe = {
        { 'tech_additions:zinc_ingot_block', },
    }
})
