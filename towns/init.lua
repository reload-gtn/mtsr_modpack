local S = minetest.get_translator("towns")

local towns_list = {}
-- static spawn position

local central_spawn = { x = 206.7,y = 6,z = -84.2 }
local city_pos = { x = -12003, y = 22, z = -7498 }
table.insert(towns_list, S("The city built by the player H743")..S(" | command - ").."/city")

minetest.register_chatcommand("city", {
	description = S("Go to the city built by the player H743"),
	privs = { home = true },
	func = function(name)
		local player = minetest.get_player_by_name(name)
		if (player) then
			player:setpos(city_pos)
			minetest.chat_send_player(name,minetest.colorize("cyan", S("Welcome to the City!")))
		end
	end,
})

minetest.register_chatcommand("list_towns", {
	description = S("List of server towns"),
	privs = {
		home = true,
	},
	func = function(name)
		minetest.chat_send_player(name, minetest.colorize("cyan", S("Towns:")))
		for i = 1, #towns_list do
			minetest.chat_send_player(name, i .. " - " .. towns_list[i])
		end
		return true, S("Total number of towns:") .." ".. #towns_list
	end
})

minetest.register_chatcommand("spawn", {
	description = S("Go to central Spawn"),
	privs = {home = true},
	func = function(name)

		local player = minetest.get_player_by_name(name)

		if player~=nil then 
			player:set_pos(central_spawn)
			minetest.chat_send_player(name,minetest.colorize("cyan", S("Welcome to central Spawn!")))
		end
	end
})