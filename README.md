# Personal Respawn Anchor

A Factorio 2.0 mod that adds player-specific, surface-specific respawn anchors for cooperative multiplayer games.

Unlike force-wide spawn point mods, this mod keeps anchors personal:

- each player has their own anchor
- each surface or planet can have a different anchor
- placing an anchor does not move other players' respawn point
- after respawning, only that player is moved to their own anchor
- a map tag named `<player> spawn` marks the anchor location

This is intended for Space Age multiplayer saves where players spread across planets and death travel becomes tedious, without letting one player overwrite everyone else's spawn location.

## Install

Install from the Factorio Mod Portal:

https://mods.factorio.com/mod/personal-respawn-anchor

If you run a dedicated server, enable the same mod on the server and clients. Factorio will usually prompt clients to sync mods when they connect.

Do not enable this together with `respawn-beacon`; both mods affect respawn behavior and running both can be confusing.

## Balance

The technology unlocks after Military and Steel Processing, and costs automation + logistic science.

Recipe:

- 20 steel plate
- 40 stone brick
- 15 electronic circuits

The item stack size is 1, so anchors stay as deliberate base utility rather than disposable combat tools.

## Build

```powershell
just build
```

The Mod Portal zip is written to `target/`.

To copy it into the local server manager mod directory for testing:

```powershell
just install-local
```

## Checks

```powershell
just precommit
```

This runs gitleaks and builds the mod zip.

## Credits

This mod is inspired by the general idea of a placeable respawn anchor, including the public `respawn-beacon` mod by micaalle.

It is an independent implementation with separate code and separate assets. It does not copy `respawn-beacon` code, artwork, or thumbnail assets, and it does not use `force.set_spawn_position`.
