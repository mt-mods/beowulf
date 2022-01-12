minetest.register_on_joinplayer(function(player)
    local name = player:get_player_name()
    local info = minetest.get_player_information(name)
    if not info then
        -- simple sanity check, _should_ not happen ;)
        minetest.log("warning", "[beowulf] can't retrieve info, player '" .. name .. "' disappeared")
        return
    end

    local msg = "[beowulf] player '" .. name .. "' joined" ..
        " from " .. info.address .. " protocol_version: " .. info.protocol_version ..
        " formspec_version: " .. info.formspec_version ..
        " lang_code: " .. (info.lang_code or "<unknown")

    if info.version_string then
        -- "version_string" is only available if the engine was compiled in debug mode (or patched accordingly)
        msg = msg .. " version_string: " .. info.version_string
    end

    if info.serialization_version then
        msg = msg .. " serialization_version: " .. info.serialization_version
    end

    minetest.log("action", msg)
end)
