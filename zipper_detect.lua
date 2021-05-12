-- detects if a custom client "zips" around the map without interacting

local has_beerchat = minetest.get_modpath("beerchat")


-- per-player data
local player_data = {}

local function get_player_data(name)
    if not player_data[name] then
        -- create data
        player_data[name] = {
            -- number of "strikes" (odd movements)
            strikes = 0,
            -- number of checks
            checked = 0
        }
    end

    return player_data[name]
end

-- cleanup after the player leaves
minetest.register_on_leaveplayer(function(player)
    player_data[player:get_player_name()] = nil
end)


local function track_player(player)
    local name = player:get_player_name()
    local data = get_player_data(name)
    local pos = player:get_pos()

    if data.previous_position then
        -- compare positions
        local d = vector.distance(pos, data.previous_position)
        if d > 200 then
            data.strikes = data.strikes + 1
        end
        data.checked = data.checked + 1
    end

    if data.checked >= 10 then
        -- check strike-count after 10 movement checks
        if data.strikes > 8 then
            -- suspicious movement, log it
            -- TODO: if this doesn't yield any false-positives, add a kick/ban option
            local msg = "suspicious movement detected for player: '" .. name .. "'"
            minetest.log("action", "[beowulf] " .. msg)
            if has_beerchat then
                beerchat.send_on_channel("Zipper-Detect", beerchat.moderator_channel_name, msg)
            end
        end

        -- reset counters
        data.checked = 0
        data.strikes = 0
    end

    -- store current position
    data.previous_position = pos
end

local function interval_fn()
    for _, player in ipairs(minetest.get_connected_players()) do
        track_player(player)
    end
    minetest.after(1, interval_fn)
end

minetest.register_on_mods_loaded(function() minetest.after(1, interval_fn) end)
