data:extend({
  {
    type = "recipe",
    name = "personal-respawn-anchor",
    enabled = false,
    ingredients = {
      {type = "item", name = "steel-plate", amount = 20},
      {type = "item", name = "stone-brick", amount = 40},
      {type = "item", name = "electronic-circuit", amount = 15}
    },
    results = {
      {type = "item", name = "personal-respawn-anchor", amount = 1}
    }
  },
  {
    type = "item",
    name = "personal-respawn-anchor",
    icon = "__personal-respawn-anchor__/graphics/personal-respawn-anchor.png",
    icon_size = 128,
    subgroup = "transport",
    stack_size = 1,
    place_result = "personal-respawn-anchor"
  },
  {
    type = "container",
    name = "personal-respawn-anchor",
    icon = "__personal-respawn-anchor__/graphics/personal-respawn-anchor.png",
    icon_size = 128,
    collision_box = {{-1.5, -1.5}, {1.5, 1.5}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    flags = {"placeable-neutral", "player-creation", "placeable-off-grid"},
    minable = {mining_time = 0.5, result = "personal-respawn-anchor"},
    max_health = 100,
    corpse = "small-remnants",
    inventory_size = 0,
    picture = {
      filename = "__personal-respawn-anchor__/graphics/personal-respawn-anchor.png",
      priority = "extra-high",
      width = 128,
      height = 128,
      scale = 1
    },
    order = "b[personal-respawn-anchor]"
  },
  {
    type = "technology",
    name = "personal-respawn-anchor-tech",
    icon = "__personal-respawn-anchor__/graphics/personal-respawn-anchor.png",
    icon_size = 128,
    effects = {
      {
        type = "unlock-recipe",
        recipe = "personal-respawn-anchor"
      }
    },
    prerequisites = {"military", "steel-processing"},
    unit = {
      count = 150,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1}
      },
      time = 25
    },
    order = "e-p-a"
  }
})
