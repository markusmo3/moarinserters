require "defines"
require("scripts/util")
require("scripts/gui")

game.onevent(defines.events.onpreplayermineditem, function(event)
  if isMoarInserter(event.entity) then
    -- splittedName = <type>-<range>-MIinserter-<direction>
    splittedName = moarinserters_stringsplit(event.entity.name, "-")
    basename = splittedName[1] .. "-" .. splittedName[2] .. "-" .. splittedName[3]
    if game.player.cursorstack ~= nil and game.player.cursorstack.name == "moar-inserters-wrench" then
      attributes = getAttributes(event.entity)
      attributes.name = basename .. "-" .. getNextDirection(splittedName[4], splittedName[1] == "alien")
      placeInserter(attributes)
    else
      game.player.insert{name = basename, count = 1}
    end
  elseif isGoldenMoarInserter(event.entity) then
    if game.player.cursorstack ~= nil and game.player.cursorstack.name == "moar-inserters-wrench" then
      oldGoldenAttributes = getAttributes(event.entity)
      showGoldenGui()
    else
      game.player.insert{name = "golden-MIinserter", count = 1}
    end
    
  end
end)

function isMoarInserter(entity)
  if entity ~= nil and entity.name ~= nil then
    if string.find(entity.name, "MIinserter") ~= nil then
      return (string.find(entity.name, "golden") == nil)
    end
  end
  return false
end

function isGoldenMoarInserter(entity)
  if entity ~= nil and entity.name ~= nil then
    if string.find(entity.name, "MIinserter") ~= nil then
      return (string.find(entity.name, "golden") ~= nil)
    end
  end
  return false
end

function getAttributes(someEntity)
  old = {}
  old.name = someEntity.name
  old.position = someEntity.position
  old.direction = someEntity.direction
  
  if string.find(someEntity.name, "smart") or string.find(someEntity.name, "alien") or string.find(someEntity.name, "golden") then
    old.filter = {}
    for i=1,5 do
      old.filter[i] = someEntity.getfilter(i)
    end
    old.condition = {}
    for i=0,2 do
      old.condition[i] = someEntity.getcircuitcondition(i)
    end
  end
  return old
end

function placeInserter(valueTable)
  newEntity = game.createentity {
    name = valueTable.name,
    position = valueTable.position,
    direction = valueTable.direction,
    force = game.forces.player
  }
  if valueTable.filter ~= nil then
    for i=1,5 do
      if valueTable.filter[i] ~= nil then 
        newEntity.setfilter(valueTable.filter[i], i)
      end
    end
  end
  if valueTable.condition ~= nil then
    for i=0,2 do
      if valueTable.condition[i] ~= nil then
        newEntity.setcircuitcondition(i, valueTable.condition[i])
      end
    end
  end
end

function rotateAntiClockwise(x, y)
  -- normally this is the formula to rotate clockwise in an standard coordinate system
  -- we use a coordinate system where +y is down tho, so this rotates anti-clockwise
  return stupidLuaMinusZero(y), stupidLuaMinusZero(-x)
end