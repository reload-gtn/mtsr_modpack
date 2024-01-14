minetest.register_privilege("builder", {
	description = "Privilege for builders",
	give_to_singleplayer = false
})

local VERSION = "0.1.5a"
local MODES = {legacy = "legacy", world = "world", session = "session"} -- this redundancy simplifies later checks
local DEFAULT = {mode = MODES.world, slots = {legacy = 16, world = 10, session = 12}}
local MOD_STORAGE = {}
if not core.get_mod_storage then
  -- MT < 0.4.16
  MOD_STORAGE.present = false
  MOD_STORAGE.settings = false
else
  -- MT 0.4.16+
  MOD_STORAGE.present = true
  MOD_STORAGE.settings = core.get_mod_storage()
end


local stringified_table_keys = function(what, sep)
  -- what: table
  -- sep: keys separator (a string)
  local rc = ""
  for k, v in pairs(what) do
    rc = rc .. k .. sep
  end
  return string.sub(rc, 1, -#sep - 1)
end

local new_masked_array = function(mask, max)
  local rc = {}
  for i = 1, max do
    table.insert(rc, string.format(mask, i))
  end
  return rc
end

local read_mode = function(key, default_value)
  if not core.is_singleplayer() then
    return MODES.session
  end
  local value = core.settings:get(key)
  if type(value) ~= "string" or #value == 0 then
    return default_value
  end
  value = string.lower(value)
  if not MODES[value] then
    value = default_value
  end
  return value
end

local get_mode = function(storage, key, default_value)
  if not core.is_singleplayer() then
    return MODES.session
  end
  local value = read_mode(key, default_value)
  local wrong = false
  if value == MODES.world then
    if not storage.present then
      value = MODES.legacy
      wrong = true
    end
  end
  if wrong then
     core.settings:set(key, value)
     core.log("error",
              "[MOD] hotbar v" .. VERSION ..
              " automatically changed and saved the mode. " ..
              "The mode has now been set to " ..
              string.upper(value) .. ".")
  end
  return value
end

local get_and_set_initial_slots = function(storage, mode_value, key, default_value)
  local current
  if not core.is_singleplayer() then
    mode_value = MODES.session
    default_value = DEFAULT.slots[mode_value]
  end

  if mode_value == MODES.legacy then
    local result = tonumber(core.settings:get(key))
    current = result or default_value  -- The first time
    if not result then
      -- first time
      core.settings:set(key, current)
    else
      current = math.floor(result)
      if current ~= result then
        -- result is a float
        core.settings:set(key, current)
      end
    end

  elseif mode_value == MODES.world then
    local result = core.deserialize(storage.settings:get_string(key))
    if type(result) == "number" then
      current = math.floor(result)
      if current ~= result then
        -- result is a float
        storage.settings:set_string(key, core.serialize(current))
      end
    else
      current = default_value -- The first time
      storage.settings:set_string(key, core.serialize(current))
    end

  elseif mode_value == MODES.session then
      current = default_value -- Session initial value

  else
    current = default_value -- Unplanned case
    core.log("error",
             "[MOD] hotbar v" .. VERSION ..
             ": the specified mode - " .. string.upper(mode_value) ..
             " - is unmanaged and has been overridden and set to " ..
             string.upper(default_value) .. ".")
  end

  return current
end

local adjust_hotbar = function(name, slots, selected_image, bg_image_getter)
  local player = core.get_player_by_name(name)
    player:hud_set_hotbar_itemcount(slots)
    player:hud_set_hotbar_selected_image(selected_image)
    player:hud_set_hotbar_image(bg_image_getter(slots))
    player:hud_set_flags({hotbar = true, wielditem = true})
end

local hb = {}

hb.adjust = adjust_hotbar

hb.mode = { key = "hotbar_mode" }
hb.slots = { key = "hotbar_slots", min = 0, max = 23 }
hb.image = { selected = "hotbar_selected_slot.png", bg = {} }

hb.mode.current = get_mode(MOD_STORAGE, hb.mode.key, DEFAULT.mode)
hb.slots.current = get_and_set_initial_slots(MOD_STORAGE, hb.mode.current, hb.slots.key, DEFAULT.slots[hb.mode.current])
hb.image.bg.array = new_masked_array("hotbar_slots_bg_%02i.png", hb.slots.max)

hb.image.bg.get = function(slots)
  return hb.image.bg.array[tonumber(slots)]
end

hb.slots.set = function(name, slots)
  local mask = {err = "[%s] Wrong slots number specified: the %s accepted value is %i.",
                set = "[%s] Hotbar slots number set to %i."}
  local display_name = name
  if minetest.is_singleplayer() then
    display_name = '_'
  end
  
  slots = math.floor(slots) -- to avoid fractions
  
  hb.adjust(name, slots, hb.image.selected, hb.image.bg.get)

  if hb.mode.current == MODES.legacy then
    core.settings:set(hb.slots.key, slots)
  elseif hb.mode.current == MODES.world then
    MOD_STORAGE.settings:set_string(hb.slots.key, core.serialize(slots))
  elseif hb.mode.current == MODES.session then
    if core.is_singleplayer() then
      -- This is an ephemeral / transient storage that is to survive while in a map
      -- and trying different hotbar modes.
      -- As a commodity, singleplayer can override the default value to get it back
      -- if he/she switched back from another mode during the same session.
      -- This has not to happen on a server to avoid that other players
      -- overrided it or that their default / current value might be overridden by
      -- others.
      DEFAULT.slots[hb.mode.current] = slots
    end
  else
    return
  end
  if hb.mode.current ~= MODES.session then
    hb.slots.current = slots
  end
end

minetest.register_on_joinplayer(function(player)
	if minetest.check_player_privs(player, {builder=true}) then
		--player:hud_set_hotbar_itemcount(tonumber(16))
    	--player:hud_set_hotbar_image("")
    	hb.adjust(player:get_player_name(), 16, hb.image.selected, hb.image.bg.get)
	end
end)