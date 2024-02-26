local modname = "protector_configurator"
local S = minetest.get_translator(modname)

local context = {}


local writer_formspec = function(itemstack, player)
	if not player then
		return
	end
	local player = player:get_player_name()
	if not player then
		return
	end

	local meta = itemstack:get_meta()

	local cords = protector_configurator:get_cords(meta)

	-- if coordinates are not set, we will display information about this instead of coordinates
	local textlist = ""
	if not cords then
		textlist = protector_configurator:list2textlist({S("no coordinates have been set")})
	else
		textlist = protector_configurator:list2textlist(protector_configurator:cords2strings(cords))
	end

	local formspec = 'size[8,8]'
		.. textlist
		.. "button[1,7;2,1;delete;" .. S("delete") .. "]"
		.. "button[3,7;3,1;clear;" .. S("clear all") .. "]"
		.. "button_exit[6,7;2,1;exit;" .. S("exit") .. "]"

	minetest.show_formspec(player, modname .. ":writer_formspec", formspec)
end


local function use_with_protecotr(itemstack, username, pos)
	local meta = itemstack:get_meta()
	protector_configurator:add_cord(meta, pos)

	minetest.chat_send_player(username, S("added coordinates:") .. " "
		.. minetest.pos_to_string(pos))

	return itemstack
end


local function use_with_terminal(itemstack, username, pos)
	local terminal_meta = minetest.get_meta(pos)
	local writer_meta = itemstack:get_meta()

	local writer_cords = protector_configurator:get_cords(writer_meta)
	if not writer_cords then return end

	protector_configurator:add_cords(terminal_meta, writer_cords)

	minetest.chat_send_player(username, S("coordinates added to terminal") )

	terminal_meta:set_string("formspec", protector_configurator:terminal_formspec(terminal_meta))
	return itemstack
end


local function on_use_writer(itemstack, user, pointed_thing)
	if not user or pointed_thing.type ~= "node" then
		return
	end
	local username = user:get_player_name()
	if not username then
		return
	end

	local pos = pointed_thing.under
	local nodename = minetest.get_node(pos).name

	if nodename == "protector:protect" or nodename == "protector:protect2" then
		if protector_configurator:check_owner(username, pos) then -- add protector cords
			return use_with_protecotr(itemstack, username, pos)
		else -- cant add protector
			minetest.chat_send_player(username, S("you can't add this protector!"))
		end
	elseif nodename == modname .. ":terminal" then
		if protector_configurator:check_owner(username, pos) then -- add cords to terminal
			return use_with_terminal(itemstack, username, pos)
		else -- cant add cords to terminal
			minetest.chat_send_player(username, S("you do not own this terminal!"))
		end
	end
end


local function copy_to_writer(pos, itemstack)
	local terminal_meta = minetest.get_meta(pos)
	local writer_meta = itemstack:get_meta()

	writer_meta:set_string("cords", terminal_meta:get_string("cords"))
	return itemstack
end


local function on_place(itemstack, placer, pointed_thing)
	if not placer then return end
	local name = placer:get_player_name()

	if pointed_thing.type == "node" then
		local node = minetest.get_node(pointed_thing.under).name
		print("node")
		print(node)
		if node ~= modname .. ":terminal" then
			writer_formspec(itemstack, placer)
			return
		end
		if protector_configurator:check_owner(name, pointed_thing.under) then
			minetest.chat_send_player(name, S("coordinates copied to writer"))
			return copy_to_writer(pointed_thing.under, itemstack)
		else
			minetest.chat_send_player(name, S("you do not own this terminal!"))
		end
	end
end


minetest.register_craftitem(modname .. ":writer", {
	
	description = S("protect writer") .. "\n"
		.. S("LMB on the protector block to add coordinates to the protect writer’s list") .. "\n"
		.. S("or") .. " " .. S("LMB on the terminal to insert coordinates from the protect writer into the terminal") .. "\n"
		.. S("and") .. " " .. S("shift + RMB to copy coordinates from the terminal to protect writer"),

	stack_max = 1,

	inventory_image = modname .. "_writer.png",

	on_place = on_place,

	on_secondary_use = writer_formspec,

	on_use = on_use_writer
})

-----for formspec-----

local function clear_writer(player, item)
	if not player then return end
	local meta = item:get_meta()
	meta:set_string("cords", "")
	player:set_wielded_item(item)
end

local function textlist_work(player, field)
	if not player then return end
	local t = field:split(":")
	if t[1] ~= "CHG" then return end
	context[player:get_player_name()] = tonumber(t[2])
end

local function delete(player, item)
	if not player or not item then return end
	local name = player:get_player_name()

	local idx = context[name]
	if not idx then idx = 1 end

	local meta = item:get_meta()
	protector_configurator:del_cord_by_index(meta, idx)

	player:set_wielded_item(item)
	context[name] = nil
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "protector_configurator:writer_formspec" then return end
	local item = player:get_wielded_item()
	if not item then return end
	if item:get_name() ~= modname .. ":writer" then return end

	if fields.clear then clear_writer(player, item)
	elseif fields.text_list then textlist_work(player, fields.text_list)
	elseif fields.delete then delete(player, item) end

	if not fields.exit then writer_formspec(item, player) end
end)

minetest.register_craft({
	output = modname .. ":writer",

	recipe = {
		{"default:mese_crystal"},
		{"default:steel_ingot"},
		{"default:stick"}
	}
})