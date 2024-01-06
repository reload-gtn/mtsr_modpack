local S = minetest.get_translator("jail")
local escape_boundary = 50 --радиус обхвата тюрмы 
local display_node = { x = 675, y = 3.55, z = 5 }

local x = escape_boundary
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

minetest.register_privilege("jail", { description = S("Allows one to send/release prisoners") })

local mod_storage = minetest.get_mod_storage()
local prisoners = mod_storage:get_string("prisoners")
prisoners_list = {}

for line in prisoners:gmatch("[^\n]+") do
	table.insert(prisoners_list, line)
end

jailpos = { x = 690, y = 5, z = -7 }
local releasepos = { x = 684, y = 5, z = -7 }

minetest.register_chatcommand("jail", {
	params = "<player>",
	description = S("Sends a player to Jail"),
	privs = { jail = true },
	func = function(name, param)
		for i = 1, #prisoners_list do
			if prisoners_list[i] == param then
				minetest.chat_send_player(name, S("The player is already in jail"))
				return
			end
		end
		local player = minetest.env:get_player_by_name(param)
		if (player) then
			table.insert(prisoners_list, param)
			player:setpos(jailpos)
			minetest.chat_send_player(param, minetest.colorize("red", S("You have been sent to jail")))
			minetest.chat_send_all(minetest.colorize("red",
				"" .. param .. " " .. S("has been sent to jail by") .. " " .. name))
			minetest.set_player_privs(param, {
				interact = true,
				shout = true
			})
		end
	end,
})

minetest.register_chatcommand("jail_return", {
	params = "<ID prisoners>",
	description = S("Return a prisoner to jail"),
	privs = { jail = true },
	func = function(name, param)
		local id = tonumber(param)
		local playername = prisoners_list[id]
		if (id == nil or id > #prisoners_list or id <= 0) then
			minetest.chat_send_player(name, S("Invalid ID"))
			return
		end
		local player = minetest.env:get_player_by_name(playername)
		if (player) then
			player:setpos(jailpos)
			minetest.chat_send_player(playername, minetest.colorize("red", S("You have been return to jail")))
			minetest.chat_send_all(minetest.colorize("red",
				"" .. param .. " " .. S("has been return to jail by") .. " " .. name))
		end
	end,
})

minetest.register_chatcommand("release", {
	params = "<ID prisoners>",
	description = S("Releases a player from Jail by ID"),
	privs = { jail = true },
	func = function(name, param)
		local id = tonumber(param)
		local playername = prisoners_list[id]
		if (id == nil or id > #prisoners_list or id <= 0) then
			minetest.chat_send_player(name, S("Invalid ID"))
			return
		end
		local player = minetest.env:get_player_by_name(playername)
		if (player) then
			player:setpos(releasepos)
			minetest.chat_send_player(playername, minetest.colorize("green", S("You have been released from jail")))
			minetest.chat_send_all(minetest.colorize("green",
				"" .. playername .. " " .. S("has been released from jail by") .. " " .. name))
			minetest.set_player_privs(playername, {
				interact = true,
				shout = true,
				home = true,
				spawn = true
			})
			table.remove(prisoners_list, id)
		end
	end,
})

minetest.register_chatcommand("jail_list", {
	description = S("List of prisoners"),
	privs = {
		jail = true,
	},
	func = function(name)
		minetest.chat_send_player(name, minetest.colorize("cyan", S("Prisoners:")))
		for i = 1, #prisoners_list do
			minetest.chat_send_player(name, i .. " - " .. prisoners_list[i])
		end
		return true, S("Total number of prisoners:") .." ".. #prisoners_list
	end
})

minetest.register_chatcommand("jailb_on", {
	description = S("Show border"),
	privs = {
		jail = true,
	},
	func = function(name, del_node)
		minetest.set_node(jailpos, { name = "jail:borders" })
        
		return true, 'Border display'
	end
})

minetest.register_chatcommand("jailb_off", {
	description = S("remove"),
	privs = {
		interact = true,
	},
	func = function(name, del_node)
        minetest.remove_node(jailpos) --удаление
		return true, S('The border is hidden')
	end
})

minetest.register_on_shutdown(function()
	local prisoners = table.concat(prisoners_list, "\n")
	mod_storage:set_string("prisoners", prisoners)
end)

local timer = 0

minetest.register_globalstep(function(dtime)
	-- every 5 seconds
	if timer > os.time() then
		return
	end
	
	timer = os.time() + 10
	
	for i = 1, #prisoners_list do
		local object = minetest.env:get_player_by_name(prisoners_list[i])
		if not object then
			return 
		end
		
		local pos = object:get_pos()
		local max_pos_x = display_node.x + escape_boundary
		local min_pos_x = display_node.x - escape_boundary
		local max_pos_y = display_node.y + escape_boundary
		local min_pos_y = display_node.y - escape_boundary
		local max_pos_z = display_node.z + escape_boundary
		local min_pos_z = display_node.z - escape_boundary
		
		if (max_pos_x < pos.x or pos.x < min_pos_x) or max_pos_y < pos.y or pos.y < min_pos_y or max_pos_z < pos.z or pos.z < min_pos_z then
			object:set_pos(jailpos)
			minetest.chat_send_all(minetest.colorize("red", S("Escape attempt: ") .. prisoners_list[i]))
		end
	end
end)
