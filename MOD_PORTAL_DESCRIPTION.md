# Personal Respawn Anchor

Personal Respawn Anchor adds a placeable respawn anchor for multiplayer games.

Unlike force-wide spawn point mods, this mod keeps anchors personal:

- each player has their own anchor
- each surface/planet can have a different anchor
- placing an anchor does not move other players' respawn point
- after respawning, only that player is moved to their own anchor
- a map tag named `<player> spawn` marks the anchor location

This is intended for cooperative Space Age saves where players spread across planets and death travel becomes tedious, but you do not want one player to overwrite everyone else's spawn location.

## Notes

This mod is inspired by the simple respawn-anchor idea, including the public `respawn-beacon` mod by micaalle, but it is an independent implementation with separate code and separate assets. It does not depend on `respawn-beacon`.

If you previously used `respawn-beacon`, disable it before enabling this mod. Running both at the same time can produce confusing respawn behavior.

## Balance

The technology unlocks after Military and Steel Processing, and costs automation + logistic science. The anchor recipe is intentionally simple:

- 20 steel plate
- 40 stone brick
- 15 electronic circuits

The item stack size is 1 so anchors remain a deliberate base utility rather than a disposable combat tool.
