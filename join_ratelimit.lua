-- limits the amount of prejoins for an ip to 1/second
-- mitigates https://github.com/minetest/minetest/issues/11877 and https://github.com/minetest/minetest/issues/9498

local ratelimit = {}

local function remove_entry(ip)
    ratelimit[ip] = nil
end

table.insert(minetest.registered_on_prejoinplayers, 1, function(_, ip)
    if ratelimit[ip] then
        return "You are joining too fast, please try again"
    else
        ratelimit[ip] = true
        minetest.after(1, remove_entry, ip)
    end
end)