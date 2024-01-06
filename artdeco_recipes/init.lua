minetest.register_craft({
	output = 'artdeco:1a',
	recipe = {
		{'default:coal_lump', 'default:coal_lump', 'default:coal_lump'},
		{'artdeco:1e', '', ''},
	}
})

minetest.register_craft({
	output = 'artdeco:1b',
	recipe = {
		{'default:coal_lump', 'artdeco:1a'},
	}
})

minetest.register_craft({
	output = 'artdeco:1c',
	recipe = {
		{'artdeco:1a', 'default:coal_lump'},
		{'default:coal_lump', ''},
	}
})

minetest.register_craft({
	output = 'artdeco:1d',
	recipe = {
		{'default:coal_lump', 'artdeco:1e'},
	}
})

minetest.register_craft({
	output = 'artdeco:1e',
	recipe = {
		{'default:flint'},
		{'default:silver_sandstone'},
	}
})

minetest.register_craft({
	output = 'artdeco:1f',
	recipe = {
		{'artdeco:1e', 'default:coal_lump'},
		{'default:coal_lump', ''},
	},
})

minetest.register_craft({
	output = 'artdeco:1g',
	recipe = {
		{'default:coal_lump', 'artdeco:1h'},
	}
})

minetest.register_craft({
	output = 'artdeco:1h',
	recipe = {
		{'artdeco:1e', '', ''},
		{'default:coal_lump', 'default:coal_lump', 'default:coal_lump'},
	}
})

minetest.register_craft({
	output = 'artdeco:1i',
	recipe = {
		{'artdeco:1h', 'default:coal_lump'},
		{'default:coal_lump', ''},
	}
})

minetest.register_craft({
	output = 'artdeco:1j',
	recipe = {
		{'default:coal_lump', 'artdeco:1c', 'default:coal_lump'},
		{'', 'default:coal_lump', ''},
	}
})

minetest.register_craft({
	output = 'artdeco:1k',
	recipe = {
		{'default:coal_lump', 'artdeco:1e', 'default:coal_lump'},
		{'', 'default:coal_lump', ''},
	}
})

minetest.register_craft({
	output = 'artdeco:1l',
	recipe = {
		{'default:coal_lump', 'artdeco:1h', 'default:coal_lump'},
		{'', 'default:coal_lump', ''},
	}
})

--//

minetest.register_craft({
	output = 'artdeco:2a',
	recipe = {
		{'artdeco:dblarchslab'},
		{'artdeco:2d'},
	}
})

minetest.register_craft({
	output = 'artdeco:2b',
	recipe = {
		{'artdeco:2d'},
		{'default:acacia_bush_stem'},
	}
})

minetest.register_craft({
	output = 'artdeco:2c',
	recipe = {
		{'artdeco:2d', ''},
		{'default:coal_lump', 'default:coal_lump'},
	}
})

minetest.register_craft({
	output = 'artdeco:2d',
	recipe = {
		{'default:silver_sandstone', 'default:silver_sandstone'},
	}
})

--//

minetest.register_craft({
	output = 'artdeco:arch1a',
	recipe = {
		{'artdeco:dblarchslab'},
		{'artdeco:arch1b'},
	}
})

minetest.register_craft({
	output = 'artdeco:arch1b',
	recipe = {
		{'artdeco:dblarch1b', '', 'artdeco:dblarch1b'},
	}
})

minetest.register_craft({
	output = 'artdeco:arch1c',
	recipe = {
		{'artdeco:dblarch1b'},
		{'artdeco:2d'},
	}
})

minetest.register_craft({
	output = 'artdeco:arch1d',
	recipe = {
		{'artdeco:dblarch1b'},
		{'artdeco:2c'},
	}
})

minetest.register_craft({
	output = 'artdeco:arch1e',
	recipe = {
		{'artdeco:dblarch1b'},
		{'artdeco:2a'},
	}
})

minetest.register_craft({
	output = 'artdeco:arch2a',
	recipe = {
		{'artdeco:dblarch1b'},
		{'artdeco:arch1b'},
	}
})

--//

minetest.register_craft({
	output = 'artdeco:archwin1a',
	recipe = {
		{'default:glass', 'default:stick'},
		{'default:glass', 'default:coal_lump'},
	}
})

minetest.register_craft({
	output = 'artdeco:archwin1b',
	recipe = {
		{'default:glass', ''},
		{'default:glass', 'default:coal_lump'},
		{'default:glass', ''},
	}
})

minetest.register_craft({
	output = 'artdeco:archwin1c',
	recipe = {
		{'default:glass', ''},
		{'default:glass', 'default:coal_lump'},
		{'default:glass', 'default:stick'},
	}
})

minetest.register_craft({
	output = 'artdeco:archwin2a 3',
	recipe = {
		{'default:glass', 'default:stick', 'default:bronze_ingot'},
		{'default:glass', 'default:coal_lump', ''},
	}
})

