local modname = "protector_configurator"
local S = minetest.get_translator(modname)


protector_configurator = {}


function protector_configurator:get_cords(meta)
	local cords = meta:get_string("cords")
	if cords == "" then
		return nil
	end
	local cords_t = {}
	for i, cord in pairs(cords:split(" ")) do
		local pos = minetest.string_to_pos(cord)
		if pos then table.insert(cords_t, pos) end
	end
	return cords_t
end


function protector_configurator:check_owner(username, pos)
	local meta = minetest.get_meta(pos)
	if meta:get_string("owner") ~= username then
		return false
	end
	return true
end


function protector_configurator:cords2strings(cords)
	local cords_t = {}
	for i, cord in pairs(cords) do
		local cord = minetest.pos_to_string(cord)
		if cord then table.insert(cords_t, cord) end
	end
	return cords_t
end


function protector_configurator:add_cord(meta, cord)
	local cords = self:get_cords(meta)
	if not cords then
		cords = {}
	end
	for i, cord_ in pairs(cords) do
		if cord_ == cord then return end
	end
	table.insert(cords, cord)
	meta:set_string("cords", table.concat(self:cords2strings(cords), " "))
end


function protector_configurator:add_cords(meta, new_cords)
	local cords = self:get_cords(meta)
	if not cords or #cords == 0 then
		meta:set_string("cords", table.concat(self:cords2strings(new_cords), " "))
		return
	end
	local max_idx = #cords

	for i, new_cord in pairs(new_cords) do
		local f = false
		for i, cord in pairs(cords) do
			if new_cord == cord then f = true break end
		end
		if not f then table.insert(cords, new_cord) end
	end
	meta:set_string("cords", table.concat(self:cords2strings(cords), " "))
end


function protector_configurator:del_cord_by_index(meta, index)
	local cords = self:get_cords(meta)
	if not cords then return end
	if index > #cords then return end
	table.remove(cords, index)
	meta:set_string("cords", table.concat(self:cords2strings(cords), " "))
end


function protector_configurator:list2textlist(list, x, y, w, h, name)
	if x then x = tostring(x) else x = 1 end
	if y then y = tostring(y) else y = 0 end
	if w then w = tostring(w) else w = 5 end
	if h then h = tostring(h) else h = 7 end
	if name then name = tostring(name) else name = "text_list" end

	local str = string.format('textlist[%s,%s;%s,%s;%s;', x, y, w, h, name)
	for i, elem in pairs(list) do
		str = str ..  minetest.formspec_escape(tostring(elem)) .. ','
	end
	local str = str:sub(1, #str - 1) .. ";1]"
	return str
end