local anchor_name = "personal-respawn-anchor"

local function ensure_storage()
  storage.personal_respawn_anchor = storage.personal_respawn_anchor or {}
  storage.personal_respawn_anchor_units = storage.personal_respawn_anchor_units or {}
end

local function player_key(player)
  return tostring(player.index)
end

local function surface_key(surface)
  return surface.name
end

local function destroy_tag(anchor)
  if anchor and anchor.tag and anchor.tag.valid then
    anchor.tag.destroy()
  end
end

local function create_tag(player, surface, position)
  return player.force.add_chart_tag(surface, {
    position = position,
    icon = {type = "item", name = anchor_name},
    text = player.name .. " spawn"
  })
end

local function anchor_position(entity)
  local offset_y = settings.global["personal-respawn-anchor-offset-y"].value
  return {
    x = entity.position.x,
    y = entity.position.y + offset_y
  }
end

local function player_surface_anchors(player)
  ensure_storage()
  local key = player_key(player)
  storage.personal_respawn_anchor[key] = storage.personal_respawn_anchor[key] or {}
  return storage.personal_respawn_anchor[key]
end

local function set_anchor(player, entity)
  local anchors = player_surface_anchors(player)
  local surface = entity.surface
  local position = anchor_position(entity)
  local key = surface_key(surface)
  destroy_tag(anchors[key])
  if anchors[key] and anchors[key].unit_number then
    storage.personal_respawn_anchor_units[anchors[key].unit_number] = nil
  end

  anchors[key] = {
    x = position.x,
    y = position.y,
    surface = surface.name,
    unit_number = entity.unit_number,
    tag = create_tag(player, surface, position)
  }
  storage.personal_respawn_anchor_units[entity.unit_number] = {
    player = player_key(player),
    surface = key
  }

  player.print(
    "Personal respawn anchor set on " ..
      surface.name .. " at X: " .. position.x .. ", Y: " .. position.y
  )
end

local function clear_anchor_entity(entity)
  ensure_storage()
  local owner = storage.personal_respawn_anchor_units[entity.unit_number]
  if not owner then
    return
  end

  local anchors = storage.personal_respawn_anchor[owner.player]
  local current = anchors and anchors[owner.surface]
  if current and current.unit_number == entity.unit_number then
    destroy_tag(current)
    anchors[owner.surface] = nil
    storage.personal_respawn_anchor_units[entity.unit_number] = nil

    local player = game.get_player(tonumber(owner.player))
    if player then
      player.print("Personal respawn anchor cleared on " .. entity.surface.name)
    end
  end
end

local function teleport_to_anchor(player)
  if not player.character then
    return
  end

  local anchors = player_surface_anchors(player)
  local current = anchors[surface_key(player.surface)]
  if not current then
    return
  end

  local surface = game.surfaces[current.surface]
  if not surface then
    anchors[surface_key(player.surface)] = nil
    return
  end

  local destination = surface.find_non_colliding_position(
    "character",
    {x = current.x, y = current.y},
    16,
    0.5
  ) or {x = current.x, y = current.y}

  player.teleport(destination, surface)
  player.print(
    "Respawned at personal anchor on " ..
      surface.name .. " X: " .. destination.x .. ", Y: " .. destination.y
  )
end

script.on_init(ensure_storage)
script.on_configuration_changed(ensure_storage)

script.on_event(defines.events.on_built_entity, function(event)
  local entity = event.entity
  if entity and entity.valid and entity.name == anchor_name then
    local player = game.get_player(event.player_index)
    if player then
      set_anchor(player, entity)
    end
  end
end)

script.on_event(defines.events.on_robot_built_entity, function(event)
  local entity = event.entity
  if entity and entity.valid and entity.name == anchor_name then
    local last_user = entity.last_user
    if last_user then
      set_anchor(last_user, entity)
    end
  end
end)

script.on_event(defines.events.on_player_mined_entity, function(event)
  local entity = event.entity
  if entity and entity.valid and entity.name == anchor_name then
    clear_anchor_entity(entity)
  end
end)

script.on_event(defines.events.on_entity_died, function(event)
  local entity = event.entity
  if entity and entity.valid and entity.name == anchor_name then
    clear_anchor_entity(entity)
  end
end)

script.on_event(defines.events.on_player_respawned, function(event)
  local player = game.get_player(event.player_index)
  if player then
    teleport_to_anchor(player)
  end
end)
