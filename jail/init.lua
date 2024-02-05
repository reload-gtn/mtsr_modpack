local S = minetest.get_translator("jail")
jail = {}
jail.escape_boundary = 50 --радиус обхвата тюрмы
jail.display_node = { x = 675, y = 3.55, z = 5 }
local jailpos = { x = 690, y = 5, z = -7 }
local releasepos = { x = 684, y = 5, z = -7 }
local timer = 0

dofile(minetest.get_modpath("jail") .. "/nodes.lua")

minetest.register_privilege("jail", { description = S("Allows one to send/release prisoners") })

local mod_storage = minetest.get_mod_storage()
local prisoners = mod_storage:get_string("prisoners")
prisoners_list = {}

for line in prisoners:gmatch("[^\n]+") do
	table.insert(prisoners_list, line)
end

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
				shout = true,
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

minetest.register_globalstep(function(dtime)
	-- every 5 seconds
	if timer > os.time() then
		return
	end
	timer = os.time() + 5

	for i = 1, #prisoners_list do
		local object = minetest.env:get_player_by_name(prisoners_list[i])

		if object then
			local pos = object:get_pos()

			local max_pos_x = jail.display_node.x + jail.escape_boundary
			local min_pos_x = jail.display_node.x - jail.escape_boundary
			local max_pos_y = jail.display_node.y + jail.escape_boundary
			local min_pos_y = jail.display_node.y - jail.escape_boundary
			local max_pos_z = jail.display_node.z + jail.escape_boundary
			local min_pos_z = jail.display_node.z - jail.escape_boundary

			if (max_pos_x < pos.x or pos.x < min_pos_x) or max_pos_y < pos.y or pos.y < min_pos_y or max_pos_z < pos.z or pos.z < min_pos_z then
				object:set_pos(jailpos)

				minetest.set_player_privs(prisoners_list[i], {
					interact = true,
					shout = true,
				})
				minetest.chat_send_all(minetest.colorize("red", S("Escape attempt: ") .. prisoners_list[i]))
			end
		end
	end
end)
