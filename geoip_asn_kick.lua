-- kicks a player if he joins from a blacklisted ASN (mostly vpn's)

local has_beerchat = minetest.get_modpath("beerchat")

local ban_message = "you are joining from a blacklisted network that is known for "
	.. "troublemakers, if you think this is a mistake please report this on irc/discord"

local blacklisted_asn = {
	-- "map-attack" hacks over various ip's
	[49453] = true
}

assert(type(geoip.register_on_joinplayer) == "function", "geoip-mod is out of date ('register_on_joinplayer' mmissing)")
geoip.register_on_joinplayer(function(name, result)
	if result.asn and blacklisted_asn[result.asn] then
		-- blacklisted, kick player
		local msg = "Player '" .. name .. "' joined from a blacklisted ASN: '" .. result.asn .. "'"
		minetest.log("action", "[beowulf] " .. msg)
		if has_beerchat then
			beerchat.send_on_channel("Geoip-ASN-Kick", beerchat.moderator_channel_name, msg)
		end
		if minetest.settings:get_bool("beowulf.geoip_asn_kick.enable", false) then
			minetest.after(0, function()
				minetest.kick_player(name, ban_message)
			end)
		end
	end
end)

geoip.register_on_prejoinplayer(function(name, result)
	if result.asn and blacklisted_asn[result.asn] then
		-- blacklisted, kick player
		local msg = "Player '" .. name .. "' prejoin from a blacklisted ASN: '" .. result.asn .. "'"
		minetest.log("action", "[beowulf] " .. msg)
		if has_beerchat then
			beerchat.send_on_channel("Geoip-ASN-Kick", beerchat.moderator_channel_name, msg)
		end
		if minetest.settings:get_bool("beowulf.geoip_asn_kick.enable", false) then
			return ban_message
		end
	end
end)
