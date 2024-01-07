local S = minetest.get_translator("plant_blocks")

--plant_blocks:brush
minetest.register_craftitem("plant_blocks:brush", {
	description = S("Brush"),
	inventory_image = "brush.png"
})

minetest.register_craft({
	output = 'plant_blocks:brush',
	recipe = {
		{'basic_materials:plastic_sheet','', ''},
		{'basic_materials:steel_strip', '', ''},
		{'default:stick', '', ''},
	}
})

--plant_blocks:ruler
minetest.register_craftitem("plant_blocks:ruler", {
	description = S("Ruler"),
	inventory_image = "ruler.png"
})

minetest.register_craft({
	output = 'plant_blocks:ruler',
	recipe = {
		{'default:stick','default:sword_steel', ''},
	},
	replacements = {{"default:sword_steel", "default:sword_steel"}}
})

--plant_blocks:industrial_floor
minetest.register_node("plant_blocks:floor", {
    description = S("Industrial floor"),
    tiles = {
    	"floor_up.png",
    	"basic_materials_cement_block.png",
    	"basic_materials_cement_block.png",
    	"basic_materials_cement_block.png",
    	"basic_materials_cement_block.png",
    	"basic_materials_cement_block.png",
   	},
    is_ground_content = false,
	groups = {cracky=3, stone=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = 'plant_blocks:floor',
	recipe = {
		{'basic_materials:cement_block','plant_blocks:brush', 'dye:grey'},
	},
	replacements = {{"plant_blocks:brush", "plant_blocks:brush"}}
})

--plant_blocks:yellow_black_floor
minetest.register_node("plant_blocks:yellow_black_floor", {
    description = S("Industrial black and yellow floor"),
    tiles = {
    	"yellow_black_up.png",
    	"basic_materials_cement_block.png",
    	"basic_materials_cement_block.png",
    	"basic_materials_cement_block.png",
    	"basic_materials_cement_block.png",
    	"basic_materials_cement_block.png",
   	},
    is_ground_content = false,
	groups = {cracky=3, stone=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = 'plant_blocks:yellow_black_floor',
	recipe = {
		{'dye:black','dye:yellow', ''},
		{'basic_materials:cement_block', 'plant_blocks:brush', ''},
		{'', '', ''},
	},
	replacements = {{"plant_blocks:brush", "plant_blocks:brush"}}
})

--plant_blocks:yellow_black_line_floor
minetest.register_node("plant_blocks:yellow_black_line_floor", {
    description = S("Industrial with black and yellow line floor"),
    paramtype2 = "facedir",
    place_param2 = 0,
    tiles = {
    	"floor_up.png^[combine:32x32:0,0=yellow_black_line_up.png",
    	"basic_materials_cement_block.png",
    	"basic_materials_cement_block.png",
    	"basic_materials_cement_block.png",
    	"basic_materials_cement_block.png",
    	"basic_materials_cement_block.png",
   	},
    is_ground_content = false,
	groups = {cracky=3, stone=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = 'plant_blocks:yellow_black_line_floor',
	recipe = {
		{'dye:black','dye:yellow', 'plant_blocks:ruler'},
		{'plant_blocks:floor', 'plant_blocks:brush', ''},
		{'', '', ''},
	},
	replacements = {
		{"plant_blocks:brush", "plant_blocks:brush"},
		{"plant_blocks:ruler", "plant_blocks:ruler"}
	}
})

--plant_blocks:yellow_black_line_corner_floor
minetest.register_node("plant_blocks:yellow_black_line_corner_floor", {
    description = S("Industrial floor with black and yellow corner line"),
    paramtype2 = "facedir",
    place_param2 = 0,
    tiles = {
    	"floor_up.png^yellow_black_line_corner_up.png",
    	"basic_materials_cement_block.png",
    	"basic_materials_cement_block.png",
    	"basic_materials_cement_block.png",
    	"basic_materials_cement_block.png",
    	"basic_materials_cement_block.png",
   	},
    is_ground_content = false,
	groups = {cracky=3, stone=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = 'plant_blocks:yellow_black_line_corner_floor',
	recipe = {
		{'dye:black','dye:yellow', 'plant_blocks:ruler'},
		{'plant_blocks:floor', 'plant_blocks:brush', 'plant_blocks:ruler'},
		{'', '', ''},
	},
	replacements = {
		{"plant_blocks:brush", "plant_blocks:brush"},
		{"plant_blocks:ruler", "plant_blocks:ruler"},
		{"plant_blocks:ruler", "plant_blocks:ruler"}
	}
})

--plant_blocks:industrial_forklift_sign_floor
minetest.register_node("plant_blocks:forklift_floor_sign", {
    description = S("Industrial forklift floor sign"),
    paramtype2 = "facedir",
    place_param2 = 0,
    tiles = {
    	"floor_up.png^forklift_sign_up.png",
    	"basic_materials_cement_block.png",
    	"basic_materials_cement_block.png",
    	"basic_materials_cement_block.png",
    	"basic_materials_cement_block.png",
    	"basic_materials_cement_block.png",
   	},
    is_ground_content = false,
	groups = {cracky=3, stone=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = 'plant_blocks:forklift_floor_sign',
	recipe = {
		{'dye:black','', 'dye:yellow'},
		{'plant_blocks:ruler', 'plant_blocks:floor', 'plant_blocks:ruler'},
		{'plant_blocks:brush', 'plant_blocks:ruler', ''},
	},
	replacements = {
		{"plant_blocks:brush", "plant_blocks:brush"},
		{"plant_blocks:ruler", "plant_blocks:ruler"},
		{"plant_blocks:ruler", "plant_blocks:ruler"},
		{"plant_blocks:ruler", "plant_blocks:ruler"}
	}
})
