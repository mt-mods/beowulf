
"beowulf" anticheat mod for minetest

![Beowulf](Beowulf_and_the_dragon.jpg)

Image source: https://en.wikipedia.org/wiki/Beowulf_(hero)

![](https://github.com/mt-mods/beowulf/workflows/luacheck/badge.svg)

* State: **WIP**

# Features

* Kicks cheat clients if it detects a known version string
* Logs suspicious player movements
* Makes the `noclip` experience unpleasant

# Requirements

* Needs an engine debug-build or patch to expose the `version_string` in `minetest.get_player_information()`
* Luanti is going to provide this info without patches or specialized builds ([#22](https://github.com/mt-mods/beowulf/issues/22)).

# Settings

* **beowulf.dfdetect.enable_kick** if `true`: kicks the player if it detects a known cheat client, defaults to `false`
* **beowulf.dfdetect.kick_message** message to send if player is kicked for using a known cheat client.
   Defaults to _"Unsupported client, get official client from www.luanti.org"_ if not configured.
* **beowulf.noclip_hurt.enable** enables damage in common ground nodes to make the `noclip` experience as worse as possible (default: `false`)
* **beowulf.geoip_asn_kick.enable** enables kicking of blacklisted ASN's resolved by the `geoip` mod (default `false`)

# License

MIT
