data:extend(
{
  {
    type = "technology",
    name = "alien-culture",
    icon_size = 32,
    icon = "__base__/graphics/icons/market.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "consumer-goods"
      },
      {
        type = "unlock-recipe",
        recipe = "mall"
      }
    },
    unit =
    {
      count = 30,
      ingredients = {{"science-pack-1", 1},{"science-pack-2", 1}},
      time = 10
    }
  },
  {
    type = "recipe",
    name = "consumer-goods",
    enabled = false,
    energy_required = 2,
    ingredients =
    {
      {"iron-plate", 1},
      {"steel-plate", 1},
      {"electronic-circuit", 1}
    },
    result = "consumer-goods"
  },
  {
    type = "recipe",
    name = "mall",
    enabled = false,
    energy_required = 2,
    ingredients =
    {
      {"iron-plate", 2},
      {"iron-gear-wheel", 2},
      {"electronic-circuit", 2}
    },
    result = "mall"
  },
  {
    type = "item",
    name = "consumer-goods",
    icons = {{
      icon = "__base__/graphics/icons/alien-artifact-goo.png",
      icon_size = 32,
      tint={r=0.1,g=0.7,b=0.2,a=1}
    }},
    flags={"goes-to-main-inventory"},
    stack_size = 50
  },
  {
    type = "item",
    name = "mall",
    icon = "__base__/graphics/icons/market.png",
    icon_size = 32,
    flags={"goes-to-main-inventory"},
    stack_size = 50,
    place_result = "mall"
  },
  {
    type = "container",
    name = "mall",
    inventory_size = 2,
    icon = "__base__/graphics/icons/market.png",
    icon_size = 32,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 5, result = "mall"},
    max_health = 150,
    corpse = "big-remnants",
    collision_box = {{-1.4, -1.4}, {1.4, 1.4}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    picture =
    {
      filename = "__base__/graphics/entity/market/market.png",
      width = 156,
      height = 127,
      shift = {0.95, 0.2}
    }
  }
})
