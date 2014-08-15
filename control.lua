require "defines"
require("scripts/util")

game.onevent(defines.events.onpreplayermineditem, function(event)
  if isMoarInserter(event.entity) then
    -- splittedName = <type>-<range>-MIinserter-<direction>
    splittedName = moarinserters_stringsplit(event.entity.name, "-")
    basename = splittedName[1] .. "-" .. splittedName[2] .. "-" .. splittedName[3]
    if game.player.cursorstack ~= nil and game.player.cursorstack.name == "moar-inserters-wrench" then
      newEntity = game.createentity {
        name = basename .. "-" .. getNextDirection(splittedName[4], splittedName[1] == "alien"),
        position = event.entity.position,
        direction = event.entity.direction,
        force = game.forces.player
      }
      if splittedName[1] == "smart" or splittedName[1] == "alien" then
        for i=1,5 do
          oldFilter = event.entity.getfilter(i)
          if oldFilter ~= nil then 
            newEntity.setfilter(oldFilter, i)
          end
        end
        for i=0,2 do
          oldCondition = event.entity.getcircuitcondition(i)
          if oldCondition ~= nil then
            newEntity.setcircuitcondition(i, oldCondition)
          end
        end
      end
    else
      game.player.insert{name = basename, count = 1}
    end
  end
end)

function isMoarInserter(entity)
  if entity ~= nil and entity.name ~= nil then
    return string.find(entity.name, "MIinserter") ~= nil
  end
  return false
end

function getNextDirection(directionArg, isAlien)
  if isAlien then
    if directionArg == "lower_left" then
      return "left"
    elseif directionArg == "left" then
      return "upper_left"
    elseif directionArg == "upper_left" then
      return "straight"
    elseif directionArg == "straight" then
      return "upper_right"
    elseif directionArg == "upper_right" then
      return "right"
    elseif directionArg == "right" then
      return "lower_right"
    elseif directionArg == "lower_right" then
      return "lower_left"
    end
  else
    if directionArg == "left" then
      return "straight"
    elseif directionArg == "straight" then
      return "right"
    elseif directionArg == "right" then
      return "left"
    end
  end
  return "failing getNextDirection()"
end