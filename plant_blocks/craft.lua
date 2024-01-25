minetest.register_craft({
	output = 'plant_blocks:brush',
	recipe = {
		{'basic_materials:plastic_sheet','', ''},
		{'basic_materials:steel_strip', '', ''},
		{'default:stick', '', ''},
	}
})

minetest.register_craft({
	output = 'plant_blocks:ruler',
	recipe = {
		{'default:stick','default:sword_steel', ''},
	},
	replacements = {{"default:sword_steel", "default:sword_steel"}}
})

minetest.register_craft({
	output = 'plant_blocks:scissors',
	recipe = {
		{'basic_materials:steel_strip', '', ''},
		{'basic_materials:plastic_sheet','', ''},
	}
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

minetest.register_craft({
	output = 'plant_blocks:floor',
	recipe = {
		{'basic_materials:cement_block','plant_blocks:brush', 'dye:grey'},
	},
	replacements = {{"plant_blocks:brush", "plant_blocks:brush"}}
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

minetest.register_craft({
	output = 'plant_blocks:yellow_line_floor',
	recipe = {
		{'','dye:yellow', 'plant_blocks:ruler'},
		{'plant_blocks:floor', 'plant_blocks:brush', ''},
		{'', '', ''},
	},
	replacements = {
		{"plant_blocks:brush", "plant_blocks:brush"},
		{"plant_blocks:ruler", "plant_blocks:ruler"}
	}
})

minetest.register_craft({
	output = 'plant_blocks:yellow_line_corner_floor',
	recipe = {
		{'','dye:yellow', 'plant_blocks:ruler'},
		{'plant_blocks:floor', 'plant_blocks:brush', 'plant_blocks:ruler'},
		{'', '', ''},
	},
	replacements = {
		{"plant_blocks:brush", "plant_blocks:brush"},
		{"plant_blocks:ruler", "plant_blocks:ruler"},
		{"plant_blocks:ruler", "plant_blocks:ruler"}
	}
})

minetest.register_craft({
	output = 'plant_blocks:e05',
	recipe = {
		{'dye:green','plant_blocks:ruler', 'plant_blocks:brush'},
		{'default:sign_wall_wood', '', ''},
		{'', '', ''},
	},
	replacements = {
		{"plant_blocks:brush", "plant_blocks:brush"},
		{"plant_blocks:ruler", "plant_blocks:ruler"},
	}
})

minetest.register_craft({
	output = 'plant_blocks:e06',
	recipe = {
		{'plant_blocks:e05','', ''},
	},
	replacements = {
		{"plant_blocks:brush", "plant_blocks:brush"},
		{"plant_blocks:ruler", "plant_blocks:ruler"},
	}
})

minetest.register_craft({
	output = 'plant_blocks:e07',
	recipe = {
		{'dye:green','plant_blocks:ruler', ''},
		{'default:sign_wall_wood', 'plant_blocks:brush', ''},
		{'', '', ''},
	},
	replacements = {
		{"plant_blocks:brush", "plant_blocks:brush"},
		{"plant_blocks:ruler", "plant_blocks:ruler"},
	}
})

minetest.register_craft({
	output = 'plant_blocks:e08',
	recipe = {
		{'plant_blocks:e07','', ''},
	},
	replacements = {
		{"plant_blocks:brush", "plant_blocks:brush"},
		{"plant_blocks:ruler", "plant_blocks:ruler"},
	}
})
