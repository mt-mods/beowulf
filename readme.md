
"beowulf" anticheat mod for minetest

![Beowulf](Beowulf_and_the_dragon.jpg)

Image source: https://en.wikipedia.org/wiki/Beowulf_(hero)

![](https://github.com/mt-mods/beowulf/workflows/luacheck/badge.svg)

# Features

* Kicks dragonfire clients if it detects a known version string
* Logs suspicious player movements
* Makes the `noclip` experience unpleasant

# Requirements

* Some functionality needs an engine debug-build or patch to expose the `version_string` in `minetest.get_player_information()`.

# Settings

| Configuration key                   | Default | Description
| ----------------------------------- | ------- | -------------------------------
| `beowulf.dfdetect.enable_kick`      | `true`  | If `true` kicks the player if it detects a dragonfire version string.
| `beowulf.noclip_hurt.enable`        | `false` | Enables damage in common ground nodes to make the `noclip` experience as worse as possible (default: `false`).
| `beowulf.geoip_asn_kick.enable`     | `false` | Enables kicking of blacklisted ASN's resolved by the `geoip` mod (default `false`).
| `beowulf.create_account_ban.enable` | `true`  | Enables new account ban functionality, allows banning account creation by IP pattern or with geoip also by ASN.

# License

MIT
