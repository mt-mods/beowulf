-- kicks a player if he joins from a blacklisted ASN (mostly vpn's)

local has_beerchat = minetest.get_modpath("beerchat")

local blacklisted_asn = {
	-- "map-attack" hacks over various ip's
	[49453] = true
}

geoip.joinplayer_callback = function(name, result)
	if result.data and result.data.geo and result.data.geo.asn then
		if blacklisted_asn[result.data.geo.asn] then
			-- blacklisted, kick player
			local msg = "Player '" .. name .. "' joined from a blacklisted ASN: '" .. result.data.geo.asn .. "'"
			minetest.log("action", "[beowulf] " .. msg)
			if has_beerchat then
					beerchat.send_on_channel("Geoip-ASN-Kick", beerchat.moderator_channel_name, msg)
			end
			minetest.after(0, function()
				minetest.kick_player(name, "you are joining from a blacklisted network that is known for troublemakers, " ..
					"if you think this is a mistake please report this on irc/discord")
			end)
		end
	end
end
