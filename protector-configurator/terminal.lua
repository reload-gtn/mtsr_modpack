modname = "protector_configurator"
local S = minetest.get_translator(modname)

local context_cords = {}
local context_players = {}


function protector_configurator:terminal_formspec(meta)

	local cords = protector_configurator:get_cords(meta)
	if cords then
		cords = protector_configurator:cords2strings(cords)
	else
		cords = {S("no coordinates have been set")}
	end

	local players = meta:get_string("players")
	if players ~= "" then
		players = players:split(" ")
	else
		players = {S("no players have been set")}
	end

	local cordslist = protector_configurator:list2textlist(cords, 11, 0, 5, 7, "cords")

	local playerslist = protector_configurator:list2textlist(players, 0, 0, 5, 7, "players")

	local formspec = "size[16,8]"
		.. cordslist
		.. "button[11,7;2,1;delete_cord;" .. S("delete") .. "]"
		.. "button[13,7;3,1;clear_cords;" .. S("clear all") .. "]"
		.. playerslist
		.. "button[0,7;2,1;delete_player;" .. S("delete") .. "]"
		.. "button[2,7;3,1;clear_players;" .. S("clear all") .. "]"
		.. "field[5.5,0.5;3,1;input_name;add player(s):;]"
		.. "field_close_on_enter[input_name;false]"
		.. "button[8.5,0.2;2,1;add;" .. S("add") .. "]"
		.. "button[6,3;4.5,1;set_members;" .. S("set members") .."(=)]"
		.. "button[6,4;4.5,1;add_members;" .. S("add members") .."(+)]"
		.. "field_enter_after_edit[input_name;true]"

	return formspec
end


local function check_can_configure(pos, owner)
	local nodename = minetest.get_node(pos).name
	if nodename == "ignore" then return "ignore" end
	if nodename ~= "protector:protect" and nodename ~= "protector:protect2" then return "cant" end

	local protect_owner = minetest.get_meta(pos):get_string("owner")

	if protect_owner ~= owner then return "cant" end
	return "can"
end


local function update_cords(meta, cords, to_del)
	for i, del_cord in pairs(to_del) do
		for j, cord in pairs(cords) do
			if cord == del_cord then table.remove(cords, j) break end
		end
	end
	meta:set_string("cords", table.concat(protector_configurator:cords2strings(cords), " "))
end


local function xor_add(list1, list2)
	for i, elem2 in pairs(list2) do
		local f = false
		for j, elem1 in pairs(list1) do
			if elem1 == elem2 then f = true break end
		end
		if not f then table.insert(list1, elem2) end
	end
	return list1
end


local function set_members(meta, mode)
	local mode = mode or "set"
	local players = meta:get_string("players")
	local cords = protector_configurator:get_cords(meta)
	if not cords then return end

	local owner = meta:get_string("owner")
	local to_del = {}

	for i, cord in pairs(cords) do
		local result = check_can_configure(cord, owner)
		
		if result == "cant" then -- remove coordinates from the list if the block is not available to this player or is deleted
			table.insert(to_del, cord)
		elseif result == "can" then

			local protector_meta = minetest.get_meta(cord)

			if mode == "set" then -- if set members
				protector_meta:set_string("members", players)
			elseif mode == "add" then -- if you add members to those already added earlier
				local members = protector_meta:get_string("members")
				if members == "" then members = players
				else members = table.concat(xor_add(members:split(" "), players:split(" ")), " ") end
				protector_meta:set_string("members", members)
			end

		end
	end

	update_cords(meta, cords, to_del)
end


local function add_player(meta, name)
	local players = meta:get_string("players")

	if players == "" then
		players = {}
	else
		players = players:split(" ")
	end

	for i, name in pairs(name:split(" ")) do
		local f = false
		for i, player in pairs(players) do
			if player == name then f = true break end
		end
		if not f then table.insert(players, minetest.formspec_escape(name)) end
	end
	meta:set_string("players", table.concat(players, " "))
end

----for formspec----
local function context_work(name, field, context)
	local t = field:split(":")
	if t[1] ~= "CHG" then return end
	context[name] = tonumber(t[2])
end


local function delete_cord(name, meta)
	local idx = context_cords[name]
	if not idx then idx = 1 end

	protector_configurator:del_cord_by_index(meta, idx)

	context_cords[name] = nil
end

local function delete_player(name, meta)
	local idx = context_players[name]
	if not idx then idx = 1 end

	local players = meta:get_string("players")
	if players == "" then
		return
	else
		players = players:split(" ")
	end
	if idx > #players then return end

	table.remove(players, idx)

	meta:set_string("players", table.concat(players, " "))
	context_players[name] = nil
end


local function on_receive_fields(pos, formname, fields, player)
	if not player then return end
	if not protector_configurator:check_owner(player:get_player_name(), pos) then return end

	local name = player:get_player_name()
	local meta = minetest.get_meta(pos)

	--input_name should be processed later by set_members and add_members
	if fields.cords then context_work(name, fields.cords, context_cords)
	elseif fields.players then context_work(name, fields.players, context_players)
	elseif fields.delete_cord then delete_cord(name, meta)
	elseif fields.delete_player then delete_player(name, meta)
	elseif fields.clear_cords then meta:set_string("cords", "")
	elseif fields.clear_players then meta:set_string("players", "")
	elseif fields.set_members then set_members(meta)
	elseif fields.add_members then set_members(meta, "add")
	elseif fields.input_name then add_player(meta, fields.input_name) end

	meta:set_string("formspec", protector_configurator:terminal_formspec(meta))
end


minetest.register_node(modname .. ":terminal", {
	description = S("protector terminal"),

	stack_max = 1,

	drawtype = "nodebox",

	groups = {cracky=3, stone=1},

	paramtype2 = "facedir",

	tiles = {
		"protector_configurator_terminal_top.png",
		"protector_configurator_terminal_down.png",
		"protector_configurator_terminal_right.png",
		"protector_configurator_terminal_left.png",
		"protector_configurator_terminal_back.png",
		"protector_configurator_terminal_front.png"
	},

	node_box = {
		type = "fixed",
		fixed = {-0.375, -0.5, 0.5, 0.375, 0.375, 0.25}
		--12 / 14 / 2 = 0.375,
		--4 / 16 = 0.25,
	},

	after_place_node = function(pos, placer, itemstack, pointed_thing)
		local meta = minetest.get_meta(pos)
		local item_meta = itemstack:get_meta()
		meta:set_string("owner", placer:get_player_name())

		meta:set_string("cords", item_meta:get_string("cords"))
		meta:set_string("players", item_meta:get_string("players"))

		meta:set_string("formspec", protector_configurator:terminal_formspec(meta))
	end,

	preserve_metadata = function(pos, oldnode, oldmeta, drops)
		if #drops < 1 then return end

		local item_meta = drops[1]:get_meta()

		if oldmeta.cords then item_meta:set_string("cords", oldmeta.cords) end
		if oldmeta.players then item_meta:set_string("players", oldmeta.players) end
	end,

	on_receive_fields = on_receive_fields
})

minetest.register_craft({
	output = modname .. ":terminal",

	recipe = {
		{"default:steelblock", "", "default:steelblock"},
		{"default:mese_crystal", "default:steel_ingot", "default:mese_crystal"},
		{"default:steelblock", "default:gold_ingot", "default:steelblock"}
	}
})

