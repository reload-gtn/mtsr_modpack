local S = minetest.get_translator("tech_additions")

local placeairblock = function ()
	return function(itemstack, user, pointed_thing)
		local pos = user:getpos()
		local dir = user:get_look_dir()
		local distancefromplayer = 3
		local new_pos = {
			x = pos.x + (dir.x * distancefromplayer),
			y = pos.y + 1 + (dir.y * distancefromplayer),
			z = pos.z + (dir.z * distancefromplayer),
		}
		local getPos = minetest.get_node(new_pos)
		if getPos.name == "air" or
				getPos.name == "default:water_source" or
				getPos.name == "default:water_flowing" or
				getPos.name == "default:river_water_source" or
				getPos.name == "default:river_water_flowing" then
			minetest.set_node(new_pos, {name="tech_additions:air_block"})
		end
	end
end

minetest.register_node("tech_additions:air_block", {
    description = S("Air Block"),
    tiles = {"tech_additions_air_block.png"},
      groups = {snappy=3, fall_damage_add_percent = -99, bouncy=70},
      light_source = 30,
      paramtype = "light",
      sunlight_propagates = true,
      on_secondary_use = placeairblock(),
  })

