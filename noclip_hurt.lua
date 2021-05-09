
-- list of nodes to enable damage on
local node_list = {}

if minetest.get_modpath("default") then
    table.insert(node_list, "default:stone")
end

for _, nodename in ipairs(node_list) do
    minetest.override_item(nodename, {
        damage_per_second = 5
    })
end