minetest.register_craft({
	output = 'artdeco:archwin2b 3',
	recipe = {
		{'default:glass', '', 'default:bronze_ingot'},
		{'default:glass', 'default:coal_lump', ''},
		{'default:glass', '', ''},
	}
})

minetest.register_craft({
	output = 'artdeco:archwin2c 3',
	recipe = {
		{'default:glass', '', 'default:bronze_ingot'},
		{'default:glass', 'default:coal_lump', ''},
		{'default:glass', 'default:stick', ''},
	}
})

--//

minetest.register_craft({
	output = 'artdeco:brownwalltile',
	recipe = {
		{'default:dirt', 'default:gravel'},
	}
})

--ceiling tile
minetest.register_craft({
	output = 'artdeco:ceilingtile',
	recipe = {
		{'default:pick_stone', ''},
		{'', 'artdeco:2d'},
	},
	replacements = {{"default:pick_stone", "default:pick_stone"}}
})

--//

minetest.register_craft({
	output = 'artdeco:column1a',
	recipe = {
		{'artdeco:dblarchslab'},
		{'artdeco:column1d'},
	}
})

minetest.register_craft({
	output = 'artdeco:column1b',
	recipe = {
		{'artdeco:column1d'},
		{'default:acacia_bush_stem'},
	}
})

minetest.register_craft({
	output = 'artdeco:column1c',
	recipe = {
		{'artdeco:column1d'},
		{'default:coal_lump'},
	}
})

--//

minetest.register_craft({
	output = 'artdeco:dblarch1a',
	recipe = {
		{'artdeco:dblarchslab'},
		{'artdeco:dblarch1b'},
	}
})

minetest.register_craft({
	output = 'artdeco:dblarch1b 9',
	recipe = {
		{'artdeco:2d'},
		{'artdeco:2d'},
		{'artdeco:2d'},
	}
})

minetest.register_craft({
	output = 'artdeco:dblarchslab 3',
	recipe = {
		{'artdeco:2d', 'default:coal_lump'},
	}
})

--decoblock
minetest.register_craft({
	output = 'artdeco:decoblock1',
	recipe = {
		{'artdeco:italianmarble', 'default:pick_stone'},
	},
	replacements = {{"default:pick_stone", "default:pick_stone"}}
})

minetest.register_craft({
	output = 'artdeco:decoblock2',
	recipe = {
		{'artdeco:italianmarble', ''},
		{'', 'default:pick_stone'},
	},
	replacements = {{"default:pick_stone", "default:pick_stone"}}
})

minetest.register_craft({
	output = 'artdeco:decoblock3',
	recipe = {
		{'default:pick_stone'},
		{'artdeco:italianmarble'},
	},
	replacements = {{"default:pick_stone", "default:pick_stone"}}
})

minetest.register_craft({
	output = 'artdeco:decoblock4',
	recipe = {
		{'artdeco:italianmarble'},
		{'default:pick_stone'},
	},
	replacements = {{"default:pick_stone", "default:pick_stone"}}
})

minetest.register_craft({
	output = 'artdeco:decoblock5',
	recipe = {
		{'','artdeco:italianmarble'},
		{'default:pick_stone', ''},
	},
	replacements = {{"default:pick_stone", "default:pick_stone"}}
})

minetest.register_craft({
	output = 'artdeco:decoblock6',
	recipe = {
		{'default:pick_stone','artdeco:italianmarble'},
	},
	replacements = {{"default:pick_stone", "default:pick_stone"}}
})

--decostair
minetest.register_craft({
	output = 'artdeco:decostair1',
	recipe = {
		{'artdeco:italianmarble',''},
		{'artdeco:italianmarble','artdeco:italianmarble'},
	}
})

minetest.register_craft({
	output = 'artdeco:decostair2',
	recipe = {
		{'artdeco:decoblock1',''},
		{'artdeco:decoblock1','artdeco:decoblock1'},
	}
})

minetest.register_craft({
	output = 'artdeco:decostair3',
	recipe = {
		{'artdeco:stonewall',''},
		{'artdeco:stonewall','artdeco:stonewall'},
	}
})

--estate door
minetest.register_craft({
	output = 'artdeco:estatedoor',
	recipe = {
		{'doors:door_wood','default:glass', 'default:acacia_tree'},
	}
})

--greenwalltile
minetest.register_craft({
	output = 'artdeco:greenwalltile',
	recipe = {
		{'default:mossycobble','default:acacia_leaves'},
	}
})

--irongrating
minetest.register_craft({
	output = 'artdeco:irongrating 10',
	recipe = {
		{'default:steel_ingot', '', 'default:steel_ingot'},
		{'', 'default:steel_ingot', ''},
		{'default:steel_ingot', '', 'default:steel_ingot'},
	}
})

--italianmarble
minetest.register_craft({
	output = 'artdeco:italianmarble',
	recipe = {
		{'artdeco:2d', 'default:gravel'},
	}
})

