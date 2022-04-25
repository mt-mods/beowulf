-- limits the amount of prejoins for an ip to 1/second
-- mitigates https://github.com/minetest/minetest/issues/11877 and https://github.com/minetest/minetest/issues/9498

local ratelimit = {}
local after = minetest.after
local LIMIT = 1

local function remove_entry(ip)
	ratelimit[ip] = nil
end

minetest.register_on_mods_loaded(function()
	table.insert(core.registered_on_prejoinplayers, 1, function(player, ip)
		if ratelimit[ip] then
			return "You are joining too fast, please try again"
		else
			ratelimit[ip] = true
			after(LIMIT, remove_entry, ip)
		end
	end)
end)