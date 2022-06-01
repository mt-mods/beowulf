-- taken from https://github.com/S-S-X/dftest/blob/master/init.lua
local has_beerchat = minetest.get_modpath("beerchat")

-- luacheck: push no max line length
local df = {
	"761e9c2ef", -- Merge pull request #49 from Bigjango13/master
	"f175bb78b", -- Fixed directory name
	"75d90311d", -- Fixed filename
	"5cb7974f2", -- Fix #47 and #46
	"d404517d2", -- Make LuaVoxelManipulator available to CSM API
	"1ccf88e80", -- minetest.dig_node: Remove node
	"950d2c9b3", -- Add ClientObjectRef:remove and return true in on_object_add callback to remove newly added object
	"fb4815c66", -- Merge pull request #35 from arydevy/patch-1
	"f12288814", -- Merge pull request #42 from Minetest-j45/master
	"f3082146c", -- remove irrlicht from lid dir (accident)
	"a3925db22", -- add airjump and remove unused headers
	"7824a4956", -- Merge pull request #1 from EliasFleckenstein03/master
	"35445d24f", -- Make set_pitch and set_yaw more accurate by not rounding it to integers
	"5131675a6", -- Add guards to stop server build fail
	"96a37aed3", -- Add minetest.get_send_speed
	"d08242316", -- Fix format
	"ce0d81a82", -- Change default cheat menu entry height
	"b7abc8df2", -- Add on_object_add callback
	"4f613bbf5", -- Include tile definitions in get_node_def; Client-side minetest.object_refs table
	"c86dcd0f6", -- Add on_object_hp_change callback and nametag images
	"b84ed7d0b", -- Call on_object_properties_change callback when adding object to scene
	"26cfbda65", -- Add on_object_properties_change callback
	"6dc7a65d9", -- Add ClientObjectRef:set_properties
	"7d7d4d675", -- Add ClientObjectRef.get_properties
	"ea8fa30b6", -- Changed README.md to fit the dragonfire client
	"c47eae316", -- Add table.combine to luacheckrc
	"83d09ffaf", -- Complete documentation
	"e0b4859e7", -- Add ClientObjectRef:remove
	"63f7c96ec", -- Fix legit_speed
	"5c06763e8", -- Add noise to client CSM API
	"7613d9bfe", -- Update .wielded command to output the entire itemstring; add LocalPlayer:get_hotbar_size
	"bc79c2344", -- CSM: Use server-like (and safe) HTTP API instead of Mainmenu-like
	"166968232", -- Port formspec API from waspsaliva This API is inofficial and undocumented; invalid usage causes the game to crash. Use at own risk!
	"e391ee435", -- Forcefully place items when minetest.place_node is used
	"546ab256b", -- Update buildbot to new MineClone2 repo and set the game name to MineClone2 rather than mineclone2
	"d3780cefd", -- Attempt to fix SEGFAULT in push_inventory
	"d1c84ada2", -- Merge minetest changes
	"74f5f033e", -- Add Custom version string
	"b2f629d8d", -- Logo improvements
	"78b7d1019", -- Add dragonfire logo
	"19e0528e3", -- Add minetest.get_nearby_objects
	"47d0882cc", -- Fix line containing only whitespace
	"4fedc3a31", -- Add minetest.interact
	"dc67f669e", -- Make the Cheat Menu size configureable
	"906845a87", -- Add minetest.registered_items and minetest.registered_nodes (Doesn't do anything yet)
	"3a4325902", -- Fixed crash by adding legacy stuff to defaultsettings (for now)
	"53c991c5f", -- Fixed crash due to missing entry in defaultsettings.cpp
	"0c6e0c717", -- Reorganize categories
	"e8faa2afb", -- Rework Range
	"a4d914ba2", -- Make GitHub Actions Happy try 3
	"a34c61093", -- Make GitHub Actions Happy try 2
	"f783f5939", -- Make GitHub Actions Happy try 1
	"8b58465aa", -- Remove obsolete code from clientenvironment
	"35c15567a", -- Update builtin/settingtypes.txt to the new philosophy
	"0c9e7466e", -- New Cheat Philosophy
	"a1e61e561", -- World Cheats improvements; Add BlockLava; Readd minetest.request_http_api for Compatibility
	"56d536ea5", -- Update CheatDB URL again
	"ce47003cc", -- Update defaults for ContentDB (->CheatDB)
	"89995efee", -- CheatDB Support & Enable/Disable CSMs in Main Menu
	"3df23e23c", -- Small AutoTool Fix
	"8b3eaf5b0", -- Lua API: Particle callbacks; Add NoWeather
	"0a285dd33", -- Remove NextItem
	"4695222bc", -- Fix and Improve AutoTool
	"5bead7daa", -- Added minetest.close_formspec
	"f825cf0e3", -- Fixed Minimap position
	"eaa8a5132", -- Fixed FastPlace and AutoPlace
	"b4e475726", -- Added configureable Colors for PlayerESP and EntityESP
	"549025f6a", -- EntityESP, EntityTracers, PlayerESP, PlayerTracers
	"eb6aca8b4", -- Merged Minetest
	"8de51dae9", -- Fixed crash when attempting to access nonexistant inventory from Lua API
	"a65251a7a", -- Fixed glowing GenericCAOs being rendered completely back when Fullbright is enabled
	"eaec3645b", -- Added ClientObjectRef:get_hp()
	"fb4d54ee3", -- Added minetest.register_on_play_sound
	"50629cc6a", -- Improved Scaffold
	"3d74e17cc", -- Added AutoSlip (-> Credit to Code-Sploit)
	"f9c632466", -- Added JetPack and AutoHit (-> Credits to Code-Sploit and cora)
	"843239c0b", -- Added Speed/Jump/Gravity Override
	"598e9bdbc", -- Update Credits
	"7d327def8", -- Improved AutoSneak
	"82216e147", -- LocalPlayer:set_physics_override; minetest.register_on_recieve_physics_override
	"4dd5ecfc5", -- Added setpitch & setyaw commands; AutoSprint
	"b65db98bd", -- Added OnlyTracePlayers
	"e16bbc1fb", -- Merge pull request #14 from corarona/master
	"1780adeea", -- lua-api: fix get/set_pitch
	"3e7c5d720", -- Possibility to use cheat menu while pressing other keys
	"0aa63aafc", -- Fixed warning
	"9db80fc6f", -- Run Lint Script
	"91ad0d049", -- Merge pull request #10 from corarona/master
	"6bda686c0", -- MapBlockMesh Performance Improvement
	"1bab49049", -- add LUA_FCT
	"6efa8a758", -- add g/s pitch and make_screenshot in lua api
	"46237330d", -- Several Enhancements
	"60a9ff6ff", -- api-screenshot: change function name to make_screenshot
	"1f56317d5", -- Added NodeESP
	"75ecaa217", -- Fix and run the Lint autocorrect script
	"6ccb5835f", -- Revert "Make Lint Happy"
	"244713971", -- Added script that automaticall corrects lint style
	"07e61e115", -- Fix github build problems #3
	"3af10766f", -- Fix github build problems #2
	"16d302c9a", -- Fix github build problems
	"ad148587d", -- Make Lint Happy
	"1145b05ea", -- Updated Credits
	"c9221730d", -- Updated Cheat Menu Color Design
	"1799d5aa9", -- Cheat Menu Improvements Change
	"fba7dc216", -- Merge pull request #8 from realOneplustwo/master
	"a7dc1135e", -- Added CheatHUD
	"f1d9ac014", -- Moved Killaura to Lua; Added ForceField; Added Friendlist; Added ClientObjectRef:is_local_player(); Documented LocalPlayer:get_object()
	"06b72069d", -- Fixed ColorChat
	"62958bd60", -- Reverted accidental commit in wrong repo
	"00d51fbd5", -- Armor textures support
	"7cbe42b1d", -- Re-Added Chat Effects
	"28f6a7970", -- lua api: add set/get_pitch
	"4f9797b6e", -- lua api: add core.take_screenshot()
	"8e9e76a50", -- Revert "Add Block Formspec Hack"
	"6652d7ac2", -- Add Block Formspec Hack
	"8bc7d49b3", -- Added Nuke
	"62cf9b466", -- Fix compile error
	"519f98c65", -- Merge pull request #3 from JosiahWI/ui_revamp
	"f236476af", -- Fix errors in cheatMenu.
	"7af3dee31", -- Merge pull request #2 from JosiahWI/ui_revamp
	"ea88dde4b", -- Added Strip, AutoRefill, indexing for InventoryActions and Wield Index starts at 1 now
	"7aff09ab2", -- Fix overindent!
	"aea9b36ef", -- Improved Colours
	"1ef72ad9c", -- Fix indentation style.
	"586241008", -- Add missing return.
	"b211e90ff", -- Prepare cheatMenu::draw function for easier UI changes.
	"e22e334e9", -- Merge pull request #1 from JosiahWI/ui_revamp
	"f605308ee", -- Improve drawEntry.
	"130d476f6", -- Changed Cheat Menu UI
	"f1ff05bf5", -- Added ThroughWalls, InventoryActions API and AutoTotem
	"1a7d3d818", -- Extended ClientObjectRef; Improved CrystalPvP
	"1e4f35492", -- This is the last try for lint...
	"7e0f8fba0", -- Another Lint commit
	"151e5782e", -- Lint is still not happy...
	"28a560684", -- Added the API additions from waspsaliva
	"c1aea404b", -- Lint is bitch
	"3a718f12b", -- Make lint happy; Remove stupid redirector
	"3b596a96e", -- Fixed Github build problems
	"847198edb", -- Edited .gitignore properly; fixed armor invulnarability in the server code.
	"bbcd24954", -- New Mod System
	"80f416d51", -- Added AttachmentFloat
	"cb1915efa", -- Added minetest.drop_selected_item(), Improved AutoEject
	"43ee069db", -- Improved X-Ray, added AutoEject
	"faa32610e", -- Added ESP, fixed Tracers, improved Jesus
	"ee88f4b94", -- Improved Tracers
	"c36ff3edb", -- Added AutoSneak and improved X-Ray MapBlock updating
	"0a2c90f4c", -- Only draw tracers to objects that are not attached (that fixes tracers to armor)
	"044a12666", -- Added Tracers, NoSlow and NoForceRotate; GUI Colors changed
	"b9f8f0a23", -- The Robot Update
	"af085acbd", -- Added Schematicas
	"0730ed216", -- Delete my stupid test mod lol
	"772c9629e", -- Unrestricted HTTP API for Client, Server and Main Menu
	"9b1030cac", -- Added minetest.get_inventory(location)
	"2321e3da4", -- Removed console output spammed by minetest.find_node_near
	"90f66dad8", -- Removed experimental code
	"8b4d27141", -- Fixed typo in clientmods/inventory/mod.conf
	"d8b8c1d31", -- Added Documentation for Additional API
	"6e6c68ba0", -- Added Chat Spam, Replace and settingtypes.txt for Clientmods
	"79d0314d7", -- Update Buildbots
	"770bde9c6", -- idk
	"e245151c5", -- Improved World hacks
	"19205f6b3", -- Improved World Hacks, added API functions
	"73b89703f", -- Improved World hacks, added fill
	"248dedaba", -- Added floationg water to BlockWater
	"9dc3eb777", -- Fixed broken Chatcommands
	"80371bc16", -- Added .listwarps
	"1c29f21e0", -- Imporoved set_wield_index() to include camera update
	"3bed0981d", -- UI Update; Added AutoTool
	"622d54726", -- Added DestroyWater (:P anon)
	"9019e18b9", -- Some Updates
	"107dec6c0", -- Added Coords
	"f1760622e", -- Added BrightNight
	"2675bcca1", -- Added more cheats
	"3d980cf57", -- Improved Xray and Fullbright
	"f7a042223", -- Added cheat Menu
	"344fddc17", -- Improved Killaura and Chat position
	"678559bb6", -- removed leagcy clientmods
	"9194165cf", -- Added autodig, moved chat
	"064c25caa", -- Added EntitySpeed
	"5a8610c2f", -- Added customizable keybindings, improved freecam, added special inventory keybind (by default ender inventory)
	"83f59484d", -- Fixed 5.4.0-dev build
	"ffe3c2ae0", -- Update to minetest 5.4.0-dev
	"45aa2516b", -- Added settings
	"f22339ed8", -- Removed fast killaura
	"408e39a1d", -- Added Anti Knockback
	"eee0f960b", -- Removed minetest.conf.old
	"39d7567c1", -- Fixed Crash
	"305e0e0d3", -- Auto disable smooth lighting when fullbright is active
	"6796baec6", -- Defaultsettings
	"5a2bf6634", -- Added Clientmods
	"e610149c0", -- Initial Commit
	"68f9263a2", -- Hacked Client
	"90d885506", -- GalwayGirl Client
}

--[[
To update commit list: save commit logs for master branches of minetest in mt.log and dragonfire in df.log
For example (assuming you have added dragonfire remote, adapt if not):
$ git log --oneline origin/master > mt.log; git log --oneline dragonfire/master > df.log

Find and drop commits that seems to exist in both remotes, print rest of it:
$ sort -k3 <(awk '{print NR" "$0}' df.log mt.log mt.log) | uniq -uf2 | sort -nk1 | sed -r 's/^[^ ]+ ([^ ]+) (.*)$/\t"\1", -- \2/'

Replace above entries with output
--]]
-- luacheck: pop

local function dfver(s) for _,v in ipairs(df) do if s:find(v) then return v end end end

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	local info = minetest.get_player_information(name)
	local version = info.version_string

	if not version then
		-- version not available
		return
	end

	local dfv = version:find("dragonfire") or dfver(version)
	if dfv then
		local msg = "Unsupported client detected: " .. dfv .. " player: " .. name
		minetest.log("action", "[beowulf] " .. msg)
		if has_beerchat then
			beerchat.on_channel_message(beerchat.moderator_channel_name, "DF-Detect", msg)
			beerchat.send_on_channel("DF-Detect", beerchat.moderator_channel_name, msg)
		end

		if minetest.settings:get_bool("beowulf.dfdetect.enable_kick", false) then
			minetest.kick_player(name, "Unsupported client")
		end
	end

end)
