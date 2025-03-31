
"beowulf" anticheat mod for Luanti

![Beowulf](Beowulf_and_the_dragon.jpg)

Image source: https://en.wikipedia.org/wiki/Beowulf_(hero)

![](https://github.com/mt-mods/beowulf/workflows/luacheck/badge.svg)

* State: **WIP**

# Features

* Kicks cheat clients if it detects a known version string
* Logs suspicious player movements
* Makes the `noclip` experience unpleasant

# Requirements

## Luanti must expose `version_string` in `core.get_player_information()`
   * Luanti provides this info without patches or using debug builds since version **5.11.0**.
      * See https://github.com/luanti-org/luanti/pull/15708 and https://github.com/luanti-org/luanti/commit/dd0070a6b8a28e2fe2ac591b3ea96813ba9ffcb0 for more information
   * Previous versions must be patched
      * Working patch: https://raw.githubusercontent.com/minetest-hosting/minetest-docker/c15e5aa5150a014c3a8bb3dfa1da41c67220a386/patches/player_debug_info.patch (can be applied using `patch -p1`)

# Settings

* **beowulf.dfdetect.enable_kick** if `true`: kicks the player if it detects a known cheat client, defaults to `false`
* **beowulf.dfdetect.kick_message** message to send if player is kicked for using a known cheat client.
   Defaults to _"Unsupported client, get official client from www.luanti.org"_ if not configured.
* **beowulf.noclip_hurt.enable** enables damage in common ground nodes to make the `noclip` experience as worse as possible (default: `false`)
* **beowulf.geoip_asn_kick.enable** enables kicking of blacklisted ASN's resolved by the `geoip` mod (default `false`)

# License

MIT
