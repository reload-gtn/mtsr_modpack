minetest.register_privilege("builder", {
	description = "Privilege for builders",
	give_to_singleplayer = false
})

minetest.register_on_joinplayer(function(player)
	if minetest.check_player_privs(player, {builder=true}) then
		player:hud_set_hotbar_itemcount(tonumber(16))
    	player:hud_set_hotbar_image("")
	end
end)