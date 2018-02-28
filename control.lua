require 'stdlib/log/logger'
local pos = require('stdlib/area/position')

LOGGER = Logger.new('NestleMod')

function LogTable(t, depth, ws)
  depth = depth or 1
  ws = ws or ""
  for k,v in pairs(t) do
    LOGGER.log(ws .. "_______________")
    LOGGER.log(ws..tostring(k))
    LOGGER.log(ws..tostring(v))
    if (type(v) == "table") and (depth > 0) then
      LogTable(v, depth -1, ws .. "\t")
    end
    LOGGER.log(ws.."------------------")
  end
  LOGGER.write()
end

function update()
  LOGGER.log("Update!")

  global.satisfaction = global.satisfaction - settings.global["satisfaction-reduction"]

  LOGGER.log("Satisfaction: " .. global.satisfaction)

  game.forces["enemy"].set_cease_fire(game.forces["player"], global.satisfaction > 0)

  if global.satisfaction < settings.global["satisfaction-threshold"] then
    local surface = game.surfaces["nauvis"]

    local malls = surface.find_entities_filtered{name="mall"}

    for i = 1, #malls, 1 do
      if global.customers[malls[i]] == nil then
        LOGGER.log("Init pick up!")
        local enemy = surface.find_nearest_enemy{position = malls[i].position, max_distance = 50000}
        if enemy ~= nil then
          LOGGER.log("Enemy found!")
          enemy.set_command({type=defines.command.go_to_location, destination=malls[i].position, distraction=defines.distraction.by_damage})
          global.customers[malls[i]] = enemy
        end
      end
      local customer = global.customers[malls[i]]
      if not customer.has_command() then
        customer.set_command({type=defines.command.go_to_location, destination=malls[i].position, distraction=defines.distraction.by_damage})
      end
      local dist = pos.distance(customer.position,malls[i].position)
      LOGGER.log(dist)
      if (dist < 5) and ((global.satisfied[customer] == nil) or (global.satisfied[customer] > 0)) then
        LOGGER.log("Pick Up")
        customer.set_command({type=defines.command.go_to_location, destination=customer.spawner.position, distraction=defines.distraction.by_damage})
        local inv = malls[i].get_inventory(defines.inventory.chest)
        local taken = inv.remove({name="consumer-goods", count=5})
        global.satisfaction = global.satisfaction + taken * settings.global["satisfaction-increase"]
        global.satisfied[customer] = 5
      end
      if global.satisfied[customer] and (global.satisfied[customer] > 0) then
        global.satisfied[customer] = global.satisfied[customer] - 1
      end
    end
  end

  LOGGER.write()
end

script.on_nth_tick(60,update)

script.on_init(function()
  LOGGER.log("Begin Initialization!")

  global.satisfaction = 0
  global.customers = {}
  global.satisfied = {}

  LOGGER.log("End Initialization!")
end)
