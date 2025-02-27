-- taken from https://github.com/S-S-X/dftest/blob/master/init.lua
local has_beerchat = minetest.get_modpath("beerchat")
local mp = minetest.get_modpath("beowulf")

local client_hashes = {}

-- Read hashes from generated files
for _, filename in ipairs(minetest.get_dir_list(mp .. "/hashes")) do
	local file = io.open(mp .. "/hashes/" .. filename)
	for line in file:lines() do
		client_hashes[#client_hashes + 1] = line:sub(line:find("^([^ ]*)"))
	end
	file:close()
end

minetest.log("action", "[beowulf] Loaded " .. #client_hashes .. " cheat client hashes")

local function check_version_string(s)
	for _, v in ipairs(client_hashes) do
		if s:find(v) then
			return v
		end
	end
end

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	local info = minetest.get_player_information(name)
	local version = info.version_string

	if not version then
		-- version not available
		return
	end

	local client_version = check_version_string(version)
	if client_version then
		local msg = "Unsupported client detected: " .. client_version .. " player: " .. name
		minetest.log("action", "[beowulf] " .. msg)
		if has_beerchat then
			beerchat.send_on_channel("DF-Detect", beerchat.moderator_channel_name, msg)
		end

		if minetest.settings:get_bool("beowulf.dfdetect.enable_kick", false) then
			local kick_message = minetest.settings:get("beowulf.dfdetect.kick_message")
				or "Unsupported client, get official client from www.luanti.org"
			minetest.kick_player(name, kick_message)
		end
	end

end)
