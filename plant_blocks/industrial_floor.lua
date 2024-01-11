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

--plant_blocks:scissors
minetest.register_craftitem("plant_blocks:scissors", {
	description = S("Scissors"),
	inventory_image = "scissors.png"
})

minetest.register_craft({
	output = 'plant_blocks:scissors',
	recipe = {
		{'basic_materials:steel_strip', '', ''},
		{'basic_materials:plastic_sheet','', ''},
	}
})

--plant_blocks:triangular_stencil Треугольный трафарет
minetest.register_craftitem("plant_blocks:triangular_stencil", {
	description = S("Triangular_stencil"),
	inventory_image = "triangular_stencil.png"
})

minetest.register_craft({
	output = 'plant_blocks:triangular_stencil',
	recipe = {
		{'basic_materials:plastic_sheet','plant_blocks:scissors','plant_blocks:ruler'}
	},
	replacements = {
		{"plant_blocks:scissors", "plant_blocks:scissors"},
		{"plant_blocks:ruler", "plant_blocks:ruler"},
	}
})

--[[*******************************************************************]]

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
    --place_param2 = 0,
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
    --place_param2 = 0,
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
    --place_param2 = 0,
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
		{'dye:black','plant_blocks:triangular_stencil', 'dye:yellow'},
		{'', 'plant_blocks:floor', ''},
		{'plant_blocks:brush', '', ''},
	},
	replacements = {
		{"plant_blocks:brush", "plant_blocks:brush"},
		{"plant_blocks:triangular_stencil", "plant_blocks:triangular_stencil"},
	}
})

--plant_blocks:wall_sign_attention_forklift_operating Настенный знак внимание работает автопогрузчик
minetest.register_node("plant_blocks:wall_sign_attention_forklift_operating", {
	description = S("Wall sign attention to forklift operating"),
    drawtype = "mesh",
    -- Holds the texture for each "material"
    tiles = {
        "sign_attention_to_forklift_operating.png"
    },
    paramtype2 = "facedir",
    --place_param2 = 0,
    -- Path to the mesh
    mesh = "triangular_sign.obj",
	paramtype = "light",
	bounding_boxes = {{0.4375, -0.5, -0.5, 0.5, 0.5, 0.5}},
	selection_box = {
        type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.4375, 0.5, 0.5, 0.5},
		},
    },
	node_box = {
		type = "wallmounted",

		-- Ceiling
		wall_top    = {
			{-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
		},

		-- Floor
		wall_bottom = {
			{-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
		},

		-- Wall
		wall_side   = {
			{-0.5, -0.3125, -0.4375, -0.4375, 0.3125, 0.4375}
		}
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.4375, 0.5, 0.5, 0.5},
		},
	},
	is_ground_content = false,
	groups = {crumbly=3},
})

minetest.register_craft({
	output = 'plant_blocks:wall_sign_attention_forklift_operating',
	recipe = {
		{'dye:black','plant_blocks:triangular_stencil', 'dye:yellow'},
		{'plant_blocks:brush', 'basic_materials:plastic_sheet', 'plant_blocks:scissors'},
	},
	replacements = {
		{"plant_blocks:brush", "plant_blocks:brush"},
		{"plant_blocks:triangular_stencil", "plant_blocks:triangular_stencil"},
		{"plant_blocks:scissors", "plant_blocks:scissors"},
	}
})