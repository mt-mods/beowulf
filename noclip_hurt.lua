local timer = 0

local function is_solid_node(pos)
	local ndef = core.registered_nodes[core.get_node(pos).name]
	return ndef
		and ndef.walkable == true
		and ndef.groups.disable_suffocation ~= 1
		and ndef.drawtype == "normal"
end

core.register_globalstep(function(dtime)

	timer = timer + dtime
	if timer < 1 then return end
	timer = 0

	for _, player in ipairs(core.get_connected_players()) do
		local pos = player:get_pos()

		pos.y = pos.y + 0.5
		if is_solid_node(pos) then
			pos.y = pos.y + 1 -- Player's head
			if is_solid_node(pos)
				and player:get_hp() > 0
				and not core.check_player_privs(player:get_player_name(), { noclip = true }) then

				player:set_hp(player:get_hp() - 1, { suffocation = true })
			end
		end
	end
end)
