local timer = 0

core.register_globalstep(function(dtime)

	timer = timer + dtime
	if timer < 1 then return end
	timer = 0

	for _, player in pairs(core.get_connected_players()) do

		local pos = player:get_pos()
		pos.y = pos.y + 0.5
		local node = core.get_node(pos)
		local ndef = core.registered_nodes[node.name]

		if ndef and ndef.walkable == true
			and ndef.damage_per_second == 0
			and ndef.groups.disable_suffocation ~= 1
			and ndef.drawtype == "normal"
			and not core.check_player_privs(player:get_player_name(), { noclip = true })
		then

			if player:get_hp() > 0 then
				player:set_hp(player:get_hp() - 4, { suffocation = true })
			end
		end
	end
end)
