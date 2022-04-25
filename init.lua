local MP = minetest.get_modpath("beowulf")

dofile(MP.."/logging.lua")
dofile(MP.."/df_detect.lua")
dofile(MP.."/zipper_detect.lua")
dofile(MP.."/join_ratelimit.lua")

if minetest.settings:get_bool("beowulf.noclip_hurt.enable", false) then
	dofile(MP.."/noclip_hurt.lua")
end

if minetest.get_modpath("geoip") then
	dofile(MP.."/geoip_asn_kick.lua")
end
