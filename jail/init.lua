local S = minetest.get_translator("jail")
jail = {}
jail.escape_boundary = 50 --радиус обхвата тюрмы
jail.display_node = { x = 675, y = 3.55, z = 5 }
jail.forced_labor = {y = -14848} --Начало глубины принудительных работ
local jailpos = { x = 690, y = 5, z = -7 }
local releasepos = { x = 684, y = 5, z = -7 }
local timer = 0
local lower_prison_limit = -5

dofile(minetest.get_modpath("jail") .. "/nodes.lua")

minetest.register_privilege("jail", { description = S("Allows one to send/release prisoners") })

local mod_storage = minetest.get_mod_storage()
local prisoners = mod_storage:get_string("prisoners")
prisoners_list = {}

for line in prisoners:gmatch("[^\n]+") do
	table.insert(prisoners_list, line)
end

jail.set_permissions_for_the_jail = function (player)
	minetest.set_player_privs(player, {
		interact = true,
		shout = true,
	})
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
			jail.set_permissions_for_the_jail(param)
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

jail.private_messages_with_privilege = function(list_privs, msg)
	local player_name = 'player_name'

	for _, player in ipairs(minetest.get_connected_players()) do
		player_name = player:get_player_name()

		boolean = minetest.check_player_privs(player:get_player_name(), list_privs)
		if boolean then
			minetest.chat_send_player(player_name, msg)
		end
	end
end

minetest.register_globalstep(function(dtime)
	local forced_labor = jail.forced_labor.y + 1000
	local max_pos_x = jailpos.x + jail.escape_boundary
	local min_pos_x = jailpos.x - jail.escape_boundary
	local max_pos_y = jailpos.x + jail.escape_boundary
	local max_pos_z = jailpos.z + jail.escape_boundary
	local min_pos_z = jailpos.z - jail.escape_boundary
	local msg = ''

	-- every 5 seconds
	if timer > os.time() then
		return
	end
	timer = os.time() + 5

	for i = 1, #prisoners_list do
		local object = minetest.env:get_player_by_name(prisoners_list[i])

		if object then
			local pos = object:get_pos()

			if (max_pos_x < pos.x or pos.x < min_pos_x or max_pos_z < pos.z or pos.z < min_pos_z or pos.y > max_pos_y)
					and pos.y > lower_prison_limit then
				object:set_pos(jailpos)
				msg = minetest.colorize("red", S("Escape attempt: ") .. prisoners_list[i])
				jail.private_messages_with_privilege({ban = true}, msg)
				minetest.chat_send_player(prisoners_list[i], msg)
				jail.set_permissions_for_the_jail(prisoners_list[i])
			end

			--Проверка если игрок копает в низ по кординатам тюрьмы
			if pos.y < lower_prison_limit and pos.y > forced_labor then
				object:set_pos(jailpos)
				msg = minetest.colorize("red", prisoners_list[i] .. S(": He dug under the prison"))
				jail.private_messages_with_privilege({ban = true}, msg)
				minetest.chat_send_player(prisoners_list[i], msg)
				jail.set_permissions_for_the_jail(prisoners_list[i])
			end

			--Условие если игрок находится взаданом параметре jail.forced_labor.y под землей
			if pos.y > jail.forced_labor.y and pos.y < -10 then
				object:set_pos(jailpos)
				minetest.chat_send_player(prisoners_list[i], minetest.colorize("red", S("You are prohibited from leaving this area")))
				jail.set_permissions_for_the_jail(prisoners_list[i])
			end
		end
	end
end)
