-- Ban new player account creation from selected addresses

if not minetest.settings:get_bool("beowulf.create_account_ban.enable", true) then
	-- Module disabled by server configuration, bail out
	return
end

local CHAT_NAME = "*Beowulf*"
local MSG_BLOCKED = "Contact us on Discord or IRC if this seems wrong: New accounts are blocked from your address."
local LOG_BLOCKED = "Blocked new account %s from %s %s"

local has_beerchat = minetest.get_modpath("beerchat")

local storage = minetest.get_mod_storage()

local blacklist_ip
local blacklist_asn
local active
local logging

local inform_admin = has_beerchat and function(msg)
	minetest.log("action", "[beowulf] " .. msg)
	beerchat.on_channel_message(beerchat.moderator_channel_name, CHAT_NAME, msg)
	beerchat.send_on_channel(CHAT_NAME, beerchat.moderator_channel_name, msg)
end or function(msg)
	minetest.log("action", "[beowulf] " .. msg)
end

local jail_player = has_beerchat and beerchat.jail and function(jailer, target)
	beerchat.jail.chat_jail(jailer, target)
end or function() end

local function cleanup()
	local dirty = false
	local now = os.time()
	for key, options in pairs(blacklist_ip) do
		if options.expire and options.expire >= now then
			blacklist_ip[key] = nil
			dirty = true
		end
	end
	for key, options in pairs(blacklist_asn) do
		if options.expire and options.expire >= now then
			blacklist_asn[key] = nil
			dirty = true
		end
	end
	return dirty
end

local function read_storage()
	blacklist_ip = minetest.deserialize(storage:get("create_account_ban.blacklist_ip")) or {}
	blacklist_asn = minetest.deserialize(storage:get("create_account_ban.blacklist_asn")) or {}
	active = storage:get("create_account_ban.active") ~= nil
	logging = storage:get_int("create_account_ban.logging")
end

local function write_storage()
	storage:set_string("create_account_ban.blacklist_ip", blacklist_ip and minetest.serialize(blacklist_ip) or "")
	storage:set_string("create_account_ban.blacklist_asn", blacklist_asn and minetest.serialize(blacklist_asn) or "")
	storage:set_string("create_account_ban.active", active and "1" or "")
	storage:set_int("create_account_ban.logging", logging)
end

local function match_values(a, b, options)
	if type(options) == "table" and options.pattern then
		return a:find(b) ~= nil
	end
	return a == b
end

minetest.register_on_prejoinplayer(function(name, ip)
	if active and blacklist_ip and not minetest.get_auth_handler().get_auth(name) then
		for ip_pattern, options in pairs(blacklist_ip) do
			if match_values(ip, ip_pattern, options) then
				-- Account creation blocked by blacklisted IP address
				inform_admin(LOG_BLOCKED:format(name, "IP", ip_pattern))
				return MSG_BLOCKED
			end
		end
	end
end)

local function kick_and_delete_player_account(name)
	minetest.kick_player(name, MSG_BLOCKED)
	local auth_handler = minetest.get_auth_handler()
	if auth_handler.get_auth(name) then
		minetest.log("action", "[beowulf] Removing player account: "..name)
		auth_handler.delete_auth(name)
	else
		-- Should not happen, barrier is most probably leaking for some reason if this ever gets logged
		minetest.log("error", "[beowulf] Player account should exist but not found: "..name)
	end
end

if minetest.get_modpath("geoip") then

	-- Register prejoin handler for more efficient blocking after first failure from blocked AS
	geoip.register_on_prejoinplayer(function(name, result, last_login)
		if active and blacklist_asn and last_login == nil and result.asn and blacklist_asn[result.asn] then
			-- Account creation blocked by blacklisted AS number
			inform_admin(LOG_BLOCKED:format(name, "ASN", result.asn))
			-- Disconnect player
			return MSG_BLOCKED
		end
	end)

	-- Register join handler to prevent creating new accounts from blocked AS
	geoip.register_on_joinplayer(function(name, result, last_login)
		if active and blacklist_asn and last_login == nil and result.asn and blacklist_asn[result.asn] then
			-- Account creation blocked by blacklisted AS number
			inform_admin(LOG_BLOCKED:format(name, "ASN", result.asn))
			-- Disconnect and remove new player account
			minetest.after(0, function()
				kick_and_delete_player_account(name)
			end)
			-- Event handled completely, stop propagation
			return true
		end
	end)

end

minetest.register_chatcommand("block", {
	params = "<playername>|<ASN>|<IP pattern>|-enable|-disable|-logging",
	privs = { ban = true },
	description = "Block new player account registration using IP pattern or ASN",
	func = function(name, param)

		local bantype, target
		if not param then
			return false
		elseif param:find("^-[eE]") then
			active = true
			cleanup()
			write_storage()
			return true, "Enabled IP/ASN based new account blocking"
		elseif param:find("^-[dD]") then
			active = false
			cleanup()
			write_storage()
			return true, "Disabled IP/ASN based new account blocking"
		elseif param:find(":") then
			bantype = "IPv6"
			target = param
		elseif param:find("^[0-9]+%.") then
			bantype = "IPv4"
			target = param
		elseif param:find("^[0-9]$") then
			bantype = "ASN"
			target = param
		elseif param:find("^[%w_]+$") then
			bantype = "player IP"
			target = minetest.get_player_ip(param)
			jail_player(name, param)
		else
			return false, "Invalid option"
		end

		-- Test pattern to catch possible lua pattern errors
		if not pcall(function() (""):find(target) end) then
			return false, "Target is not valid lua pattern for matching"
		end

		local expire = os.time() + 60 * 60 * 24 * 5
		if bantype == "ASN" then
			blacklist_asn[target] = { expire = expire }
		else
			blacklist_ip[target] = { expire = expire }
		end
		write_storage()

		local msg = "Blocked new accounts from " .. bantype .. " " .. target
		minetest.log("action", "[beowulf] "..msg)
		return true, msg..". Kick/ban/jail players if needed."
	end
})

-- Initialize data and cleanup if needed
read_storage()
if cleanup() then
	write_storage()
end