--lightwin
minetest.register_craft({
	output = 'artdeco:lightwin1',
	recipe = {
		{'', 'default:coal_lump', ''},
		{'', 'default:glass', ''},
		{'default:coal_lump', 'default:mese_post_light', 'default:coal_lump'},
	}
})

minetest.register_craft({
	output = 'artdeco:lightwin2',
	recipe = {
		{'', 'default:glass', ''},
		{'default:coal_lump', 'default:mese_post_light', 'default:coal_lump'},
	}
})

minetest.register_craft({
	output = 'artdeco:lightwin3',
	recipe = {
		{'', 'default:glass', ''},
		{'default:coal_lump', 'default:mese_post_light', 'default:coal_lump'},
		{'', 'default:coal_lump', ''},
	}
})

--lionheart
minetest.register_craft({
	output = 'artdeco:lionheart',
	recipe = {
		{'', 'default:steel_ingot'},
		{'artdeco:italianmarble', ''},
	}
})

--stonewall
minetest.register_craft({
	output = 'artdeco:stonewall 6',
	recipe = {
		{'default:cobble', 'default:gravel'},
		{'default:cobble', 'default:gravel'},
		{'default:cobble', 'default:gravel'},
	}
})

minetest.register_craft({
	output = 'artdeco:thinstonewall 4',
	recipe = {
		{'artdeco:stonewall', 'artdeco:stonewall', 'artdeco:stonewall'},
	}
})

minetest.register_craft({
	output = 'artdeco:thinstonewallcorner 3',
	recipe = {
		{'artdeco:stonewall', 'artdeco:stonewall'},
	}
})

--tile
minetest.register_craft({
	output = 'artdeco:tile1 5',
	recipe = {
		{'artdeco:1e', '', 'artdeco:1e'},
		{'', 'artdeco:greenwalltile', ''},
		{'artdeco:1e', '', 'artdeco:1e'},
	}
})

minetest.register_craft({
	output = 'artdeco:tile2 5',
	recipe = {
		{'artdeco:greenwalltile', '', 'artdeco:greenwalltile'},
		{'', 'artdeco:1e', ''},
		{'artdeco:greenwalltile', '', 'artdeco:greenwalltile'},
	}
})



minetest.register_craft({
	output = 'artdeco:tile3 9',
	recipe = {
		{'artdeco:greenwalltile', 'artdeco:greenwalltile', 'artdeco:greenwalltile'},
		{'artdeco:greenwalltile', 'artdeco:1e', 'artdeco:greenwalltile'},
		{'artdeco:greenwalltile', 'artdeco:greenwalltile', 'artdeco:greenwalltile'},
	}
})

minetest.register_craft({
	output = 'artdeco:tile4 9',
	recipe = {
		{'artdeco:greenwalltile', 'artdeco:greenwalltile', 'artdeco:greenwalltile'},
		{'artdeco:greenwalltile', 'artdeco:1e', 'artdeco:greenwalltile'},
		{'artdeco:greenwalltile', 'default:stone', 'artdeco:greenwalltile'},
	}
})

minetest.register_craft({
	output = 'artdeco:tile5 9',
	recipe = {
		{'artdeco:greenwalltile', 'default:stone', 'artdeco:greenwalltile'},
		{'artdeco:greenwalltile', 'artdeco:1e', 'artdeco:greenwalltile'},
		{'artdeco:greenwalltile', 'default:stone', 'artdeco:greenwalltile'},
	}
})

--whitegardenstone
minetest.register_craft({
    type = "cooking",
    output = "artdeco:whitegardenstone",
    recipe = "artdeco:2d",
    cooktime = 10.0,
})

--wincross
minetest.register_craft({
	output = 'artdeco:wincross1a 14',
	recipe = {
		{'', 'artdeco:2d', ''},
		{'artdeco:2d', 'artdeco:2d', 'artdeco:2d'},
		{'artdeco:2d', 'artdeco:2d', 'artdeco:2d'}
	}
})


minetest.register_craft({
	output = 'artdeco:wincross1b 12',
	recipe = {
		{'artdeco:2d', 'artdeco:2d', 'artdeco:2d'},
		{'artdeco:2d', 'artdeco:2d', 'artdeco:2d'}
	}
})

if minetest.get_modpath("craft_ingredients") then
	--multidecor
	minetest.register_craft({
		output = 'artdeco:column1d 3',
		recipe = {
			{'artdeco:2d', 'multidecor:saw'},
			{'artdeco:2d', ''},
			{'artdeco:2d', ''},
		},
		replacements = {{"multidecor:saw", "multidecor:saw"}}
	})
else
	minetest.register_craft({
		output = 'artdeco:column1d 3',
		recipe = {
			{'artdeco:2d', 'default:pick_stone'},
			{'artdeco:2d', ''},
			{'artdeco:2d', ''},
		},
		replacements = {{"default:pick_stone", "default:pick_stone"}}
	})
end